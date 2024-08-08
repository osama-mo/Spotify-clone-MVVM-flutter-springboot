import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/providers/current_user_notifier.dart';
import 'package:spotify_clone/features/auth/repositories/auth_local_repository.dart';

import '../model/User.dart';
import '../repositories/auth_remote_repository.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<dynamic> build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return AsyncValue.data(0);
  }

  Future<void> init() async {
    await _authLocalRepository.init();
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    final result = await AuthRemoteRepository().login(username, password);
    log(result.toString());
    result.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
      _authLocalRepository.saveToken(r.token!);
      _currentUserNotifier.setUser(r);
    });
  }

  Future<void> signup(String name, String email, String password) async {
    state = const AsyncValue.loading();
    final result = await _authRemoteRepository.signup(
        name: name, email: email, password: password);
    log(result.toString());
    result.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }

  Future<User?> getData() async {
    state = const AsyncValue.loading();
    final token = await _authLocalRepository.getToken();

    if (token != null) {
      final result = await _authRemoteRepository.getCurrentUserData(token);
      User? val;
      result.fold((l) {
        state = AsyncValue.error(l, StackTrace.current);
        val = null;
      }, (r) {
        state = AsyncValue.data(r);
        val = r;
        _currentUserNotifier.setUser(val!);
      });
      return val;
    }

    return null;
  }
}
