

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/core/theme/app_pallete.dart';
import 'package:spotify_clone/features/home/repositories/home_repository.dart';
import 'package:spotify_clone/features/home/view/pages/library_page.dart';
import 'package:spotify_clone/features/home/view/pages/songs_page.dart';

import '../../../../core/providers/current_user_notifier.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  HomeRepository homeRepository = HomeRepository();
  int _selectedIndex = 0;
  final pages = [
    SongsPage(),
    LibraryPage()
  ];
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
           
            _selectedIndex = index;
            
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
                _selectedIndex == 0
                    ? 'assets/images/home_filled.png'
                    : 'assets/images/home_unfilled.png',
                color: _selectedIndex == 0
                    ? AppPallete.whiteColor
                    : AppPallete.greyColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/library.png',
                color: _selectedIndex == 1
                    ? AppPallete.whiteColor
                    : AppPallete.greyColor),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
