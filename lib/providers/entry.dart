import 'package:flutter/cupertino.dart';

import 'package:vegetrack/model/purchased_sbji.dart';

class entry with ChangeNotifier {
  List<purchased> _pitems = [];

  List<purchased> _temp = [];

  List<purchased> get pitems {
    return _pitems;
  }

  void addpurchaseditem(String name, DateTime date, double price) {
    final temp = purchased(date, name, price);

    _pitems.add(temp);
    _temp.add(temp);
    notifyListeners();
  }

  double get gettotalpurchase {
    double temp = 0;
    _temp.forEach((element) {
      temp = element.purchasedprice + temp;
    });
    return temp;
  }

  Map<String, List<purchased>> temp = {};
  Map<String, List<purchased>> get getallrecords {
    return temp;
  }

  void getitemsbydate() {
    final t = {
      " fs": ['a', 'b'],
      " fd": ['a', 'b'],
    };

    _pitems.forEach((element) {
      if (temp.containsKey(element.date.minute.toString())) {
        var m = temp[element.date.minute.toString()];
        m.add(element);

        temp[element.date.minute.toString()] = m;

        // print('supp');
      } else {
        print("huii");

        temp.addAll({
          element.date.minute.toString(): [element]
        });
      }
    });
  }

  void initialize() {
    _temp.clear();
    notifyListeners();
  }
}
