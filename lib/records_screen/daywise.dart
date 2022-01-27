import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vegetrack/widgets/list_data.dart';

class daywise extends StatefulWidget {
  // const daywise({ Key? key }) : super(key: key);
  static const Routename = "day";
  @override
  State<daywise> createState() => _daywiseState();
}

class _daywiseState extends State<daywise> {
  var ismonday = false;
  var istuesday = false;
  var iswednesday = false;
  var isthruday = false;
  var isfriday = false;
  var issaturday = false;
  var issunday = false;

  List monday = [];
  List tuesday = [];
  List wednesday = [];
  List thrusday = [];
  List friday = [];
  List saturday = [];
  List sunday = [];
  List<Map<String, dynamic>> temp = [];

  Future<void> query() async {
    temp.clear();
    try {
      if (ModalRoute.of(context).settings.arguments as String == null) {
        print("no arg");
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser.email)
            .collection("Records")
            .get()
            .then((value) {
          value.docs.forEach((element) {
            temp.add(element.data());
          });
        });
      } else {
        print("arg");
        await FirebaseFirestore.instance
            .collection("users")
            .doc(ModalRoute.of(context).settings.arguments as String)
            .collection("Records")
            .get()
            .then((value) {
          value.docs.forEach((element) {
            temp.add(element.data());
          });
        });
      }
      // print(temp);
    } on PlatformException catch (error) {
      print("plateform error");
    } catch (error) {
      print("unknown error");
    }

    fetching();
  }

  void fetching() {
    monday.clear();
    tuesday.clear();
    wednesday.clear();
    thrusday.clear();
    friday.clear();
    saturday.clear();
    sunday.clear();

    temp.forEach((element) {
      print(element.values.first);
      if (element['day'] == 'Monday') {
        monday.add(element);
        print(monday);
      }
      if (element['day'] == 'Tuesday') {
        tuesday.add(element);
      }
      if (element['day'] == "Wednesday") {
        wednesday.add(element);
      }
      if (element['day'] == "Thursday") {
        thrusday.add(element);
      }
      if (element['day'] == "Friday") {
        friday.add(element);
      }
      if (element['day'] == 'Saturday') {
        saturday.add(element);
      }
      if (element['day'] == 'Sunday') {
        sunday.add(element);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      query();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          // color: Colors.blue,
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              GFListTile(
                titleText: "Monday",
                color: Colors.white70,
                onTap: () {
                  if (ismonday == false) {
                    print(temp);
                    setState(() {
                      ismonday = true;
                    });
                  } else {
                    setState(() {
                      ismonday = false;
                    });
                  }
                },
              ),
              if (ismonday) datacontainer(monday),
              GFListTile(
                titleText: "Tuesday",
                color: Colors.white70,
                onTap: () {
                  if (istuesday == false) {
                    setState(() {
                      istuesday = true;
                    });
                  } else {
                    setState(() {
                      istuesday = false;
                    });
                  }
                },
              ),
              if (istuesday) datacontainer(tuesday),
              GFListTile(
                titleText: "Wednesday",
                color: Colors.white70,
                onTap: () {
                  if (iswednesday == false) {
                    setState(() {
                      iswednesday = true;
                    });
                  } else {
                    setState(() {
                      iswednesday = false;
                    });
                  }
                },
              ),
              if (iswednesday) datacontainer(wednesday),
              GFListTile(
                titleText: "thrusday",
                color: Colors.white70,
                onTap: () {
                  if (isthruday == false) {
                    setState(() {
                      isthruday = true;
                    });
                  } else {
                    setState(() {
                      isthruday = false;
                    });
                  }
                },
              ),
              if (isthruday) datacontainer(thrusday),
              GFListTile(
                titleText: "Friday",
                color: Colors.white70,
                onTap: () {
                  if (isfriday == false) {
                    setState(() {
                      isfriday = true;
                    });
                  } else {
                    setState(() {
                      isfriday = false;
                    });
                  }
                },
              ),
              if (isfriday) datacontainer(friday),
              GFListTile(
                titleText: "saturday",
                color: Colors.white70,
                onTap: () {
                  if (issaturday == false) {
                    setState(() {
                      issaturday = true;
                    });
                  } else {
                    setState(() {
                      issaturday = false;
                    });
                  }
                },
              ),
              if (issaturday) datacontainer(saturday),
              GFListTile(
                titleText: "Sunday",
                color: Colors.white70,
                onTap: () {
                  if (issunday == false) {
                    setState(() {
                      issunday = true;
                    });
                  } else {
                    setState(() {
                      issunday = false;
                    });
                  }
                },
              ),
              if (issunday) datacontainer(sunday),
            ],
          )),
    );
  }
}
