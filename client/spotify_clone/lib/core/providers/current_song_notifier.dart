import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone/core/constants/server_constant.dart';
import 'package:spotify_clone/features/home/repositories/home_local_repository.dart';

import '../../features/home/model/Song.dart';

part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  late HomeLocalRepository _homeLocalRepository;
  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  @override
  Song? build() {
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  void updateSong(Song song) async {
    audioPlayer?.dispose();
    audioPlayer = AudioPlayer();
    final songUrl =
        ServerConstant.BASE_URL + "/songs/songFile/" + song.song_url;
    final audioSource = AudioSource.uri(Uri.parse(songUrl),
        tag: MediaItem(
            id: song.id,
            title: song.title,
            artist: song.artist,
            artUri: Uri.parse(ServerConstant.BASE_URL +
                "/songs/coverArt/" +
                song.thumbnail_url)));
    await audioPlayer!.setAudioSource(audioSource);

    audioPlayer!.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        audioPlayer!.seek(Duration.zero);
        audioPlayer!.pause();
        isPlaying = false;
        state = state?.copyWith(hexCode: state!.hexCode);
      }
    });

    _homeLocalRepository.uploadSong(song);

    audioPlayer!.play();
    isPlaying = true;
    state = song;
  }

  void seek(double val) {
    final duration = audioPlayer!.duration;
    final seekPosition = duration!.inMicroseconds * val;
    audioPlayer!.seek(Duration(microseconds: seekPosition.toInt()));
  }

  void playPause() {
    if (isPlaying) {
      audioPlayer!.pause();
    } else {
      audioPlayer!.play();
    }
    isPlaying = !isPlaying;
    state = state?.copyWith(hexCode: state!.hexCode);
  }
}
