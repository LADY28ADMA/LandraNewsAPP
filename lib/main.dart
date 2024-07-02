import 'package:flutter/material.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:myapp/beritamain.dart';
// import 'package:myapp/login.dart';
import 'package:myapp/pages/settingspage.dart';
import 'package:myapp/pages/up_berita.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
      // debugShowCheckedModeBanner: false,
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
    const SettingsPage2(),
    // const Center(child: Text('Settings Page')),
  ];

  @override
  Widget build(BuildContext context) {
    void _showAddBeritaBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddBeritaForm(),
      );
    },
  );
}

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        barColor: Colors.white,
        controller: FloatingBottomBarController(initialIndex: index),
        bottomBar: [
          BottomBarItem(
            icon: const Icon(Icons.home),
            iconSelected: const Icon(Icons.home, color: Colors.deepPurple),
            title: 'Home',
            dotColor: Colors.deepPurple,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
          ),
          BottomBarItem(
            icon: const Icon(Icons.settings),
            iconSelected: const Icon(Icons.settings, color: Colors.deepPurple),
            title: 'Settings',
            dotColor: Colors.deepPurple,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
          ),
        ],
        bottomBarCenterModel: BottomBarCenterModel(
          centerBackgroundColor: Colors.deepPurple,
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
              onTap: () {
                _showAddBeritaBottomSheet(context);
              },
            ),
          ],
        ),
      ),
    );
    
  }
}
