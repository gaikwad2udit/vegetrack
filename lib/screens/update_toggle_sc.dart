import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:vegetrack/model/sbji_bhaji.dart';
import 'package:vegetrack/providers/sbji.dart';
import 'package:vegetrack/screens/purchased_detail_sc.dart';
import 'package:vegetrack/screens/remove.sc.dart';
import 'package:vegetrack/screens/update_sc.dart';
import 'package:vegetrack/widgets/new_cards.dart';

class updadate_toggle_sc extends StatefulWidget {
//const remove_sc({ Key? key }) : super(key: key);

  static const routename = 'remove_Sc';
  final List<sbji> data;

  const updadate_toggle_sc({this.data});

  @override
  _update_toggle_sc_state createState() => _update_toggle_sc_state();
}

class _update_toggle_sc_state extends State<updadate_toggle_sc> {
  bool isloading = true;

  void addtoselectedindex(String val, String data, String image) {
    if (val == 'add') {
      selectedvege.add({data: image});
    }
    if (val == 'remove') {
      selectedvege.removeWhere((element) => element.containsKey(data));
    }
  }

  List<Map<String, String>> selectedvege = [];
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
    counter++;
    //print(selectedvege);

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
                          addtoselectedindex('remove', sbjidata[index].name,
                              sbjidata[index].image);
                        } else {
                          selectedsbji[index] = true;
                          sbjidata[index].isSelected = true;
                          addtoselectedindex('add', sbjidata[index].name,
                              sbjidata[index].image);
                        }

                        //print(selectedsbji.length);
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
                backgroundColor: Colors.orange,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(update_sc.routename, arguments: selectedvege);
                  print(selectedvege);
                },
                label: Text('update'),
                icon: Icon(Icons.save),
              )),
        ],
      ),
    );
  }
}
