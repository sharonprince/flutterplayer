import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterplayer/Screens/Admin/adminMainPage.dart';
import 'package:flutterplayer/Screens/mainScreen.dart';
import 'package:flutterplayer/controller/DataBaseMethods/DatabaseMethods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';


class adddetails extends StatefulWidget {
  const adddetails({super.key});

  @override
  State<adddetails> createState() => _addRecipeeState();
}

class _addRecipeeState extends State<adddetails> {
  String? value;
  final List<String> TimeList = [
    '6Am - 7Am ',
    '7Am - 8Am ',
    '8Am - 9Am ',
    '9Am - 10Am ',
    '10Am - 11Am ',
    '11Am - 12Am ',
    '1Pm - 2Pm ',
    '2Pm - 3Pm ',
    '3Pm - 4Pm ',
    '4Pm - 5Pm ',
    '5Pm - 6Pm ',
    '7Pm - 8Pm ',
    '8Pm - 9Pm ',
    '9Pm - 10Pm ',
    '10Pm - 11Pm ',
    '11Pm - 12Am ',
  
    
  ];
  TextEditingController nameController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var images = await picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(images!.path);
    setState(() {});
  }

  void saveData() async {
    if (
        nameController.text != null 
       ) {
   
      Map<String, dynamic> schedule = {
        "name": nameController.text,
        "timings":value
      
      };
      DatabaseMethods().addrecipe(schedule).then((value) {
        nameController.clear();
        timeController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Data has uploaded !!!!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "unable to upload check the data",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Add Data to Cloud'),
        actions: [ 
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) =>MainScreen())));
            },
            child: Text('Back'),),
        ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => MainScreen())));
                      },
                      child: Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Text(
                      "Add Details",
                    
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // selectedImage != null
                //     ? GestureDetector(
                //         onTap: () {
                //           getImage();
                //         },
                //         child: Center(
                //           child: Container(
                //               height: 200,
                //               width: 200,
                //               decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(20),
                //                   border: Border.all()),
                //               child: ClipRRect(
                //                   borderRadius: BorderRadius.circular(10),
                //                   child: Image.file(
                //                     selectedImage!,
                //                     fit: BoxFit.cover,
                //                   ))),
                //         ),
                //       )
                //     : GestureDetector(
                //         onTap: () {
                //           getImage();
                //         },
                //         child: Center(
                //           child: Container(
                //             height: 200,
                //             width: 200,
                //             decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 borderRadius: BorderRadius.circular(20),
                //                 border: Border.all()),
                //             child: Icon(Icons.camera_alt_outlined),
                //           ),
                //         ),
                //       ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Program Name",
                
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all()),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Write the name of the Program"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
               
                //   Container(
                //   padding: EdgeInsets.only(left: 20),
                //   width: MediaQuery.of(context).size.width,
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(20),
                //       border: Border.all()),
                //   child: TextField(
                //     controller: timeController,
                //     decoration: InputDecoration(
                //         border: InputBorder.none, hintText: "Write the name of the Program"),
                //   ),
                // ),
                 SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      items: TimeList
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() {
                        this.value = value;
                      }),
                      dropdownColor: Colors.white,
                      hint: Text("Select timings"),
                      iconSize: 36,
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                      value: value,
                    ),
                  ),
                ),
                 SizedBox(
                  height: 20.0,
                ),
              
               
  
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    saveData();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    child: Center(
                        child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.normal),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
