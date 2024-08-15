import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/features/home/repositories/home_local_repository.dart';
import 'package:spotify_clone/features/home/repositories/home_repository.dart';

import '../../../core/providers/current_user_notifier.dart';
import '../model/Song.dart';

part 'home_viewmodel.g.dart';

@riverpod
Future<List<Song>> getAllSongs(GetAllSongsRef ref) async {
  final token = ref.watch(currentUserNotifierProvider)!.token;

  final res =
      await ref.read(homeRepositoryProvider).getAllSongs(token: token ?? '');

  return switch (res) {
    Left(value: final l) => throw l,
    Right(value: final r) => r
  };
}

@riverpod
Future<List<Song>> getFavoriteSongs(GetFavoriteSongsRef ref) async {
  final token = ref.watch(currentUserNotifierProvider)!.token;

  final res = await ref.read(homeRepositoryProvider).getAllFavorite(
        token: token ?? '',
      );

  return switch (res) {
    Left(value: final l) => throw l,
    Right(value: final r) => r
  };
}

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  late HomeLocalRepository _homeLocalRepository;
  late HomeRepository _homeRepository;

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
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
      hexCode: '#${color.value.toRadixString(16)}',
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

  List<Song> getRecentSongs() {
    return _homeLocalRepository.loadSongs();
  }

  Future<void> favoriteSong(String songId) async {
    final val = switch (await _homeRepository.favoriteSong(
        songId: songId,
        token: ref.read(currentUserNotifierProvider)!.token ?? '')) {
      Left(value: final l) => throw l,
      Right(value: final r) => _favSongSuccess(true, songId)
    };
  }

  Future<void> unfavoriteSong(String songId) async {
    final val = switch (await _homeRepository.unFavoriteSong(
        songId: songId,
        token: ref.read(currentUserNotifierProvider)!.token ?? '')) {
      Left(value: final l) => throw l,
      Right(value: final r) => _favSongSuccess(false, songId)
    };
  }

  AsyncValue _favSongSuccess(bool isFavorited, String songId) {
    final userNotifier = ref.read(currentUserNotifierProvider.notifier);
    if (isFavorited) {
      userNotifier.setUser(ref.read(currentUserNotifierProvider)!.copyWith(
          favoriteSongs: [
            ...ref.read(currentUserNotifierProvider)!.favoriteSongs!,
            songId
          ]));
    } else {
      userNotifier.setUser(
          ref.read(currentUserNotifierProvider)!.copyWith(favoriteSongs: [
        ...ref
            .read(currentUserNotifierProvider)!
            .favoriteSongs!
            .where((fav) => fav != songId)
      ]));
    }

    return state = AsyncValue.data(null);
  }
}
