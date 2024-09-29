import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
    String bibleVerse = "Loading daily verse..."; // Default loading text
  String greetingMessage = '';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}