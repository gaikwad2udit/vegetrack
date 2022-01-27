import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:vegetrack/records_screen/weekwise.dart';
import 'package:vegetrack/screens/user_record.dart';

class friends_records_sc extends StatefulWidget {
  //const friends_records_sc({ Key? key }) : super(key: key);
  static const routename = 'friends_records_sc';

  @override
  State<friends_records_sc> createState() => _friends_records_scState();
}

class _friends_records_scState extends State<friends_records_sc> {
  List<String> friends = [];
  Future<void> fetchallmembers() async {
    friends.clear();
    var t = await FirebaseFirestore.instance
        .collection('friends')
        .doc(FirebaseAuth.instance.currentUser.email)
        .collection('friendslist')
        .get();

    t.docs.forEach((element) {
      friends.add(element.data().values.first);
    });
    print(friends.length);
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchallmembers();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchallmembers(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(user_records.routename,
                          arguments: friends[index]);
                    },
                    child: GFListTile(
                      color: Colors.white70,
                      avatar: CircleAvatar(),
                      title: Text(friends[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
