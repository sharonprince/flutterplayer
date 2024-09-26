import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:flutterplayer/Screens/videoplayer.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  String bibleVerse = "Loading daily verse..."; // Default loading text
   String greetingMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        greetingMessage = getGreetingMessage();
    fetchBibleVerse(); // Fetch the Bible verse on init
    // Force landscape mode
    Timer(Duration(seconds: 5 ), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => RTMPPlayerScreen())));
     });
  }

  Future<void> fetchBibleVerse() async {
    final url = Uri.parse('https://beta.ourmanna.com/api/v1/get/?format=json');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final jsonData = json.decode(response.body);
        final verseText = jsonData['verse']['details']['text'];
        final verseReference = jsonData['verse']['details']['reference'];

        setState(() {
          // Update the bibleVerse state with the fetched verse and reference
          bibleVerse = "$verseText\n\n— $verseReference";
        });
      } else {
        // Handle any errors here (e.g., failed to fetch the verse)
        setState(() {
          bibleVerse = "Failed to load verse. Please try again later.";
        });
      }
    } catch (e) {
      // Handle any exceptions (e.g., network issues)
      setState(() {
        bibleVerse = "Error occurred while fetching verse.";
      });
    }
  }
   String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!!';
    } else if (hour < 17) {
      return 'Good Afternoon!!';
    } else {
      return 'Good Evening!!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                                         
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).scaffoldBackgroundColor,

                        ),
                        
                        child:  Text(
                          greetingMessage,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).scaffoldBackgroundColor,
                                            
                           
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Text(
                                "Verse of the Day !",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(22.0),
                                child: Text(
                                  bibleVerse,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                             
                            ],
                            
                          ),
                        ),
                      ),
                 
                   
                    ],
                  ),
                ),
              ),
            ),
            Container(
           
                child: Lottie.asset('assets/splashScreenJson/welcome.json')),
          ],
        ),
      ),
    );
  }
}
