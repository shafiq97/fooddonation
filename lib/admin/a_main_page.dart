import 'package:feed_food/admin/donate/v_donate_page.dart';
import 'package:feed_food/admin/history/v_history_page.dart';
import 'package:feed_food/admin/home/v_home_page.dart';
import 'package:feed_food/admin/profile/v_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class AMainPage extends StatefulWidget {
  const AMainPage({super.key});

  @override
  State<AMainPage> createState() => _VHomePageState();
}

class _VHomePageState extends State<AMainPage> {
  var _currentIndex = 0;
  List pages = [
    const AHomePage(),
    const ADonatePage(),
    const AHistory(),
    const AProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: SalomonBottomBar(
            onTap: ((index) {
              setState(() {});
              _currentIndex = index;
            }),
            currentIndex: _currentIndex,
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.home_outlined),
                title: const Text("Home"),
                selectedColor: Colors.purple,
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: const Icon(Icons.add_box_outlined, size: 30),
                title: const Text("Post"),
                selectedColor: Colors.red,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: const Icon(Icons.history),
                title: const Text("history"),
                selectedColor: Colors.orange,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: const Icon(Icons.person_outline),
                title: const Text("Profile"),
                selectedColor: Colors.teal,
              ),
            ]),
      ),
    );
  }
}