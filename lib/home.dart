import 'package:flutter/material.dart';
import 'package:myflutterapp/addpic.dart';
import 'package:myflutterapp/profile.dart';
import 'gallery.dart';

class MyHomeclass extends StatefulWidget {
  const MyHomeclass({Key? key}) : super(key: key);

  @override
  State<MyHomeclass> createState() => _MyHomeclassState();
}

class _MyHomeclassState extends State<MyHomeclass> {
  int currentindex = 1;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: currentindex);
  }

  void pageChange(index) {
    setState(() {
      currentindex = index;
      pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.photo_library_sharp,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              label: ""),
        ],
        currentIndex: currentindex,
        onTap: pageChange,
      ),
      body: PageView(
        controller: pageController,
        children: [
          MyGalleryViewClass(),
          MyAddPicClass(),
          MyProfileViewClass(),
        ],
      ),
    );
  }
}
