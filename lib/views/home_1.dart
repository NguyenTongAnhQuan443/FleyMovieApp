import 'package:fleymovieapp/page/setting.dart';
import 'package:fleymovieapp/views/find_movies_screen/find_movies_screen.dart';
import 'package:fleymovieapp/views/home_screen/home_screen.dart';
import 'package:fleymovieapp/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// USE
class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Home1State();
  }
}

class _Home1State extends State<Home1> {
  int _pageIndex = 0;
  final List<Widget> _page = [
    const HomeScreen(),
    const FindMoviesScreen(),
    const Setting(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageIndex,
        height: 40.0,
        items: const [
          Icon(Icons.home, size: 20, color: Colors.white),
          Icon(Icons.search_outlined, size: 20, color: Colors.white),
          Icon(Icons.download_outlined, size: 20, color: Colors.white),
          Icon(Icons.person, size: 20, color: Colors.white),
        ],
        color: Colors.grey,
        buttonBackgroundColor: Colors.red,
        animationCurve: Curves.easeInOut,
        backgroundColor: Colors.black,
        animationDuration: const Duration(microseconds: 600),
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
