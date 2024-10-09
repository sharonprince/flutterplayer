import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterplayer/Screens/Admin/adminMainPage.dart';
import 'package:flutterplayer/Screens/mainScreen.dart';
import 'package:image_picker/image_picker.dart';

class imageupload extends StatefulWidget {
  @override
  _DataDisplayPageState createState() => _DataDisplayPageState();
}

class _DataDisplayPageState extends State<imageupload> {
  final CollectionReference _imagecollectionRef =
      FirebaseFirestore.instance.collection('images');
  final FirebaseStorage _storageRef = FirebaseStorage.instance;

  List<QueryDocumentSnapshot> _dataList = [];
  File? _imageFile;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    QuerySnapshot querySnapshot = await _imagecollectionRef.get();
    setState(() {
      _dataList = querySnapshot.docs;
    });
  }

  void deleteRecord(String docId) async {
    await _imagecollectionRef.doc(docId).delete().whenComplete(() {
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "deleted Successfully!!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );

    });
    fetchData();
  }

  void editRecord(String docId, String currentTitle, String currentSubtitle) {
    TextEditingController titleController =
        TextEditingController(text: currentTitle);
    TextEditingController subtitleController =
        TextEditingController(text: currentSubtitle);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Record'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: subtitleController,
                decoration: InputDecoration(labelText: 'Subtitle'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                await _imagecollectionRef.doc(docId).update({
                  'title': titleController.text,
                  'subtitle': subtitleController.text,
                });
                Navigator.pop(context);
                fetchData();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> uploadImageAndSave() async {
    if (_imageFile == null ||
        _titleController.text.isEmpty ||
        _subtitleController.text.isEmpty) return;

    // Upload image to Firebase Storage
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask =
        _storageRef.ref('images/$fileName').putFile(_imageFile!);
    try {
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Upload Success!!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      });
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      // Save download URL and other data to Firestore
      await _imagecollectionRef.add({
        'title': _titleController.text,
        'subtitle': _subtitleController.text,
        'imageUrl': downloadUrl,
      });

      // Clear inputs and refresh data
      setState(() {
        _imageFile = null;
        _titleController.clear();
        _subtitleController.clear();
      });
      fetchData();
    } catch (exceptions) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Something went wrong please try later!!",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('images from cloud'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => MainScreen())));
              },
              child: Text('Back'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: _dataList.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _dataList.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data =
                            _dataList[index].data() as Map<String, dynamic>;
                        String docId = _dataList[index].id;

                        return ListTile(
                          leading: data['imageUrl'] != null
                              ? Image.network(data['imageUrl'],
                                  width: 50, height: 50, fit: BoxFit.cover)
                              : Icon(Icons.image),
                          title: Text(data['title']),
                          subtitle: Text(data['subtitle']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  editRecord(
                                      docId, data['title'], data['subtitle']);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  deleteRecord(docId);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    if (_imageFile != null)
                      Image.file(_imageFile!, height: 100),
                    SizedBox(height: 10),
                    ElevatedButton(
                      child: Container(
                        child: Text('Pick Image'),
                      ),
                      onPressed: pickImage,
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: _subtitleController,
                      decoration: InputDecoration(labelText: 'Subtitle'),
                    ),
                    ElevatedButton(
                      child: Text('Upload Image and Save Record'),
                      onPressed: uploadImageAndSave,
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
