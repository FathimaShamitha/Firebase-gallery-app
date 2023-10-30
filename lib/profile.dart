import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myflutterapp/viewusers.dart';

class MyProfileViewClass extends StatefulWidget {
  const MyProfileViewClass({Key? key}) : super(key: key);

  @override
  State<MyProfileViewClass> createState() => _MyProfileViewClassState();
}

class _MyProfileViewClassState extends State<MyProfileViewClass> {
  File? profilepic;
  String username = "";
  String email = "";

  Future<void> changeProfilePic() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      profilepic = File(img!.path);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var ref = FirebaseAuth.instance;
    User user = ref.currentUser!;
    setState(() {
      email = user.email!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          "My Profile",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          PopupMenuButton(
              color: Colors.white,
              onSelected: (value) {
                if (value == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyUserViewClass()));
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(child: Text("Settings")),
                  PopupMenuItem(
                    child: Text("View other users"),
                    value: 2,
                  ),
                ];
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Stack(
                  children: [
                    profilepic == null
                        ? CircleAvatar(
                            radius: 100,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 150,
                            ),
                          )
                        : CircleAvatar(
                            radius: 100,
                            backgroundImage: FileImage(profilepic!),
                          ),
                    Positioned(
                        left: 140,
                        top: 150,
                        child: InkWell(
                          onTap: changeProfilePic,
                          child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.lightGreen,
                              child: Icon(
                                Icons.photo_camera_rounded,
                                color: Colors.white,
                              )),
                        ))
                  ],
                ),
              ),
            ),
            Text(email),
          ],
        ),
      ),
    );
  }
}
