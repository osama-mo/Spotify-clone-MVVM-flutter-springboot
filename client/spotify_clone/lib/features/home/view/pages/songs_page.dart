import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../viewmodel/home_viewmodel.dart';

class SongsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Text(
            'Latest Today',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ref.watch(getAllSongsProvider).when(
              data: (songs) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(songs[index].thumbnail_url),
                                    fit: BoxFit.cover)),
                          ),
                        ],
                      );
                    });
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text(error.toString()))
        ],
      ),
    ));
  }
}
