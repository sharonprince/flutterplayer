import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterplayer/Screens/Admin/adminMainPage.dart';
import 'package:flutterplayer/Screens/Admin/imageadmin.dart';
import 'package:flutterplayer/Screens/aboutus/aboutus.dart';
import 'package:flutterplayer/Screens/homepage.dart';
import 'package:flutterplayer/Screens/homepage/HomePage.dart';
import 'package:flutterplayer/Screens/Admin/scheduleadmin.dart';
import 'package:flutterplayer/Screens/schedule/schedulePage.dart';
import 'package:flutterplayer/Widgets/config.dart';
import 'package:flutterplayer/Screens/Admin/addDetails.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
   schedulepage(),
   // ScheduleAdmin(),
  AboutUs(),
  // adddetails(),
  // imageupload()
  adminMainPage()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.black,
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
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Add'),
              //  BottomNavigationBarItem(icon: Icon(Icons.image), label: 'image'),
        ],
      ),
    );
  }
}

