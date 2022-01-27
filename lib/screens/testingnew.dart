import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class testingnew extends StatefulWidget {
  // const testingnew({ Key? key }) : super(key: key);
  static const Routename = 'testingnew';

  @override
  State<testingnew> createState() => _testingnewState();
}

class _testingnewState extends State<testingnew> {
  var textcontroller = TextEditingController();
  var friends = 0;

  void showdialogforadd() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("enter your family member email:"),
          content: Container(
            height: 80,
            child: TextField(
              controller: textcontroller,
              maxLines: 5,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  hintText: "enter email"),
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
                var result = await FirebaseFirestore.instance
                    .collection('emails')
                    .where('email', isEqualTo: textcontroller.text)
                    .get();

                if (!result.docs.first.data().isEmpty) {
                  await FirebaseFirestore.instance
                      .collection('requestsent')
                      .doc(FirebaseAuth.instance.currentUser.email)
                      .collection('sent')
                      .add({'username': textcontroller.text});

                  await FirebaseFirestore.instance
                      .collection('requestreceived')
                      .doc(textcontroller.text)
                      .set({
                    'sender': FirebaseAuth.instance.currentUser.email,
                    'receiver': textcontroller.text
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text("submit"),
            )
          ],
        );
      },
    );
  }

  void showdialogforreceive() async {
    var result = await FirebaseFirestore.instance
        .collection('requestreceived')
        .where('receiver', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .get();

    //print(result.docs.first.data().values.last);
    print(result.docs.length);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("requests:"),
          content: Container(
              height: 80, child: Text(result.docs.first.data().values.first)),
          actions: [
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("decline"),
            ),
            RaisedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('friends')
                    .doc(FirebaseAuth.instance.currentUser.email)
                    .collection('friendslist')
                    .add({'username': result.docs.first.data().values.last});
              },
              child: Text("accept"),
            )
          ],
        );
      },
    );
  }

  List<String> friendslist = [];
  void fetchfriend() async {
    var res = await FirebaseFirestore.instance
        .collection('friends')
        .doc(FirebaseAuth.instance.currentUser.email)
        .collection('friendslist')
        .get();
    print(res.docs.length);
    res.docs.forEach((element) {
      print(element.data());
      friendslist.add(element.data().values.first);
    });
    print(friendslist);
    setState(() {});
  }

  // Future<Map<String, dynamic>> fetchfriendsdata() async {
  //   var list
  //   var t = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(friendslist.first).collection('vegetables').get();

  //   t.docs.forEach((element) {
  //      element.data()
  //  });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchfriend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                showdialogforadd();
              },
              child: Text("add new member"),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              onPressed: () {
                showdialogforreceive();
              },
              child: Text("received request"),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                color: Colors.white,
                height: 200,
                child: ListView.builder(
                  itemCount: friendslist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        // var t = await fetchfriendsdata();
                        //t.
                      },
                      tileColor: Colors.yellow,
                      title: Text(friendslist[index]),
                      subtitle: Text('new'),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
