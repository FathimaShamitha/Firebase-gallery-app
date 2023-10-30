import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyGalleryViewClass extends StatefulWidget {
  const MyGalleryViewClass({Key? key}) : super(key: key);

  @override
  State<MyGalleryViewClass> createState() => _MyGalleryViewClassState();
}

class _MyGalleryViewClassState extends State<MyGalleryViewClass> {
  String uid = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }

  void getUid() async {
    var ref = FirebaseAuth.instance;
    User user = ref.currentUser!;
    setState(() {
      uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          "My Gallery",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("MyImages")
            .doc(uid)
            .collection("myimages")
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error!!!!!"),
            );
          }
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      final response = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Do you want to delete"),
                                content: Text(
                                    'This action will permanently delete this data'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Delete'),
                                  )
                                ],
                              ));
                      if (response == null || !response) {
                        return;
                      }
                      await FirebaseFirestore.instance
                          .collection("MyImages")
                          .doc(uid)
                          .collection("myimages")
                          .doc(snapshot.data!.docs[index].id)
                          .delete();
                      Fluttertoast.showToast(msg: "Deleted");
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Image(
                        image: NetworkImage(
                            snapshot.data!.docs[index]["imageurl"]),
                        fit: BoxFit.cover,
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
