import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';

class week extends StatelessWidget {
  //const week({ Key? key }) : super(key: key);
  static const Routename = "week";
  List data = [];

  Future query() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("Records")
          .where('day', isEqualTo: formatDate(DateTime.now(), [DD]))
          .get()
          .then((value) {
        value.docs.forEach((element) {
          data.add(element.data());
        });
      });
      print('yo yo ');
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
                      color: Colors.white,
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
