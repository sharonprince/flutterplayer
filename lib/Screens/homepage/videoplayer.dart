import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutterplayer/Screens/homepage.dart';
import 'package:flutterplayer/Screens/mainScreen.dart';
import 'package:wakelock_plus/wakelock_plus.dart';


class RTMPPlayerScreen extends StatefulWidget {
  @override
  _RTMPPlayerScreenState createState() => _RTMPPlayerScreenState();
}

class _RTMPPlayerScreenState extends State<RTMPPlayerScreen> {
  late VlcPlayerController _vlcPlayerController;
  bool isPlaying = true; // To track play/pause state
  bool hasError = false; // To track if an error occurred
  String errorMessage = ''; // Error message to display

  @override
  void initState() {
    super.initState();
    _vlcPlayerController = VlcPlayerController.network(
      // 'rtmp://your_rtmp_url_here',
      // 'rtmp://62.72.43.50/live/jaden',
     'https://media.w3.org/2010/05/sintel/trailer.mp4',
      // // Replace with your RTMP URL
      autoPlay: true,
      onInit: () {
        _vlcPlayerController.addListener(_onPlayerStateChange);
      },
    );
        // Force landscape mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    // Enable immersive sticky mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Keep screen awake
    WakelockPlus.enable(); // Keep the screen on
  }

  void _onPlayerStateChange() {
    if (_vlcPlayerController.value.hasError) {
      setState(() {
        hasError = true;
        errorMessage = 'Server is not available at the moment, \nplease try again later'; // Custom error message
        _showErrorDialog();
      });
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Server Unavailable!!'),
          content: Text(
            errorMessage,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                 SystemNavigator.pop();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
           SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
            // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _vlcPlayerController.removeListener(_onPlayerStateChange);
    _vlcPlayerController.dispose();
    super.dispose();


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Fullscreen VLC player
          Center(
            child: VlcPlayer(
              controller: _vlcPlayerController,
              aspectRatio: 16 / 9,
              placeholder: Center(child: CircularProgressIndicator()),
            ),
          ),
          
          // Back button (top-left corner)
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () {
                  //  SystemNavigator.pop();
                // Navigator.of(context).pop();
                     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => MainScreen())));
              },
            ),
          ),

          // Play/Pause button (bottom-left corner)
          Positioned(
            bottom: 30,
            // left: 16,
            right: 16,
            child: IconButton(
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
              onPressed: _togglePlayPause,
            ),
          ),
        ],
      ),
    );
  }
}
