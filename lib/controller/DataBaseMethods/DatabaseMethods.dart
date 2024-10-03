import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Future addrecipe(Map<String, dynamic> addschedule) async{
    return await FirebaseFirestore.instance.collection("schedule").add(addschedule);

  }
  
}