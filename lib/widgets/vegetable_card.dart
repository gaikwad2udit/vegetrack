import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetrack/providers/sbji.dart';

class vegetable_card extends StatefulWidget {
  //const vegetable_card({ Key? key }) : super(key: key);

  final String name;
  final double price;
  final String image;
  final bool isSelected;
  const vegetable_card({this.name, this.price, this.image, this.isSelected});

  @override
  State<vegetable_card> createState() => _vegetable_cardState();
}

class _vegetable_cardState extends State<vegetable_card> {
  var icon = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.network(widget.image),
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Text(widget.name),
          ),
          Container(
            child: Text(widget.price.toString()),
          ),
          IconButton(
            padding: EdgeInsets.only(left: 140),
            // color: isSelected ? Colors.blue : Colors.red,
            icon: icon
                ? Icon(Icons.favorite)
                : Icon(
                    Icons.favorite_border,
                    size: 30,
                  ),

            onPressed: () {
              setState(() {
                if (icon == true) {
                  icon = false;
                  Provider.of<sbjiBhaji>(context, listen: false)
                      .select(icon, widget.name);
                  return;
                }
                icon = true;
                Provider.of<sbjiBhaji>(context, listen: false)
                    .select(icon, widget.name);
              });
            },
          )
        ],
      ),
    );
  }
}
