

import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/home/repositories/home_repository.dart';

import '../../../core/providers/current_user_notifier.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewmodel extends _$HomeViewmodel {

  late HomeRepository _homeRepository;

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required Color color,
  }) async {
    state = AsyncValue.loading();
    final res = await _homeRepository.uploadSong(
      selectedAudio: selectedAudio,
      selectedThumbnail: selectedThumbnail,
      songName: songName,
      artist: artist,
      hexCode: '#${color.value.toRadixString(16)}' ,
      uploadedBy: ref.read(currentUserNotifierProvider)!.name ?? '',
      token: ref.read(currentUserNotifierProvider)!.token ?? '',
    );

    res.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });

    log(res.toString());
  }
  
}