import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterplayer/Screens/aboutus/Components/Ourteam.dart';
import 'package:flutterplayer/Screens/aboutus/Components/TechnicalDirector.dart';
import 'package:flutterplayer/Screens/aboutus/Components/address.dart';
import 'package:flutterplayer/Screens/aboutus/Components/president.dart';
import 'package:flutterplayer/Screens/aboutus/Components/service.dart';
import 'package:flutterplayer/Widgets/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  String desc1 =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 5),
                        Text(
                          "About us",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: kWhite),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: PresidentTile(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:TechnicalDirectorTile(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:ourteamTile(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:serviceTile(),
                      ),
                       SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: addressTile(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Connect",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: kWhite),
                            ),
                          ),
                        ],
                      ),
                      //social media links
                              
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //instagram
                                  GestureDetector(
                                    onTap: _launchInstagram,
                                    child: buildGradientIcon(
                                      FontAwesomeIcons.instagram,
                                      LinearGradient(colors: [
                                        Colors.purple,
                                        Colors.blue
                                      ]),
                                    ),
                                  ),
                              
                                  //facebook
                                  GestureDetector(
                                    onTap: _launchFacebook,
                                    child: buildGradientIcon(
                                      Icons.facebook,
                                      LinearGradient(colors: [
                                        Colors.blue,
                                        Colors.indigo
                                      ]),
                                      // Adjust size for Facebook icon
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _launchYouTube,
                                    child: buildGradientIcon(
                                      FontAwesomeIcons.youtube,
                                      LinearGradient(colors: [
                                        Colors.orange,
                                        Colors.red
                                      ]),
                                      // Adjust size for YouTube icon
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _launchWhatsApp,
                                    child: buildGradientIcon(
                                      FontAwesomeIcons.whatsapp,
                                      LinearGradient(colors: [
                                        Colors.green,
                                        Colors.teal
                                      ]),
                                      // Adjust size for WhatsApp icon
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      // Text("Email:", style: TextStyle(color: kWhite,fontSize: 20, fontWeight: FontWeight.bold),),
                      //  Text("calvarykarunya@gmail.com:", style: TextStyle(color: kWhite,fontSize: 20, fontWeight: FontWeight.bold),),
                      //      SizedBox(height: 30,),
                      // Text("Address:", style: TextStyle(color: kWhite,fontSize: 20, fontWeight: FontWeight.bold),),
                      //  Text("New Town Bhadravathi", style: TextStyle(color: kWhite,fontSize: 20, fontWeight: FontWeight.bold),),
                      //       SizedBox(height: 30,),
                      Text(
                        "Calvary Karunya Digital Gospel",
                        style: TextStyle(
                            color: kWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " All rights reserved",
                        style: TextStyle(
                            color: kWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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


