import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterplayer/Screens/mainScreen.dart';



class ScheduleAdmin extends StatefulWidget {
  @override
  _DataDisplayPageState createState() => _DataDisplayPageState();
}

class _DataDisplayPageState extends State<ScheduleAdmin> {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('schedule');

  List<QueryDocumentSnapshot> _dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    setState(() {
      _dataList = querySnapshot.docs;
    });
  }

  void deleteRecord(String docId) async {
    await _collectionRef.doc(docId).delete();
    fetchData(); // Refresh the list after deletion
  }

  void editRecord(String docId, String newTitle, String newSubtitle) async {
    await _collectionRef.doc(docId).update({
      'name': newTitle,
      'timings': newSubtitle,
    });
    fetchData(); // Refresh the list after updating
  }

  void showEditDialog(BuildContext context, String docId, String currentTitle, String currentSubtitle) {
    TextEditingController titleController = TextEditingController(text: currentTitle);
    TextEditingController subtitleController = TextEditingController(text: currentSubtitle);

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
                decoration: InputDecoration(labelText: 'name'),
              ),
              TextField(
                controller: subtitleController,
                decoration: InputDecoration(labelText: 'timings'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                editRecord(docId, titleController.text, subtitleController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data from Firestore'),
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
      body: _dataList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = _dataList[index].data() as Map<String, dynamic>;
                String docId = _dataList[index].id; // Get document ID

                return ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['timings']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          showEditDialog(context, docId, data['name'], data['timings']);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          deleteRecord(docId); // Delete record when icon is pressed
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
 
  }
}