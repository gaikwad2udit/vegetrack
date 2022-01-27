import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox_list_tile/gf_checkbox_list_tile.dart';
import 'package:getwidget/getwidget.dart';

class family_sc extends StatefulWidget {
  //const family_sc({ Key? key }) : super(key: key);
  static const routename = 'family_sc';

  @override
  State<family_sc> createState() => _family_scState();
}

class _family_scState extends State<family_sc> {
  var controllerforadd = TextEditingController();

  //dialogbox for add member
  void dialogforadd() {
    showDialog(
      context: context,
      builder: (context) {
        var status = '';
        return StatefulBuilder(
          builder: (context, setStatee) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Text("enter email"),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('exit'),
                ),
                RaisedButton(
                    onPressed: () async {
                      if (controllerforadd.text.isNotEmpty) {
                        //check for email if stored in database
                        var result = await FirebaseFirestore.instance
                            .collection('emails')
                            .where('email', isEqualTo: controllerforadd.text)
                            .get();

                        if (result.docs.isEmpty) {
                          print("hlelelele");
                          setStatee(() {
                            status = 'not found';
                          });
                        } else if (result.docs.first.data().values.first ==
                            FirebaseAuth.instance.currentUser.email) {
                          print('same user');
                          setStatee(() {
                            status = 'you cant send request to yourself';
                          });
                        } else {
                          setStatee(() {
                            status = 'request sent ';
                          });

                          await FirebaseFirestore.instance
                              .collection('requestreceived')
                              .doc(controllerforadd.text)
                              .collection('requests')
                              .doc(
                                FirebaseAuth.instance.currentUser.email,
                              )
                              .set({
                            'sender': FirebaseAuth.instance.currentUser.email,
                            'receiver': controllerforadd.text
                          });
                          controllerforadd.clear();
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: Text('send')),
              ],
              content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return Container(
                    height: 200,
                    width: 400,
                    child: Column(
                      children: [
                        TextField(
                          controller: controllerforadd,
                          decoration:
                              InputDecoration(hintText: "enter email here:"),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(status)
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  //fetching all request data

  List<String> receivedrequests = [];
  void fetchallrequests() async {
    receivedrequests.clear();
    var res = await FirebaseFirestore.instance
        .collection('requestreceived')
        .doc(FirebaseAuth.instance.currentUser.email)
        .collection('requests')
        .get();
    res.docs.forEach((element) {
      receivedrequests.add(element.data().values.last);
    });
    print(receivedrequests);
  }

  //void making copyof receivedrequest with boolean value for selection to check if selected
  List<Map<String, bool>> isselected = [];

  void initializemapforselection() {
    isselected.clear();
    receivedrequests.forEach((element) {
      isselected.add({element: false});
    });
    print(isselected);
  }

  // dialog box for request

  Future<void> dialogforrequest() {
    showDialog(
      context: context,
      builder: (context) {
        initializemapforselection();
        //List<bool> listtilecheck = [];
        //bool listtilecheck = false;
        return StatefulBuilder(
          builder: (context, setStates) {
            return AlertDialog(
              title: Text('all requests'),
              content: Builder(
                builder: (context) {
                  return Container(
                    height: 300,
                    width: 300,
                    child: ListView.builder(
                      itemCount: receivedrequests.length,
                      itemBuilder: (context, index) {
                        return GFCheckboxListTile(
                          value: isselected[index].values.first,
                          title: Text(receivedrequests[index]),
                          subTitleText: "request",
                          activeBgColor: Colors.greenAccent,
                          type: GFCheckboxType.circle,
                          activeIcon: Icon(
                            Icons.check,
                            size: 20,
                            color: Colors.white,
                          ),
                          inactiveIcon: null,
                          onChanged: (value) {
                            setStates(() {
                              isselected[index].update(
                                  receivedrequests[index], (gvalue) => value);
                              print(isselected);
                            });
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("exit"),
                ),
                RaisedButton(
                  color: Colors.greenAccent,
                  onPressed: () async {
                    //bug spotted

                    isselected
                        .where((element) => element.values.first == true)
                        .forEach((element) async {
                      print(element);

                      //adding to both frinedlist in friend db
                      await FirebaseFirestore.instance
                          .collection('friends')
                          .doc(FirebaseAuth.instance.currentUser.email)
                          .collection('friendslist')
                          .doc(element.keys.first)
                          .set({'username': element.keys.first});

                      await FirebaseFirestore.instance
                          .collection('friends')
                          .doc(element.keys.first)
                          .collection('friendslist')
                          .doc(FirebaseAuth.instance.currentUser.email)
                          .set({
                        'username': FirebaseAuth.instance.currentUser.email
                      });

                      // //then deleting the request in db
                      await FirebaseFirestore.instance
                          .collection('requestreceived')
                          .doc(FirebaseAuth.instance.currentUser.email)
                          .collection('requests')
                          .doc(element.keys.first)
                          .delete();
                      await FirebaseFirestore.instance
                          .collection('requestreceived')
                          .doc(element.keys.first)
                          .collection('requests')
                          .doc(FirebaseAuth.instance.currentUser.email)
                          .delete();
                    });

                    Navigator.pop(context);
                  },
                  child: Text("Accept"),
                )
              ],
            );
          },
        );
      },
    );
  }

  //fetching all friends/family
  List<String> friends = [];
  void fetchallmembers() async {
    friends.clear();
    var t = await FirebaseFirestore.instance
        .collection('friends')
        .doc(FirebaseAuth.instance.currentUser.email)
        .collection('friendslist')
        .get();

    t.docs.forEach((element) {
      friends.add(element.data().values.first);
    });
  }

  //dialog for all member
  void dialogforallmembers() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStatess) {
            return AlertDialog(
              title: Text("all family members:"),
              content: Builder(
                builder: (context) {
                  return Container(
                    width: 300,
                    height: 400,
                    child: ListView.builder(
                      itemCount: friends.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(friends[index]),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

//

  List<Map<String, bool>> isselectedforremove = [];

  void initializemapforremove() {
    isselectedforremove.clear();
    friends.forEach((element) {
      isselectedforremove.add({element: false});
    });
    print(isselectedforremove);
  }

//dialog for remove members

  void dialogforremovemembers() {
    showDialog(
      context: context,
      builder: (context) {
        initializemapforremove();
        bool onpressvalue = false;
        return StatefulBuilder(
          builder: (context, setStatess) {
            return AlertDialog(
              title: Text("all family members:"),
              content: Builder(
                builder: (context) {
                  return Container(
                    width: 300,
                    height: 300,
                    child: ListView.builder(
                      itemCount: friends.length,
                      itemBuilder: (context, index) {
                        return GFCheckboxListTile(
                          title: Text(friends[index]),
                          value: isselectedforremove[index].values.first,
                          onChanged: (value) {
                            setStatess(() {
                              isselectedforremove[index]
                                  .update(friends[index], (gvalue) => value);
                              print(isselectedforremove);
                            });
                          },
                          activeIcon: Icon(
                            Icons.check,
                            size: 20,
                            color: Colors.white,
                          ),
                          type: GFCheckboxType.circle,
                          activeBgColor: Colors.greenAccent,
                          //subTitle: Text("friends"),
                          inactiveIcon: null,
                        );
                      },
                    ),
                  );
                },
              ),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Exit'),
                ),
                RaisedButton(
                  color: Colors.redAccent,
                  onPressed: () async {
                    isselectedforremove
                        .where((element) => element.values.first == true)
                        .forEach((element) async {
                      await FirebaseFirestore.instance
                          .collection('friends')
                          .doc(FirebaseAuth.instance.currentUser.email)
                          .collection('friendslist')
                          .doc(element.keys.first)
                          .delete();
                      await FirebaseFirestore.instance
                          .collection('friends')
                          .doc(element.keys.first)
                          .collection('friendslist')
                          .doc(FirebaseAuth.instance.currentUser.email)
                          .delete();
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Remove'),
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            InkWell(
              onTap: () {
                dialogforadd();
              },
              child: Card(
                color: Colors.greenAccent,
                child: Container(
                  height: 50,
                  width: 200,
                  child: Center(child: Text("add member")),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                await fetchallmembers();
                dialogforremovemembers();
              },
              child: Card(
                color: Colors.redAccent,
                child: Container(
                  height: 50,
                  width: 200,
                  child: Center(child: Text("Remove member")),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                await fetchallmembers();
                dialogforallmembers();
              },
              child: Card(
                child: Container(
                  height: 50,
                  width: 200,
                  child: Center(child: Text("All members")),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                await fetchallrequests();
                dialogforrequest();
              },
              child: Card(
                color: Colors.amberAccent,
                child: Container(
                  height: 50,
                  width: 200,
                  child: Center(child: Text("member requests")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
