import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';


class RTMPPlayerScreen11 extends StatefulWidget {
  @override
  _RTMPPlayerScreenState createState() => _RTMPPlayerScreenState();
}

class _RTMPPlayerScreenState extends State<RTMPPlayerScreen11> {
  late VlcPlayerController _vlcPlayerController;
  bool isPlaying = true; // To track play/pause state
  bool hasError = false; // To track if an error occurred
  String errorMessage = ''; // Error message to display

  @override
  void initState() {
    super.initState();

    // Force landscape mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    // Enable immersive sticky mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Keep screen awake
    WakelockPlus.enable(); // Keep the screen on
    _vlcPlayerController = VlcPlayerController.network(
      'rtmp://62.72.43.50/live/jaden',   // Replace with your RTMP URL
      autoPlay: true,
      onInit: () {
        _vlcPlayerController.addListener(_onPlayerStateChange);
      },
    );
  }

  void _onPlayerStateChange() {
    if (_vlcPlayerController.value.hasError) {
      setState(() {
        hasError = true;
        errorMessage = _vlcPlayerController.value.errorDescription ?? 'Unknown error occurred';
      });
    }
  }

  @override
  void dispose() {
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
          VlcPlayer(
            controller: _vlcPlayerController,
            aspectRatio: 16 / 9,
            placeholder: Center(child: CircularProgressIndicator()),
          ),
          
          // Display error message if there's an error
          if (hasError)
            Center(
              child: AlertDialog(
                title: Text('Error'),
                content: Text(errorMessage),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            ),
      
          // Back button (top-left corner)
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                  // SystemNavigator.pop();
                Navigator.of(context).pop();
              },
            ),
          ),
      
          // Play/Pause button (bottom-left corner)
          Positioned(
            bottom: 30,
            right: 30,
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
