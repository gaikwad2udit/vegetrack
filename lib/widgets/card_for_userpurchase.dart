import 'package:flutter/material.dart';

class cardforuserpurchase extends StatelessWidget {
  //const cardforuserpurchase({ Key? key }) : super(key: key);
  final DateTime date;
  final String name;
  final double price;
  final String image;

  const cardforuserpurchase({this.date, this.name, this.price, this.image});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(date.toString().substring(0, 15)),
      title: Text(name),
      trailing: RaisedButton(child: Text(price.toString())),
    );
  }
}
