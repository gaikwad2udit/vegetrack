import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:vegetrack/providers/sbji.dart';
import 'package:vegetrack/screens/current_user_purchase.dart';
import 'package:vegetrack/widgets/purchased_list.dart';

class purchased_detail extends StatefulWidget {
  //const purchased_detail({ Key? key }) : super(key: key);

  static const routename = 'purchsed_sc';

  @override
  State<purchased_detail> createState() => _purchased_detailState();
}

class _purchased_detailState extends State<purchased_detail> {
  bool isloading = true;
  List<Map<String, double>> catchdata = [];

  Function fun(String name, double val) {
    bool temp = false;

    catchdata.forEach((element) {
      if (element.containsKey(name)) {
        temp = true;
        return;
      }
    });

    if (!temp) {
      catchdata.add({name: val});
    } else {
      catchdata.removeWhere((element) => element.containsKey(name));
      catchdata.add({name: val});
    }

    print("you pressed");
    print(catchdata);
  }

  List<String> keys = [];

  List<double> values = [];

  Future<void> getkeyandvalues() {
    keys = [];
    values = [];

    catchdata.forEach((element) {
      element.forEach((key, value) {
        keys.add(key);
        values.add(value);
      });
    });
  }

  void loadingscreen() {
    showDialog(
      context: context,
      builder: (context) {
        return Theme(
            data: Theme.of(context)
                .copyWith(dialogBackgroundColor: Colors.greenAccent),
            child: AlertDialog(
              contentPadding: EdgeInsets.only(top: 10),
              backgroundColor: Colors.greenAccent,
              title: Text("Loading"),
              content: Container(
                height: 80,
                width: 80,
                child: GFLoader(),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _showdialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("vegetables"),
            content: SingleChildScrollView(
              child: Container(
                height: 100,
                width: 100,
                child: ListView.builder(
                  itemExtent: 20,
                  itemCount: catchdata.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(keys[index]),
                      trailing: Text(values[index].toString()),
                    );
                  },
                ),
              ),
            ),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("exit"),
              ),
              RaisedButton(
                child: Text("submit"),
                onPressed: () async {
                  if (isloading) {
                    loadingscreen();
                    for (int i = 0; i < keys.length; i++) {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser.email)
                          .collection("Records")
                          .add(
                        {
                          "day": formatDate(DateTime.now(), [DD]),
                          "datetme": Timestamp.now(),
                          "purchseddata": keys[i],
                          "username": FirebaseAuth.instance.currentUser.email,
                          "purchasedprice": values[i],
                        },
                      );
                    }
                    setState(() {
                      isloading = false;
                    });
                  }

                  Navigator.of(context)
                      .pushNamed(current_detail.routename)
                      .then((value) {
                    setState(() {
                      isloading = false;
                    });
                  });

                  Provider.of<sbjiBhaji>(context, listen: false).initialize();
                },
              ),
            ],
          );
        },
      );
    }

    final selecteddata =
        ModalRoute.of(context).settings.arguments as List<bool>;
    print(" data = $selecteddata");

    final data = Provider.of<sbjiBhaji>(context, listen: false);
    final sbjidata = data.getsbji;

    return Scaffold(
      appBar: AppBar(
        title: Text("fill prices"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            ListView.builder(
              itemCount: data.listlength(),
              itemBuilder: (ctx, i) {
                return purchased_list(
                  fun: fun,
                  catchdata: catchdata,
                  image: sbjidata[i].image,
                  name: sbjidata[i].name,
                );
              },
            ),
            Positioned(
                top: 600,
                left: 150,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.greenAccent,
                  onPressed: () async {
                    await getkeyandvalues();
                    _showdialog();

                    //print(catchdata);
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
