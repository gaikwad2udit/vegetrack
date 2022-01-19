import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class datacontainer extends StatelessWidget {
  // const list_data({ Key? key }) : super(key: key);

  final List day;

  datacontainer(this.day);

  double total = 0;
  void calculatetotal() {
    day.forEach((element) {
      total += element['purchasedprice'];
    });
  }

  @override
  Widget build(BuildContext context) {
    calculatetotal();
    return Container(
      height: (day.length == 0) ? 30 : 150,
      color: Colors.amber,
      child: (day == null || day.length == 0)
          ? Text("no purchase")
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: day.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(day[index]['purchseddata']),
                        trailing: Text(day[index]['purchasedprice'].toString()),
                      );
                    },
                  ),
                ),
                Opacity(
                  opacity: 0.5,
                  child: ListTile(
                    tileColor: Colors.deepOrange,
                    leading: Text("Total"),
                    trailing: Text(total.toString()),
                  ),
                )
              ],
            ),
    );
  }
}
