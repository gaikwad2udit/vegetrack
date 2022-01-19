import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetrack/model/purchased_sbji.dart';
import 'package:vegetrack/providers/entry.dart';

class records extends StatefulWidget {
  //const records({ Key? key }) : super(key: key);
  static const routename = 'records';
  @override
  State<records> createState() => _recordsState();
}

class _recordsState extends State<records> {
  var _isarrownotselected = true;

  List<String> minutes = [];
  List<List<purchased>> rec = [];

  dynamic getrecords(BuildContext context) {
    final records = Provider.of<entry>(context).getallrecords;
    var t = records;
    t.forEach((key, value) {
      minutes.add(key);
      rec.add(value);
    });
    return records;
  }

  @override
  Widget build(BuildContext context) {
    final records = Provider.of<entry>(context).getallrecords;
    getrecords(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("your records"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: records.length,
          itemBuilder: (ctx, i) {
            return Card(
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          if (_isarrownotselected == true) {
                            _isarrownotselected = false;
                            return;
                          }
                          _isarrownotselected = true;
                        });
                      },
                      //leading: ,
                      title: Text(minutes[i].toString()),
                      trailing: _isarrownotselected
                          ? Icon(Icons.arrow_upward)
                          : Icon(Icons.arrow_downward),
                    ),
                  ),
                  if (!_isarrownotselected)
                    Container(
                      height: 150,
                      width: 150,
                      child: ListView.builder(
                          itemCount: rec[i].length,
                          itemBuilder: (ctx, j) {
                            return ListTile(
                              leading: Text(rec[i][j].name),
                              trailing:
                                  Text(rec[i][j].purchasedprice.toString()),
                            );
                          }),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
