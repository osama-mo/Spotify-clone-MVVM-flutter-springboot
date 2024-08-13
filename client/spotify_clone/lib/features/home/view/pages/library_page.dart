import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/providers/current_user_notifier.dart';
import 'package:spotify_clone/features/home/repositories/home_repository.dart';

class LibraryPage extends ConsumerWidget {
  HomeRepository homeRepository = HomeRepository();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);

    void getSongs() async {
      await homeRepository.getAllSongs(token: currentUser!.token ?? '');
    }

    getSongs();
    return const Scaffold(
      body: Center(
        child: Text('Library page'),
      ),
    );
  }
}
