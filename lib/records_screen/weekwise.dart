import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:math';

class week extends StatefulWidget {
  //const week({ Key? key }) : super(key: key);
  static const Routename = "week";

  @override
  State<week> createState() => _weekState();
}

class _weekState extends State<week> {
  List data = [];

  Future query() async {
    try {
      if (ModalRoute.of(context).settings.arguments == null) {
        print("no arguments passed");
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser.email)
            .collection("Records")
            .where('day', isEqualTo: formatDate(DateTime.now(), [DD]))
            .get()
            .then((value) {
          value.docs.forEach((element) {
            print(element.data());
            data.add(element.data());
          });
        });
      } else {
        print("arugments passed");
        await FirebaseFirestore.instance
            .collection("users")
            .doc(ModalRoute.of(context).settings.arguments as String)
            .collection("Records")
            .where('day', isEqualTo: formatDate(DateTime.now(), [DD]))
            .get()
            .then((value) {
          value.docs.forEach((element) {
            data.add(element.data());
          });
        });
      }

      print(data);
      calculatetotal();
    } on PlatformException catch (e) {
      print(e);
    } catch (e) {
      print("some error");
    }
  }

  double _total = 0;

  void calculatetotal() {
    data.forEach((element) {
      _total = _total + element['purchasedprice'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print("kaise ");
    return Scaffold(
      appBar: AppBar(
        title: Text(formatDate(DateTime.now(), [DD])),
      ),
      body: FutureBuilder(
        future: query(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GFListTile(
                      //avatar: ,
                      subTitle: Text(""),
                      color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0),
                      title: Text(
                        data[index]['purchseddata'],
                        style: TextStyle(fontSize: 18),
                      ),
                      icon: Text(
                        "₹${data[index]['purchasedprice'].toString()}",
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                    // return ListTile(
                    //   leading: Text(data[index]['purchseddata']),
                    //   trailing: Text(data[index]['purchasedprice'].toString()),
                    // );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GFListTile(
                color: Colors.white,
                subTitle: Text(""),
                title: Text(
                  "Total ",
                  style: TextStyle(fontSize: 20),
                ),
                icon: Text(
                  _total.toString(),
                  style: TextStyle(fontSize: 20),
                ),
              )
              // ListTile(
              //   leading: Text("Total "),
              //   trailing: Text(_total.toString()),
              // )
            ],
          );
        },
      ),
    );
  }
}
