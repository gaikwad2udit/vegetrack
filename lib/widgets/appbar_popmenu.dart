import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vegetrack/screens/profile_page_sc.dart';

class appbar_popmenu extends StatelessWidget {
  //const appbar_popmenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // onSelected: (value) {},
      itemBuilder: (ctx) {
        return [
          PopupMenuItem(
            onTap: () {
              print("hola");
              Navigator.of(context).pushNamed(profile_page.routename);
            },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2017/11/10/05/48/user-2935527__340.png"),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(FirebaseAuth.instance.currentUser.email)
              ],
            ),
            value: 1,
          ),
        ];
      },
      icon: Icon(Icons.person_rounded),
    );
  }
}
