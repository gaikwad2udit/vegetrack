import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profile_page extends StatelessWidget {
  // const profile_page({ Key? key }) : super(key: key);
  static const routename = 'profilepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            CircleAvatar(
              child: Icon(
                Icons.person,
                size: 60,
              ),
              maxRadius: 80,
            ),
            SizedBox(
              height: 40,
            ),
            Card(
              elevation: 20,
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Container(
                height: 40,
                child: Center(
                  child: Text(
                    "Email - ${FirebaseAuth.instance.currentUser.email}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
