import 'package:flutter/material.dart';

class serviceTile extends StatefulWidget {
  

   serviceTile( {super.key,});

  @override
  State<serviceTile> createState() => _PresidentTileState();
}

class _PresidentTileState extends State<serviceTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
          title: Text(
           "Services we Provide",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_drop_down),
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      child: Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset("assets/images/profile.jpg")),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Name: Stevan Jonathan",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Description: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}