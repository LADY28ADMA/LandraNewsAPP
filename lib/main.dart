import 'package:flutter/material.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:myapp/berita.dart';
import 'package:myapp/beritamain.dart';
import 'package:myapp/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  final List<Widget> pages = [
    const BeritaMainPage(),
    // const BeritaPage(),
    const LoginPage(),
    // const Center(child: Text('Settings Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        barColor: Colors.white,
        controller: FloatingBottomBarController(initialIndex: index),
        bottomBar: [
          BottomBarItem(
            icon: const Icon(Icons.home),
            iconSelected: const Icon(Icons.home, color: Colors.red),
            title: 'Home',
            dotColor: Colors.red,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
          ),
          BottomBarItem(
            icon: const Icon(Icons.settings),
            iconSelected: const Icon(Icons.settings, color: Colors.red),
            title: 'Settings',
            dotColor: Colors.red,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
          ),
        ],
        bottomBarCenterModel: BottomBarCenterModel(
          centerBackgroundColor: Colors.red,
          centerIcon: const FloatingCenterButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          centerIconChild: [
            FloatingCenterButtonChild(
              child: const Icon(
                Icons.ac_unit_outlined,
                color: Colors.white,
              ),
              onTap: () => print('Item3'),
            ),
          ],
        ),
      ),
    );
  }
}
