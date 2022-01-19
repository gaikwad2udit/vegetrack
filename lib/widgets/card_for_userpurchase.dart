import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class cardforuserpurchase extends StatelessWidget {
  //const cardforuserpurchase({ Key? key }) : super(key: key);
  final DateTime date;
  final String name;
  final double price;
  final String image;

  const cardforuserpurchase({this.date, this.name, this.price, this.image});

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      subTitle: Text(""),
      color: Colors.white70,
      avatar: Text(
        name,
        style: TextStyle(fontSize: 18),
      ),
      title: Text(date.toString().substring(0, 15)),
      icon: Text("₹${price.toString()}"),
    );
    // return ListTile(
    //   leading: Text(date.toString().substring(0, 15)),
    //   title: Text(name),
    //   trailing: RaisedButton(child: Text(price.toString())),
    // );
  }
}
