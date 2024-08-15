import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/constants/server_constant.dart';

import '../../../../core/providers/current_song_notifier.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../viewmodel/home_viewmodel.dart';

class SongsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSongs =
         ref.watch(homeViewmodelProvider.notifier).getRecentSongs();
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: GridView.builder(
              itemCount: recentSongs.length,
              padding: const EdgeInsets.all(10),
              
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  ref
                      .read(currentSongNotifierProvider.notifier)
                      .updateSong(recentSongs[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppPallete.borderColor,
                      borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                          Container(
                            width: 56,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "${ServerConstant.BASE_URL}/songs/coverArt/${recentSongs[index].thumbnail_url}",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomLeft: Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              recentSongs[index].title,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          )
                        ],
                ),
                
                ),
                
              );
            }
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Latest Today',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ref.watch(getAllSongsProvider).when(
              data: (songs) {
                return SizedBox(
                  height: 270,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(currentSongNotifierProvider.notifier)
                                .updateSong(songs[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 180,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${ServerConstant.BASE_URL}/songs/coverArt/${songs[index].thumbnail_url}"),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    songs[index].title,
                                    style: const TextStyle(
                                      color: AppPallete.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    songs[index].artist,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppPallete.subtitleText,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text(error.toString()))
        ],
      ),
    ));
  }
}
