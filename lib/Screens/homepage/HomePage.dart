import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutterplayer/Screens/Login/loginpage.dart';
import 'package:flutterplayer/Screens/mainScreen.dart';
import 'package:flutterplayer/Screens/splashScreen/splashScreen.dart';
import 'package:flutterplayer/Screens/homepage/videoplayer.dart';
import 'package:flutterplayer/Widgets/config.dart';
import 'package:flutterplayer/controller/appController.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _schedulepageState();
}

class _schedulepageState extends State<HomePage> {
  late VlcPlayerController _vlcPlayerController;
  bool _isFullScreen = false;
  String bibleVerse = "Loading Bible verse...";
  String bibleref = ''; // Default loading text
  String greetingMessage = '';
  String _userName = '';
  bool isPlaying = true; // To track play/pause state

  final List<String> imgList = [
    'https://plus.unsplash.com/premium_photo-1673448391005-d65e815bd026?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGhvdG98ZW58MHx8MHx8fDA%3D',
    'https://media.istockphoto.com/id/1031587898/photo/hunter-spotting-game.jpg?s=612x612&w=0&k=20&c=PClYAKmWXXdP6_bNCAduUNz3X6U9sfaRDwzFyoXABto=',
    'https://iso.500px.com/wp-content/uploads/2016/11/stock-photo-159533631.jpg',
    'https://images.pexels.com/photos/821749/pexels-photo-821749.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _loadUserName();
    greetingMessage = getGreetingMessage();
    fetchBibleVerse();

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
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _togglePlayPause() {
    setState(() {
      if (isPlaying) {
        _vlcPlayerController.pause();
      } else {
        _vlcPlayerController.play();
      }
      isPlaying = !isPlaying;
    });
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
        // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: kPrimaryColor,
      // appBar: AppBar(
      //   backgroundColor: kPrimaryColor,
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi, " + _userName + '\n' +greetingMessage,
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: kWhite),
                    ),
                    IconButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();
                          // SystemNavigator.pop();
                                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => LoginPage())));
                        },
                        icon: Icon(
                          Icons.logout_rounded,
                          color: kWhite,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),

              //body starts from here
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50)),
                  ),
                  //this is the main column and body starts from here
                  //if want add single child scroll here
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.black,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              buildGradientText(
                                                "Word for Today",
                                                LinearGradient(colors: [
                                                  Colors.red,
                                                  kPrimaryColor
                                                ]),
                                                15,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          buildGradientText(
                                            bibleVerse,
                                            LinearGradient(colors: [
                                              Colors.black,
                                              Colors.black
                                            ]),
                                            15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Vlc player
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Stack(
                                children: [
                                  VlcPlayer(
                                    controller: _vlcPlayerController,
                                    aspectRatio: 16 / 9,
                                    placeholder: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    // left: 16,
                                    right: 10,
                                    child: IconButton(
                                      icon: Icon(
                                        isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                        // size: 32,
                                      ),
                                      onPressed: _togglePlayPause,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: IconButton(
                                      icon: Icon(Icons.fullscreen,
                                          color: Colors.white),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    RTMPPlayerScreen())));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //latest update icon
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: Text(
                                  "Latest Updates: ",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  maxLines: 5,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //slider
                          Center(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 400.0,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                pauseAutoPlayOnTouch: true,
                                scrollDirection: Axis.horizontal,
                              ),
                              items: imgList
                                  .map((item) => Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(item,
                                              fit: BoxFit.cover, width: 1000),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

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
}
