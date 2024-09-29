import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterplayer/Screens/Login/loginpage.dart';
import 'package:flutterplayer/Screens/homepage.dart';
import 'package:flutterplayer/Screens/splashScreen.dart';

import 'package:flutterplayer/Screens/videoplayer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userName = prefs.getString('userName');

  runApp(MyApp(startPage: userName == null ? LoginPage() : splashscreen()));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final Widget startPage;
  
  MyApp({required this.startPage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    
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

