import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:vegetrack/providers/entry.dart';
import 'package:vegetrack/providers/sbji.dart';
import 'package:date_format/date_format.dart';

class purchased_list extends StatefulWidget {
  //const pucharsed_list({ Key? key }) : super(key: key);
  final String image;
  final String name;
  void Function(String name, double val) fun;
  List<Map<String, double>> catchdata;
  purchased_list({this.image, this.name, this.fun, this.catchdata});

  @override
  State<purchased_list> createState() => _purchased_listState();
}

class _purchased_listState extends State<purchased_list> {
  var pricecontroller = TextEditingController();
  List<Map<String, double>> entereddata = [];

  @override
  var _isvalid = true;
  Widget build(BuildContext context) {
    final data = Provider.of<sbjiBhaji>(context, listen: false);

    print("object");

    return ListTile(
      contentPadding: EdgeInsets.all(15),
      leading: CircleAvatar(
        maxRadius: 40,
        backgroundImage: NetworkImage(widget.image),
      ),
      title: TextField(
          controller: pricecontroller,
          decoration: InputDecoration(
              hintText: "price", errorText: _isvalid ? null : "enter digits "),
          onSubmitted: (value) {
            // _showdialog();
            if (isNumeric(value)) {
              print(
                  "test ------------------------------------------------------");
              // print(widget.name);
              // print(value);
              entereddata.add({
                widget.name: double.tryParse(value),
              });

              widget.fun(widget.name, double.tryParse(value));

              //checkdata(widget.name, widget.catchdata);

              Provider.of<entry>(context, listen: false).addpurchaseditem(
                  widget.name, DateTime.now(), double.tryParse(value));
              setState(() {
                _isvalid = true;

                return;
              });
            } else {
              setState(() {
                _isvalid = false;
              });
            }
          }),
      trailing: Text(
          "${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}"),
    );
  }
}
