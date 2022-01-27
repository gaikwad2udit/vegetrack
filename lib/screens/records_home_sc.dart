import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:vegetrack/screens/friends_record_sc.dart';
import 'package:vegetrack/screens/user_record.dart';

class records_home_sc extends StatelessWidget {
  // const records_home_sc({ Key? key }) : super(key: key);
  static const routename = "record_sc";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, user_records.routename);
              },
              child: GFListTile(
                avatar: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text("Your Records"),
                color: Colors.lightBlueAccent,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, friends_records_sc.routename);
              },
              child: GFListTile(
                avatar: CircleAvatar(child: Icon(Icons.family_restroom)),
                title: Text("Your friends record"),
                color: Colors.lightBlueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
