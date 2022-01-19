import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetrack/providers/sbji.dart';
import 'package:vegetrack/screens/new_vege_toggle.dart';

class futurebuilderforvegetoggle extends StatelessWidget {
  //const futurebuilderforvegetoggle({ Key? key }) : super(key: key);
  static const routename = "future";

  @override
  Widget build(BuildContext context) {
    var temp = Provider.of<sbjiBhaji>(context);
    return Scaffold(
      body: FutureBuilder(
        future: temp.items,
        builder: (context, snapshot) {
          print("hii there");
          if (snapshot.connectionState == ConnectionState.done) {
            var t = temp.allitems;
            return new_veg_toggle(temp: t);
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
