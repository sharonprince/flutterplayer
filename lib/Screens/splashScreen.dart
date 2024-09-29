import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterplayer/Screens/homepage.dart';
import 'package:flutterplayer/Screens/mainScren.dart';

import 'package:flutterplayer/Screens/videoplayer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    //  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    // Enable immersive sticky mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    greetingMessage = getGreetingMessage();
    fetchBibleVerse(); // Fetch the Bible verse on init
    // Force landscape mode
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => MainScreen())));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
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
                        child:
                            // Text(
                            //   greetingMessage,
                            //   style: const TextStyle(
                            //       color: Colors.black54,
                            //       fontSize: 30,
                            //       fontWeight: FontWeight.bold,
                            //       fontFamily: "Poppins"),
                            // ),
                            buildGradientText(
                          greetingMessage,
                          LinearGradient(
                              colors: [Colors.orange, Colors.deepPurple]),
                          40,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                              Text(
                                "Verse of the Day !",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(22.0),
                                child: Text(
                                  bibleVerse,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //instagram
                                  GestureDetector(
                                    onTap: _launchInstagram,
                                    child: buildGradientIcon(
                                      FontAwesomeIcons.instagram,
                                      LinearGradient(
                                          colors: [Colors.purple, Colors.blue]),
                                    ),
                                  ),

                                  //facebook
                                  GestureDetector(
                                    onTap: _launchFacebook,
                                    child: buildGradientIcon(
                                      Icons.facebook,
                                      LinearGradient(
                                          colors: [Colors.blue, Colors.indigo]),
                                      // Adjust size for Facebook icon
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _launchYouTube,
                                    child: buildGradientIcon(
                                      FontAwesomeIcons.youtube,
                                      LinearGradient(
                                          colors: [Colors.orange, Colors.red]),
                                      // Adjust size for YouTube icon
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _launchWhatsApp,
                                    child: buildGradientIcon(
                                      FontAwesomeIcons.whatsapp,
                                      LinearGradient(
                                          colors: [Colors.green, Colors.teal]),
                                      // Adjust size for WhatsApp icon
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(child: Image.asset("assets/images/logo2.jpg")),
          ],
        ),
      ),
    );
  }
}

//instagram

Future<void> _launchInstagram() async {
  const String instagramAppUrl =
      'instagram://user?username=calvarykarunyadigitalgospel'; // Replace 'your_username'
  const String instagramWebUrl =
      'https://www.instagram.com/calvarykarunyadigitalgospel'; // Replace 'your_username'

  await _launchUrl(instagramAppUrl, instagramWebUrl);
}

//facebook
Future<void> _launchFacebook() async {
  const String facebookAppUrl =
      'https://www.facebook.com/share/fPoVzU3iZanYudZ3/?mibextid=qi2Omg'; // Replace 'your_profile_id' with your Facebook ID
  const String facebookWebUrl =
      'https://www.facebook.com/calvarykarunyadigitalgospel'; // Replace 'your_profile_id'

  await _launchUrl(facebookAppUrl, facebookWebUrl);
}

//youtube
Future<void> _launchYouTube() async {
  const String youtubeAppUrl =
      'https://www.youtube.com/@calvarykarunyadigitalgospel'; // Replace 'your_channel_id'
  const String youtubeWebUrl =
      'https://www.youtube.com/@calvarykarunyadigitalgospel'; // Replace 'your_channel_id'

  await _launchUrl(youtubeAppUrl, youtubeWebUrl);
}

//whatsapp
Future<void> _launchWhatsApp() async {
  const String whatsappAppUrl =
      'whatsapp://send?phone=+919901144844'; // Replace 'your_phone_number' with the full number in international format
  const String whatsappWebUrl =
      'https://wa.me/+919901144844'; // Replace 'your_phone_number'

  await _launchUrl(whatsappAppUrl, whatsappWebUrl);
}

Future<void> _launchUrl(String appUrl, String webUrl) async {
  try {
    // Try to launch the app
    bool launched = await launchUrl(Uri.parse(appUrl));

    if (!launched) {
      // If the app is not available, open the web version
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    // Handle error
    print('Could not launch the app');
  }
}

// Function to create gradient for icons
Widget buildGradientIcon(IconData icon, Gradient gradient) {
  return ShaderMask(
    shaderCallback: (bounds) => gradient.createShader(
      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
    ),
    child: Icon(
      icon,
      color: Colors
          .white, // Base color of icon. Will be overwritten by the gradient
      size: 40,
    ),
  );
}

// Function to create gradient text
Widget buildGradientText(String text, Gradient gradient, double fontSize) {
  return ShaderMask(
    shaderCallback: (bounds) => gradient.createShader(
      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white, // This will be overridden by the gradient
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
