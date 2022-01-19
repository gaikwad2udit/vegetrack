import 'package:flutter/material.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:provider/provider.dart';

import 'package:vegetrack/model/sbji_bhaji.dart';
import 'package:vegetrack/providers/sbji.dart';
import 'package:vegetrack/screens/purchased_detail_sc.dart';
import 'package:vegetrack/widgets/new_cards.dart';

class new_veg_toggle extends StatefulWidget {
  //const new_veg_toggle({ Key? key }) : super(key: key);
  static const routename = 'new_vwg_toggle';
  final List<sbji> temp;
  const new_veg_toggle({
    @required this.temp,
  });

  @override
  _new_veg_toggleState createState() => _new_veg_toggleState();
}

class _new_veg_toggleState extends State<new_veg_toggle> {
  MultiSelectController controller1 = MultiSelectController();
  // print(controller1.)

  int counter = 0;
  var _isselected = false;
  List<bool> selectedsbji = [];

  void setlist(int lenght) {
    print(lenght);
    for (int i = 0; i < lenght; i++) {
      selectedsbji.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final sbjidata = Provider.of<sbjiBhaji>(context, listen: false);
    //print(sbjidata.list.length);
    //sbjidata.getdatafromfirbase();
    List<sbji> sbjidata = widget.temp;
    print(sbjidata.length);

    if (counter == 0) {
      print("how many");
      setlist(sbjidata.length);
    }
    counter++;

    print(selectedsbji);
    return Scaffold(
      appBar: AppBar(
        title: Text("hold to select"),
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
                        } else {
                          selectedsbji[index] = true;
                          sbjidata[index].isSelected = true;
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
                backgroundColor: Colors.greenAccent,
                onPressed: () {
                  Navigator.of(context).pushNamed(purchased_detail.routename,
                      arguments: selectedsbji);
                },
                label: Text('save'),
                icon: Icon(Icons.save),
              )),
        ],
      ),
    );
  }
}
