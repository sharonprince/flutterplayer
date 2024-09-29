import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterplayer/Screens/aboutus.dart';
import 'package:flutterplayer/Screens/homepage.dart';
import 'package:flutterplayer/Screens/template.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
   SchedulePage(),
  AboutUs()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_page), label: 'About Us'),
        ],
      ),
    );
  }
}