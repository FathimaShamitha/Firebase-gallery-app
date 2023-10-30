import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';

class MySignUpClass extends StatefulWidget {
  const MySignUpClass({Key? key}) : super(key: key);

  @override
  State<MySignUpClass> createState() => _MySignUpClassState();
}

class _MySignUpClassState extends State<MySignUpClass> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> form_key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          "SignUp",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: Text(
                "SignUp",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: TextFormField(
                controller: namecontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field cannot be empty!!!";
                  }
                },
                decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: TextFormField(
                controller: emailcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field cannot be empty!!!";
                  }
                },
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: TextFormField(
                controller: passwordcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field cannot be empty!!!";
                  }
                },
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
              child: TextFormField(
                controller: phonecontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field cannot be empty!!!";
                  }
                },
                decoration: InputDecoration(
                    hintText: "PhoneNo",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen),
                onPressed: () async {
                  try {
                    var ref = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: passwordcontroller.text);
                    User? user = ref.user;
                    if (user != null) {
                      final db_ref =
                          FirebaseFirestore.instance.collection("Users").add({
                        "username": namecontroller.text,
                        "email": emailcontroller.text,
                        "password": passwordcontroller.text,
                        "phone": phonecontroller.text,
                        "uid": user.uid
                      });
                    }
                    Fluttertoast.showToast(msg: "Registered");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomeclass()));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == "invalid-email") {
                      Fluttertoast.showToast(msg: "Invaild Email Format");
                    }
                    if (e.code == "weak-password") {
                      Fluttertoast.showToast(msg: "Enter a strong password");
                    }
                    if (e.code == "email-already-in-use") {
                      Fluttertoast.showToast(msg: "Email already exists");
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: "An error occured");
                  }
                },
                child: Text(
                  "SignUp",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
