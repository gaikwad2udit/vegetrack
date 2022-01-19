import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetrack/providers/sbji.dart';
import 'package:vegetrack/screens/remove.sc.dart';
import 'package:vegetrack/screens/update_toggle_sc.dart';

class futurebuilderforupdate extends StatelessWidget {
  // const futurebuilderforupdate({ Key? key }) : super(key: key);
  static const routename = 'futurebuilderforupdate';

  @override
  Widget build(BuildContext context) {
    var temp = Provider.of<sbjiBhaji>(context);
    return FutureBuilder(
      future: temp.fetchlist(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var t = temp.getremovedata;
          print(t.length);
          return updadate_toggle_sc(
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
