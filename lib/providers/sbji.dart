import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetrack/model/sbji_bhaji.dart';

class sbjiBhaji with ChangeNotifier {
  int i = 0;
  int counterforremove = 0;

  List<sbji> _items = [
    sbji(
      id: '1',
      image:
          'https://cdn.pixabay.com/photo/2018/09/27/22/37/spinach-3708115__340.jpg',
      price: 5.0,
      name: 'spinach',
      isSelected: false,
    ),
    sbji(
        id: '2',
        image:
            'https://cdn.pixabay.com/photo/2019/03/24/12/58/market-4077575__340.jpg',
        price: 5.0,
        name: 'sweet potato',
        isSelected: false),
    sbji(
      id: '3',
      image:
          'https://cdn.pixabay.com/photo/2015/02/27/01/08/cauliflower-651402__340.jpg',
      price: 20.0,
      name: 'cauliflower',
      isSelected: false,
    ),
    sbji(
        id: '4',
        image:
            'https://cdn.pixabay.com/photo/2016/03/29/01/06/cilantro-1287301__340.jpg',
        price: 2.0,
        name: 'coriander',
        isSelected: false),
  ];

  void addnewdata(String name, String imageurl) {
    _items.add(sbji(name: name, image: imageurl));
  }

  void removedata(List<String> names) {
    for (int i = 0; i < names.length; i++) {
      _items.removeWhere((element) => element.name == names[i]);
    }
  }

  void setint(int j) {
    i = j;
  }

  Future<void> updatelist() async {
    List<sbji> data = [];

    if (i == 0) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('vegetables')
          .get()
          .then((value) {
        print("yo");

        value.docs.forEach((element) {
          //  print(element['vegetable']);
          print("yoyoy");

          _items.add(
              sbji(image: element['imageurl'], name: element['vegetable']));
        });
        i++;
      });
    }
    //_items.add(sbji(name: namevalue, image: imagevalue));
  }

  List<sbji> firebaseonlydata = [];
  void setcounterforremove(int temp) {
    counterforremove = temp;
  }

  Future<void> fetchlist() async {
    if (counterforremove == 0) {
      firebaseonlydata.clear();

      print("heloo");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('vegetables')
          .get()
          .then((value) {
        print("yo");
        value.docs.forEach((element) {
          firebaseonlydata.add(
              sbji(image: element['imageurl'], name: element['vegetable']));
          print("yoyoy");
        });
        counterforremove++;
      });
    }
    //_items.add(sbji(name: namevalue, image: imagevalue));
  }

  Future<List<sbji>> get items async {
    await updatelist();
    return _items;
  }

  List<sbji> get allitems {
    return _items;
  }

  List<sbji> get getremovedata {
    return firebaseonlydata;
  }

  void select(bool sel, String name) {
    final index = _items.indexWhere((element) => element.name == name);
    _items[index].isSelected = sel;
    notifyListeners();
  }

  int listlength() {
    int counter = 0;
    _items.forEach((element) {
      if (element.isSelected == true) {
        counter++;
      }
    });
    return counter;
  }

  List<sbji> get getsbji {
    List<sbji> temp = [];
    _items.forEach((element) {
      if (element.isSelected == true) {
        temp.add(element);
      }
    });
    return temp;
  }

  void initialize() {
    _items.forEach((element) {
      element.isSelected = false;
    });
    notifyListeners();
  }
}
