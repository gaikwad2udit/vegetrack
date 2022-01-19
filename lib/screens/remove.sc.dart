import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:vegetrack/model/sbji_bhaji.dart';
import 'package:vegetrack/providers/sbji.dart';
import 'package:vegetrack/screens/purchased_detail_sc.dart';
import 'package:vegetrack/widgets/new_cards.dart';

class remove_sc extends StatefulWidget {
//const remove_sc({ Key? key }) : super(key: key);

  static const routename = 'remove_Sc';
  final List<sbji> data;

  const remove_sc({this.data});

  @override
  _remove_scState createState() => _remove_scState();
}

class _remove_scState extends State<remove_sc> {
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

  //showdialog

  bool isloading = true;
  void showdialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("are you sure"),
          content: Container(
            width: 80,
            height: 100,
            child: ListView.builder(
              itemExtent: 20,
              itemCount: selectedvege.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(selectedvege[index]),
                );
              },
            ),
          ),
          actions: [
            Theme(
              data:
                  Theme.of(context).copyWith(backgroundColor: Colors.redAccent),
              child: RaisedButton(
                child: Text("exit"),
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            RaisedButton(
              child: Text("confirm"),
              color: Colors.greenAccent,
              onPressed: () async {
                if (isloading) {
                  loadingscreen();
                  List<String> toberemovelist = [];
                  for (int i = 0; i < selectedvege.length; i++) {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .collection("vegetables")
                        .where('vegetable', isEqualTo: selectedvege[i])
                        .get()
                        .then((value) {
                      value.docs.forEach((element) {
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection('vegetables')
                            .doc(element.id)
                            .delete()
                            .then((value) {
                          print("success");
                        });
                      });
                    });
                  }
                  Provider.of<sbjiBhaji>(context, listen: false)
                      .setcounterforremove(0);
                  Provider.of<sbjiBhaji>(context, listen: false)
                      .removedata(selectedvege);

                  setState(() {
                    isloading = false;
                  });
                }
                Navigator.pop(context);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                //Navigator.of(context);
              },
            )
          ],
        );
      },
    );
  }

  void addtoselectedindex(String val, String data) {
    if (val == 'add') {
      selectedvege.add(data);
    }
    if (val == 'remove') {
      selectedvege.removeWhere((element) => element == data);
    }
  }

  List<String> selectedvege = [];
  var controller1 = MultiSelectController();
  int counter = 0;
  var _isselected = false;
  List<bool> selectedsbji = [];

  void setlist(
    int lenght,
  ) {
    print(lenght);
    for (int i = 0; i < lenght; i++) {
      selectedsbji.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var sbjidata = widget.data;
    if (counter == 0) {
      setlist(sbjidata.length);
    }

    print(selectedvege);

    return Scaffold(
      appBar: AppBar(
        title: Text("Hold to select"),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 780,
            color: Colors.black87,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: sbjidata.length,
                itemBuilder: (ctx, index) {
                  return MultiSelectItem(
                    isSelecting: _isselected,
                    onSelected: () {
                      setState(() {
                        controller1.toggle(index);
                        print(controller1.selectedIndexes);
                        if (selectedsbji[index] == true) {
                          selectedsbji[index] = false;
                          sbjidata[index].isSelected = false;
                          addtoselectedindex('remove', sbjidata[index].name);
                        } else {
                          selectedsbji[index] = true;
                          sbjidata[index].isSelected = true;
                          addtoselectedindex('add', sbjidata[index].name);
                        }

                        print(selectedsbji.length);
                      });
                    },
                    child: new_card(
                      image: sbjidata[index].image,
                      name: sbjidata[index].name,
                      isselected: controller1.isSelected(index),
                    ),
                  );
                }),
          ),
          Positioned(
              top: 600,
              left: 150,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.redAccent,
                onPressed: () {
                  showdialog();
                },
                label: Text('remove'),
                icon: Icon(Icons.save),
              )),
        ],
      ),
    );
  }
}
