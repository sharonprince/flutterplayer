import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class schedulepage extends StatefulWidget {
  @override
  _DataDisplayPageState createState() => _DataDisplayPageState();
}

class _DataDisplayPageState extends State<schedulepage> {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('schedule');

  List<Map<String, dynamic>> _dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    List<Map<String, dynamic>> tempList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    setState(() {
      _dataList = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data from Firestore'),
      ),
      body: _dataList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _dataList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_dataList[index]['name']),
                  subtitle: Text(_dataList[index]['timings']),
                );
              },
            ),
    );
  }
}
