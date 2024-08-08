import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/providers/current_user_notifier.dart';
import 'package:spotify_clone/features/auth/view/pages/signin_page.dart';
import 'package:spotify_clone/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:spotify_clone/features/home/view/pages/upload_song_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();

  await container.read(authViewModelProvider.notifier).init();
  await container.read(authViewModelProvider.notifier).getData();

  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currnetUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
        title: 'Spotify Clone',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: currnetUser == null
            ?  const SignInPage()
            :  UploadSongPage());
  }
}
