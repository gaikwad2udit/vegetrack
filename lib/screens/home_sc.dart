import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vegetrack/screens/family/family_sc.dart';
import 'package:vegetrack/screens/hommm.dart';
import 'package:vegetrack/screens/new_records.dart';
import 'package:vegetrack/screens/records_home_sc.dart';
import 'package:vegetrack/screens/setting_sc.dart';
import 'package:vegetrack/screens/user_record.dart';
import 'package:vegetrack/widgets/appbar_popmenu.dart';

class Home_sc extends StatefulWidget {
  //const Home_sc({ Key? key }) : super(key: key);
  static const routename = '/home';

  @override
  State<Home_sc> createState() => _Home_scState();
}

class _Home_scState extends State<Home_sc> {
  int _selected = 0;

  List<Widget> bottomNavwidgets = <Widget>[
    hommm(),
    records_home_sc(),
    family_sc(),
    setting_sc(),
  ];

  void showscreen(int value) {
    if (value == 0) {
      setState(() {
        _selected = value;
      });
    }
    if (value == 1) {
      setState(() {
        _selected = value;
      });
    }
    if (value == 2) {
      setState(() {
        _selected = value;
      });
    }
    if (value == 3) {
      setState(() {
        _selected = value;
      });
    }
  }

  bool _islaodingfeedback = true;

  var feedbacktextcontroller = TextEditingController();

  void loadingscreen() {
    showDialog(
      context: context,
      builder: (context) {
        return Theme(
            data: Theme.of(context)
                .copyWith(dialogBackgroundColor: Colors.greenAccent),
            child: AlertDialog(
              contentPadding: EdgeInsets.only(top: 10),
              backgroundColor: Colors.greenAccent,
              title: Text("Loading"),
              content: Container(
                height: 80,
                width: 80,
                child: GFLoader(),
              ),
            ));
      },
    );
  }

  void feedbackdialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("how can we improve :"),
          content: Container(
            height: 80,
            child: TextField(
              controller: feedbacktextcontroller,
              maxLines: 5,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  hintText: "enter feedback here"),
            ),
          ),
          actions: [
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("exit"),
            ),
            RaisedButton(
              onPressed: () async {
                if (_islaodingfeedback) {
                  loadingscreen();
                  await FirebaseFirestore.instance
                      .collection('usersfeedback')
                      .doc(FirebaseAuth.instance.currentUser.email)
                      .set({'feedback': feedbacktextcontroller.text});
                  feedbacktextcontroller.clear();
                  print(feedbacktextcontroller.text);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
              child: Text("submit"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("veg app"),
        actions: [
          appbar_popmenu(),
        ],
      ),
      drawer: GFDrawer(
        color: Colors.indigo[200],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GFDrawerHeader(
              //curve: Curves.easeIn,
              closeButton: Text(''),
              child: Text(
                FirebaseAuth.instance.currentUser.email,
                style: TextStyle(fontSize: 20),
              ),
              currentAccountPicture: GFAvatar(
                backgroundColor: Colors.black38,
                child: Text("Me"),
              ),
              decoration: BoxDecoration(color: Colors.brown),
            ),
            ListTile(
              onTap: () {
                feedbackdialog();
              },
              enableFeedback: true,
              leading: Icon(Icons.feedback),
              title: Text("feedback", style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("sigout ", style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              onTap: () {
                SystemNavigator.pop();
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("Exit", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: IndexedStack(
        index: _selected,
        children: bottomNavwidgets,
      )),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.greenAccent,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 15,
        //selectedItemColor: Colors.greenAccent,
        backgroundColor: Colors.black54,
        unselectedIconTheme: IconThemeData(color: Colors.white, size: 20),
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.greenAccent, size: 35),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'vegetables'),
          BottomNavigationBarItem(
              icon: Icon(Icons.data_usage), label: 'Records'),
          BottomNavigationBarItem(
              icon: Icon(Icons.family_restroom), label: 'family'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
        ],
        onTap: (value) {
          showscreen(value);
        },
        currentIndex: _selected,
      ),
    );
  }
}
