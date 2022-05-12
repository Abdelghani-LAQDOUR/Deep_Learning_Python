// ignore_for_file: prefer_const_constructors

import 'package:fice_id/pages/minist/drawing_page.dart';
import 'package:fice_id/pages/minist/upload_page.dart';
import 'package:flutter/material.dart';

/*==================================> Classe Club One <=============================*/
class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final pagecontroller = PageController(initialPage: 0);
  bool canScroll = true;
  /*----------- Fonction Build -------------*/
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(canScroll ? Icons.lock_open_sharp : Icons.lock),
                onPressed: () {
                  setState(() {
                    canScroll = !canScroll;
                  });
                }),
            Text("Mnist", textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.of(context).pushNamed("/login");
                }),
          ],
        )),
      ),
      body: PageView(
        physics: canScroll ? ScrollPhysics() : NeverScrollableScrollPhysics(),
        controller: pagecontroller,
        scrollDirection: Axis.horizontal,
        children: [
          UploadImage(),
          DrawPage(),
        ],
      ),
    ));
  }
}
