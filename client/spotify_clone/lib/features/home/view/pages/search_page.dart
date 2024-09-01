import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:spotify_clone/core/constants/server_constant.dart';
import 'package:spotify_clone/core/providers/current_searchterm_notifier.dart';
import 'package:spotify_clone/core/theme/app_pallete.dart';
import 'package:spotify_clone/core/widgets/Loader.dart';
import 'package:spotify_clone/features/home/viewmodel/home_viewmodel.dart';

import '../../../../core/providers/current_song_notifier.dart';
import '../../../../core/providers/current_user_notifier.dart';
import '../../model/Song.dart';
import '../../repositories/home_repository.dart';

final searchSongsProvider = FutureProvider<List<Song>>((ref) async {
    final searchText =
        ref.watch(currentSearchTermNotifierProvider.notifier).state;
    final token = ref.watch(currentUserNotifierProvider)!.token;

    final res = await ref.read(homeRepositoryProvider).searchSongs(
          ref.watch(currentSearchTermNotifierProvider.notifier).state,
          token,
        );
    if (res.isLeft()) {
      log("its fucking left thats why");
    }
    else{
      log("its right appearently");
    }
    return switch (res) { Left(value: final l) => [], Right(value: final r) => r };
  });



class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search for songs...',
                prefixIcon: Icon(CupertinoIcons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Update the search term using ref.read to avoid unwanted rebuilds
                ref.read(currentSearchTermNotifierProvider.notifier).setTerm(value);
                
                // Manually trigger the searchSongsProvider to update
                ref.refresh(searchSongsProvider);
              },
            ),
          ),
          Expanded(
            child: ref.watch(searchSongsProvider).when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(
                    child: Text('No results found'),
                  );
                }
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final song = data[index];
                    return ListTile(
                      onTap: () {
                        ref
                            .read(currentSongNotifierProvider.notifier)
                            .updateSong(song);
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          ServerConstant.BASE_URL +
                              "/songs/coverArt/" +
                              song.thumbnail_url,
                        ),
                        radius: 35,
                        backgroundColor: AppPallete.backgroundColor,
                      ),
                      title: Text(
                        song.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        song.artist,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                );
              },
              error: (error, st) {
                return Center(
                  child: Text(error.toString()),
                );
              },
              loading: () =>  Loader(),
            ),
          ),
        ],
      ),
    );
  }
}
