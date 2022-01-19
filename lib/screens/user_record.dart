import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vegetrack/records_screen/daywise.dart';
import 'package:vegetrack/records_screen/weekwise.dart';
import 'package:vegetrack/widgets/appbar_popmenu.dart';

class user_records extends StatelessWidget {
  // const user_records({ Key? key }) : super(key: key);
  static const routename = "userrecordsscreen";

  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(FirebaseAuth.instance.currentUser.uid)
    //     .collection("Records")
    //     .get()
    //     .then((value) {
    //   print(value.size);
    // });

    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey,
          padding: EdgeInsets.only(top: 120),
          child: ListView(
            children: [
              GFListTile(
                subTitleText: formatDate(DateTime.now(), [DD]),
                titleText: "Today",
                color: Colors.blueGrey,
                icon: Icon(Icons.calendar_view_month_rounded),
                onTap: () async {
                  Navigator.of(context).pushNamed(week.Routename);
                },
              ),
              SizedBox(
                height: 20,
              ),
              GFListTile(
                titleText: "Week",
                subTitleText: formatDate(DateTime.now(), [W]),
                color: Colors.blueGrey,
                icon: Icon(Icons.calendar_view_month_rounded),
                onTap: () {
                  Navigator.of(context).pushNamed(daywise.Routename);
                },
              ),
              // GFListTile(
              //   titleText: "This month",
              //   subTitleText: formatDate(DateTime.now(), [MM]),
              //   color: Colors.grey,
              //   icon: Icon(Icons.calendar_view_month_rounded),
              // )
            ],
          )),
    );
  }
}
