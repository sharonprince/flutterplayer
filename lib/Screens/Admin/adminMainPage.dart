import 'package:flutter/material.dart';
import 'package:flutterplayer/Screens/Admin/addDetails.dart';
import 'package:flutterplayer/Screens/Admin/imageadmin.dart';
import 'package:flutterplayer/Screens/Admin/scheduleadmin.dart';
import 'package:flutterplayer/Screens/mainScreen.dart';
import 'package:flutterplayer/Widgets/config.dart';

class adminMainPage extends StatefulWidget {
  const adminMainPage({super.key});

  @override
  State<adminMainPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<adminMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
        // title: Text('Add Data to Cloud', style: TextStyle(
        //               color: kWhite, fontSize: 30, fontWeight: FontWeight.bold),),
        actions: [ 
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) =>MainScreen())));
            },
            child: Text('Back', style: TextStyle(    color: kWhite, fontSize: 20, fontWeight: FontWeight.bold  ),),),
        ),
        ],
      ),

      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                      child: Text(
                    "Admin page",
                    style: TextStyle(
                        color: kWhite, fontSize: 25, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(height: 40,),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) =>ScheduleAdmin())));
                      },
                      icon: Icon(
                        Icons.list,
                        color: kWhite,
                        size: 80,
                      ),
                    ),
                  ),
            SizedBox(height: 40,),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => adddetails())));
                      },
                      icon: Icon(
                        Icons.upload,
                        color: kWhite,
                        size: 80,
                      ),
                    ),
                  ),
            
            SizedBox(height: 40,),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => imageupload())));
                      },
                      icon: Icon(
                        Icons.image_rounded,
                        color: kWhite,
                        size: 80,
                      ),
                    ),
                  ),
                  SizedBox(height: 80,),
                   Container(
                      child: Text(
                    "Click to add details",
                    style: TextStyle(
                        color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                    SizedBox(height: 20,),
                    Container(
                      child: Text(
                    "This page is only visible for admins",
                    style: TextStyle(
                        color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
