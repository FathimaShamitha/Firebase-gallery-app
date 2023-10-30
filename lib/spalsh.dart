import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myflutterapp/home.dart';
import 'package:myflutterapp/signin.dart';

class MySplashscreenClass extends StatefulWidget {
  const MySplashscreenClass({Key? key}) : super(key: key);

  @override
  State<MySplashscreenClass> createState() => _MySplashscreenClassState();
}

class _MySplashscreenClassState extends State<MySplashscreenClass> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 6), () {
      var ref = FirebaseAuth.instance;
      User? user = ref.currentUser;
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MySignInClass()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomeclass()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: Lottie.asset("assets/lottie/uploadimage.json"),
        ),
      ),
    );
  }
}
