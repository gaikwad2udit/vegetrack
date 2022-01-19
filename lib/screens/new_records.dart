import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vegetrack/screens/user_record.dart';

class new_records extends StatelessWidget {
  //const records({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 600,
        padding: EdgeInsets.only(top: 120),
        child: ListView(
          children: [
            GFListTile(
              onTap: () {
                Navigator.of(context).pushNamed(user_records.routename);
              },
              subTitleText: "your own purchased records",
              color: Colors.amber,
              avatar: Image.network(
                'https://cdn.pixabay.com/photo/2017/11/10/05/48/user-2935527__340.png',
                height: 60,
              ),
              title: Text(FirebaseAuth.instance.currentUser.email),
            ),
            GFListTile(
              subTitleText: "members purchased records",
              color: Colors.amber,
              avatar: Image.network(
                'https://cdn.pixabay.com/photo/2017/11/10/05/46/group-2935521__340.png',
                height: 60,
              ),
              title: Text("family"),
            ),
          ],
        ),
      ),
    );
  }
}
