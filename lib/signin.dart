import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myflutterapp/signup.dart';
import 'home.dart';

class MySignInClass extends StatefulWidget {
  const MySignInClass({Key? key}) : super(key: key);

  @override
  State<MySignInClass> createState() => _MySignInClassState();
}

class _MySignInClassState extends State<MySignInClass> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  GlobalKey<FormState> form_key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          "SignIn",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: Text(
                "SignIn",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.lightGreen),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: TextFormField(
                controller: emailcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email field cannot be empty!!!!";
                  }
                },
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
              child: TextFormField(
                controller: passwordcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password field cannot be empty";
                  }
                },
                decoration: InputDecoration(
                    hintText: "Password",
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
                        .signInWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: passwordcontroller.text);
                    Fluttertoast.showToast(msg: "Login Success");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomeclass()));
                  } on FirebaseAuthException catch (e) {
                    Fluttertoast.showToast(
                        msg: "Enter avalid email and password");
                  }
                },
                child: Text(
                  "SignIn",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New User?",
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MySignUpClass()));
                    },
                    child: Text(
                      "SignUp",
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
