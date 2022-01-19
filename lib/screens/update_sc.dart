import 'package:flutter/material.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:vegetrack/widgets/listtileforupdatesc.dart';

class update_sc extends StatefulWidget {
  //const update_sc({ Key? key }) : super(key: key);
  static const routename = 'update_Sc';
  @override
  _update_scState createState() => _update_scState();
}

class _update_scState extends State<update_sc> {
  List<Map<String, String>> listforshowdialog = [];
  List<Map<String, String>> selectedvege = [];
  List<Map<String, String>> workinglist = [];

  void makefinallist() {
    listforshowdialog.clear();
    int i = 0;
    workinglist.forEach((element) {
      // print(element.keys.first);
      print(workinglist[i].values.first);

      if (!element.values.elementAt(1).isEmpty) {}

      // if (element.keys.first != workinglist[i].values.first) {
      //   print('yoyoyo');

      //   listforshowdialog
      //       .add({workinglist[i].values.first: workinglist[i].values.last});
      // }
      // if (element.values.first != workinglist[i].values.last) {
      //   print('toto');
      //   listforshowdialog
      //       .add({workinglist[i].values.first: workinglist[i].values.last});
      // }
      i++;
    });
  }

  @override
  void initState() {
    super.initState();
    // future that allows us to access context. function is called inside the future
    // otherwise it would be skipped and args would return null
    Future.delayed(Duration.zero, () {
      setState(() {
        var args = ModalRoute.of(context).settings.arguments
            as List<Map<String, String>>;
        selectedvege = args;

        // workinglist = args;

        selectedvege.forEach((element) {
          workinglist.add({
            element.keys.first: element.values.first,
            'name': "",
            'image': ""
          });
        });
      });
    });
  }

  void storeinput(String name, String imageurl, String mode, int j) {
    if (mode == 'nameremove') {
      workinglist[j].update('name', (value) => "");
      print("same same");
      print(workinglist);
      return;
    }
    if (mode == 'name') {
      workinglist[j].update('name', (value) => name);
    }
    if (mode == 'imageremove') {
      workinglist[j].update('image', (value) => "");
      print("same same");
      print(workinglist);
      return;
    }
    if (mode == 'image') {
      workinglist[j].update('image', (value) => imageurl);
    }
    print(workinglist);
  }

  void dialogbox() {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(40),
          content: Container(
            width: 80,
            height: 100,
            child: ListView.builder(
              //itemExtent: 20,
              itemCount: workinglist.length,
              itemBuilder: (context, index) {
                // print('hohohohoh');
                // print(workinglist[index].values.elementAt(1).isEmpty);
                // print(workinglist[index].values.last.isEmpty);
                return ListTile(
                    tileColor: Colors.grey,
                    title: Text(workinglist[index].keys.first),
                    trailing: Text(workinglist[index].values.elementAt(1)),
                    subtitle: workinglist[index].values.elementAt(2).isEmpty
                        ? Text("no image change")
                        : Text("Image changed")
                    //subtitle: Text(workinglist[index].values.elementAt(1)),
                    );
              },
            ),
          ),
          title: Text("Confirm"),
          actions: [
            RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("exit")),
            RaisedButton(
              onPressed: () {},
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            ListView.builder(
              // itemExtent: 140,
              itemCount: selectedvege.length,
              itemBuilder: (ctx, i) {
                return listileforupdate(
                  name: selectedvege[i].keys.first,
                  image: selectedvege[i].values.first,
                  storedata: storeinput,
                  j: i,
                );
              },
            ),
            Positioned(
                top: 600,
                left: 150,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.deepOrangeAccent,
                  onPressed: () {
                    makefinallist();
                    dialogbox();

                    // print(Fzregex.hasMatch(
                    //     workinglist[1].values.last, FzPattern.url));
                    bool validURL =
                        Uri.parse(workinglist[1].values.last).host == ''
                            ? false
                            : true;
                    print(validURL);

                    final Uri uri = Uri.tryParse(workinglist[1].values.last);
                    if (!uri.hasAbsolutePath) {
                      print('enter valid url');
                    }
                    Image ad = Image.network("a");
                  },
                  label: Text('update'),
                  icon: Icon(Icons.save),
                )),
          ],
        ),
      ),
    );
  }
}
