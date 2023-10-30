import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyUserViewClass extends StatefulWidget {
  const MyUserViewClass({Key? key}) : super(key: key);

  @override
  State<MyUserViewClass> createState() => _MyUserViewClassState();
}

class _MyUserViewClassState extends State<MyUserViewClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          "All Users",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Erroe!!!!!"),
            );
          }
          if (snapshot.hasData) {
            List userdetails = snapshot.data!.docs;
            return ListView.builder(
                itemCount: userdetails.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.lightGreen,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        userdetails[index]["username"],
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
