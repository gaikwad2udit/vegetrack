import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vegetrack/screens/hommm.dart';
import 'package:vegetrack/screens/new_records.dart';
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
    user_records(),
    setting_sc()
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
  }

  @override
  Widget build(BuildContext context) {
    print(formatDate(DateTime.now(), [DD]));
    return Scaffold(
      appBar: AppBar(
        title: Text("veg app"),
        actions: [
          appbar_popmenu(),
        ],
      ),
      drawer: GFDrawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GFDrawerHeader(
              //curve: Curves.easeIn,
              closeButton: Text(''),
              child: Text('username'),
              currentAccountPicture: GFAvatar(
                child: Text("Me"),
              ),
              decoration: BoxDecoration(color: Colors.deepPurple[300]),
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("feedback"),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Exit"),
            ),
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("sigout "),
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
        selectedFontSize: 15,
        selectedItemColor: Colors.greenAccent,
        backgroundColor: Colors.black87,
        unselectedIconTheme: IconThemeData(color: Colors.white, size: 20),
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.greenAccent, size: 35),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'vegetables'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Records'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting')
        ],
        onTap: (value) {
          showscreen(value);
        },
        currentIndex: _selected,
      ),
    );
  }
}
