import 'package:flutter/material.dart';
import 'package:musicplayer/favourites.dart';
import 'package:musicplayer/home_screen.dart';
import 'package:musicplayer/playList.dart';
import 'package:musicplayer/seach.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({Key? key}) : super(key: key);

  @override
  _BottomScreenState createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: const [
          ScreenHome(),
          SearchScreen(),
          FavouritesScreen(),
          PlaylistScreen(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        
        color:  const Color.fromARGB(255, 49, 48, 48),
        controller: _controller,
        flat: true,
        useActiveColorByDefault: false,
        items: const [
          RollingBottomBarItem(Icons.home_outlined, activeColor: Colors.white),
          RollingBottomBarItem(Icons.search, activeColor: Colors.white),
          RollingBottomBarItem(Icons.favorite_border,
              activeColor: Colors.white),
          RollingBottomBarItem(Icons.playlist_add, activeColor: Colors.white),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
