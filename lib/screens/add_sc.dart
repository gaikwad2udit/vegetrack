import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:vegetrack/providers/sbji.dart';
import 'package:vegetrack/screens/home_sc.dart';

class add_sc extends StatefulWidget {
  //const add_sc({ Key? key }) : super(key: key);
  static const routename = "addsc";

  @override
  State<add_sc> createState() => _add_scState();
}

class _add_scState extends State<add_sc> {
  var namecontroller = TextEditingController();
  var key = GlobalKey<FormState>();
  var imagecontroller = TextEditingController();

  bool submitandvalidate() {
    if (key.currentState.validate()) {
      print(namecontroller.text);
      print("succes");
      return true;
    }
    print("error");
    return false;
  }

  void showdialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("confirm"),
          content: Container(
            height: 100,
            width: 100,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imagecontroller.text),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(namecontroller.text)
              ],
            ),
          ),
          actions: [
            RaisedButton(
              child: Text("exit"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            RaisedButton(
              child: Text("submit"),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .collection("vegetables")
                    .doc()
                    .set({
                  "vegetable": namecontroller.text,
                  "imageurl": imagecontroller.text
                });
                Provider.of<sbjiBhaji>(context, listen: false)
                    .addnewdata(namecontroller.text, imagecontroller.text);
                Provider.of<sbjiBhaji>(context, listen: false)
                    .setcounterforremove(0);

                // Provider.of<sbjiBhaji>(context, listen: false).setint(0);
                // await Provider.of<sbjiBhaji>(context).updatelist( );
                Navigator.popUntil(context, (route) => route.isFirst);

                //Navigator.popAndPushNamed(context, Home_sc.routename);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Form(
              key: key,
              child: ListView(
                padding: EdgeInsets.only(top: 80),
                children: [
                  Card(
                    child: ListTile(
                      leading: Text(
                        "name",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: TextFormField(
                        validator: (value) {
                          if (value.length == 0 || !isAlpha(value)) {
                            return "enter name only";
                          }
                          return null;
                        },
                        key: ValueKey("name"),
                        decoration:
                            InputDecoration(hintText: "enter vegetable name "),
                        controller: namecontroller,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Text(
                        "image",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: TextFormField(
                        validator: (value) {
                          if (value.length == 0 ||
                              !Uri.parse(value).isAbsolute) {
                            return "enter image url";
                          }
                          return null;
                        },
                        key: ValueKey("iamge"),
                        decoration:
                            InputDecoration(hintText: "enter image url"),
                        controller: imagecontroller,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 600,
                left: 150,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.greenAccent,
                  onPressed: () {
                    if (submitandvalidate()) {
                      showdialog();
                    }
                  },
                  label: Text('save'),
                  icon: Icon(Icons.save),
                )),
          ],
        ),
      ),
    );
  }
}
