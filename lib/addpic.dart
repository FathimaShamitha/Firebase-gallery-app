import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myflutterapp/signin.dart';

class MyAddPicClass extends StatefulWidget {
  const MyAddPicClass({Key? key}) : super(key: key);

  @override
  State<MyAddPicClass> createState() => _MyAddPicClassState();
}

class _MyAddPicClassState extends State<MyAddPicClass> {
  File? myimage;
  UploadTask? mytask;
  bool isUpload = false;
  String uid = "";

  Future<void> choosePic() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      myimage = File(image!.path);
      isUpload = true;
    });
  }

  Future<void> uploadPic() async {
    var ref = FirebaseAuth.instance;
    User user = await ref.currentUser!;
    String uid = user.uid;
    var img_ref =
        await FirebaseStorage.instance.ref().child("MyImages/${myimage!.path}");
    mytask = img_ref.putFile(myimage!);
    final snap = await mytask!.whenComplete(() {});
    var imageurl = await snap.ref.getDownloadURL();
    final image_ref = FirebaseFirestore.instance
        .collection("MyImages")
        .doc(uid)
        .collection("myimages")
        .add({"imageurl": imageurl, "userid": uid});
    Fluttertoast.showToast(msg: "Image added");
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(msg: "Logged Out");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MySignInClass()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          "Add Photo",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: signOut,
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Center(
              child: myimage==null? CircleAvatar(
                radius: 100,
                backgroundColor: Colors.lightGreen,
                child: InkWell(
                    onTap: choosePic,
                    child: Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.white,
                    )),
              ):CircleAvatar(
                radius: 100,
                backgroundImage: FileImage(myimage!),
              ),
            ),
            isUpload == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen),
                        onPressed: () async {
                          uploadPic();
                          setState(() {
                            isUpload = false;
                          });
                        },
                        child: Text(
                          "Add Image to gallery",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
