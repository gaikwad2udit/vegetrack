import 'dart:math';
import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:vegetrack/providers/entry.dart';
import 'package:vegetrack/widgets/card_for_userpurchase.dart';

class current_detail extends StatelessWidget {
  //const current_detail({ Key? key }) : super(key: key);
  static const routename = 'puchased_oc_sc';
  @override
  Widget build(BuildContext context) {
    final entrydata = Provider.of<entry>(context, listen: false).pitems;
    final total = Provider.of<entry>(context, listen: false).gettotalpurchase;
    //
    return Scaffold(
      appBar: AppBar(
        title: Text("your today purchase"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              itemCount: entrydata.length,
              itemBuilder: (ctx, i) {
                return cardforuserpurchase(
                  name: entrydata[i].name,
                  date: entrydata[i].date,
                  price: entrydata[i].purchasedprice,
                );
              },
            ),
          ),
          SizedBox(
            height: 100,
          ),
          GFListTile(
              subTitle: Text(""),
              color: Colors.white,
              avatar: Text(
                "Total purchase amount:      ",
                style: TextStyle(fontSize: 18),
              ),
              icon: Text(
                "\$$total",
                style: TextStyle(fontSize: 18),
              )),

          // ListTile(
          //     leading: Text("Total purchase amount:      "),
          //     trailing: Text("\$$total")),
          RaisedButton(
            onPressed: () {
              Provider.of<entry>(context, listen: false).getitemsbydate();
              Provider.of<entry>(context, listen: false).initialize();
              Navigator.of(context).pushNamed('/home');
              //Navigator.of(context).pop();
            },
            child: Text("Home"),
          ),
        ],
      ),
    );
  }
}
