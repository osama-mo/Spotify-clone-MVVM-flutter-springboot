import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/User.dart';
import '../repositories/auth_remote_repository.dart';



part 'auth_viewmodel.g.dart';


@riverpod
class AuthViewModel extends _$AuthViewModel {

  late AuthRemoteRepository _authRemoteRepository;

  @override
  AsyncValue<dynamic> build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    return AsyncValue.data(0);
  }

  Future<void> login(String username, String password) async {
    final result = await AuthRemoteRepository().login(username, password);
    result.fold((l) {
      state = AsyncValue.error(l,StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }


  Future<void> signup(String name, String email, String password) async {
    state = const AsyncValue.loading();
    final result = await _authRemoteRepository.signup(name: name, email: email, password: password);
    result.fold(
      (l) {
      state = AsyncValue.error(l,StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }
}