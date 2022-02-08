import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vegetrack/screens/profile_page_sc.dart';

class setting_sc extends StatelessWidget {
  //const setting_sc({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 633,
      // color: Colors.grey,
      child: Column(
        children: [
          SizedBox(
            height: 130,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(profile_page.routename);
            },
            child: CircleAvatar(
              backgroundColor: Colors.greenAccent,
              maxRadius: 50,
              child: Text(
                "profile",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: CircleAvatar(
              backgroundColor: Colors.redAccent,
              maxRadius: 50,
              child: Text(
                "logout",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
