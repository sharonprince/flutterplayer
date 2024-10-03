import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterplayer/Screens/homepage/HomePage.dart';
import 'package:flutterplayer/Screens/schedule/schedulePage.dart';
import 'package:flutterplayer/Widgets/config.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterplayer/Screens/Login/loginpage.dart';
import 'package:flutterplayer/Screens/homepage.dart';
import 'package:flutterplayer/Screens/splashScreen/splashScreen.dart';

import 'package:flutterplayer/Screens/homepage/videoplayer.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userName = prefs.getString('userName');

  runApp(MyApp(startPage: userName == null ? LoginPage() : splashscreen()));
    // runApp(MyApp(startPage: userName == null ? LoginPage() : LoginPage()));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final Widget startPage;
  
  MyApp({required this.startPage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        ),
    
      home: startPage,
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
        
      
//         // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: LoginPage(),
//     );
//   }
// }

