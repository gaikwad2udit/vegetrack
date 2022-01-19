import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetrack/providers/sbji.dart';
import 'package:vegetrack/screens/remove.sc.dart';

class futurebuilder_remove extends StatefulWidget {
  //const futurebuilder_remove({ Key? key }) : super(key: key);
  static const routename = "futurebuilderemove_Sc";
  @override
  _futurebuilder_removeState createState() => _futurebuilder_removeState();
}

class _futurebuilder_removeState extends State<futurebuilder_remove> {
  @override
  Widget build(BuildContext context) {
    var temp = Provider.of<sbjiBhaji>(context);
    return FutureBuilder(
      future: temp.fetchlist(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var t = temp.getremovedata;
          print(t.length);
          return remove_sc(
            data: t,
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
