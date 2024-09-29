import 'dart:convert';
import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutterplayer/Screens/videoplayer.dart';
import 'package:flutterplayer/Widgets/textColor.dart';
import 'package:flutterplayer/video.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VlcPlayerController _vlcPlayerController;
  bool _isFullScreen = false;
  String bibleVerse = "Loading Bible verse..."; // Default loading text
  String greetingMessage = '';
  String _userName ='';

  final List<String> imgList = [
    'https://plus.unsplash.com/premium_photo-1673448391005-d65e815bd026?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGhvdG98ZW58MHx8MHx8fDA%3D',
    'https://media.istockphoto.com/id/1031587898/photo/hunter-spotting-game.jpg?s=612x612&w=0&k=20&c=PClYAKmWXXdP6_bNCAduUNz3X6U9sfaRDwzFyoXABto=',
    'https://iso.500px.com/wp-content/uploads/2016/11/stock-photo-159533631.jpg',
    'https://images.pexels.com/photos/821749/pexels-photo-821749.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
  ];

  @override
  void initState() {
    super.initState();
     _loadUserName();
    greetingMessage = getGreetingMessage();
    fetchBibleVerse();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _vlcPlayerController = VlcPlayerController.network(
      'https://media.w3.org/2010/05/sintel/trailer.mp4',
      autoPlay: true,
    );
  }
   Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? '';
    });
  }

  @override
  void dispose() {
    _vlcPlayerController.dispose();
    super.dispose();
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildGradientText(
                      "Hi "+_userName+'\n'+ greetingMessage,
                      LinearGradient(colors: [Colors.black, Colors.black]),
                      25,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/logo.jpeg",
                        height: 150,
                        width: 150,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 10,
                shadowColor: Colors.black,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          buildGradientText(
                            "Verse of the day",
                            LinearGradient(
                                colors: [Colors.red, Colors.deepPurple]),
                            25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              bibleVerse,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 5,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  VlcPlayer(
                    controller: _vlcPlayerController,
                    aspectRatio: 16 / 9,
                    placeholder: Center(child: CircularProgressIndicator()),
                  ),
                  // Positioned(
                  //   top: 10,
                  //   left: 10,
                  //   child: IconButton(
                  //     icon: Icon(Icons.arrow_back, color: Colors.white),
                  //     onPressed: () {
                  //       if (_isFullScreen) {
                  //         // _toggleFullScreen();
                  //         // RTMPPlayerScreen11();
                  //         Navigator.of(context).pushReplacement(
                  //             MaterialPageRoute(
                  //                 builder: ((context) => RTMPPlayerScreen())));
                  //       }
                  //     },
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 10,
                  //   right: 10,
                  //   child: IconButton(
                  //     icon: Icon(Icons.settings, color: Colors.white),
                  //     onPressed: _showSettings,
                  //   ),
                  // ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      icon: Icon(
                          _vlcPlayerController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _vlcPlayerController.value.isPlaying
                              ? _vlcPlayerController.pause()
                              : _vlcPlayerController.play();
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: IconButton(
                      icon: Icon(Icons.fullscreen, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: ((context) => RTMPPlayerScreen())));
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Text(
                        "Latest Updates: ",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 5,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: imgList
                      .map((item) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(item,
                                  fit: BoxFit.cover, width: 1000),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
        bibleVerse = "Unable to load..";
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
}


 
