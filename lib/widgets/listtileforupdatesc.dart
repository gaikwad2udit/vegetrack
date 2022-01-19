import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:string_validator/string_validator.dart';

class listileforupdate extends StatefulWidget {
  //const listileforupdate({ Key? key }) : super(key: key);
  final Function(String name, String image, String mode, int j) storedata;
  final String image;
  final String name;
  final int j;
  const listileforupdate({this.storedata, this.image, this.name, this.j});

  @override
  State<listileforupdate> createState() => _listileforupdateState();
}

class _listileforupdateState extends State<listileforupdate> {
  bool isuuperbutton = true;
  bool islowerbutton = true;

  var namecontroller = TextEditingController();
  var imagecontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  void inputvalidatorandsave() {}

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo,
      child: Form(
        key: formkey,
        child: GFListTile(
          avatar: Stack(
            children: [
              Image.network(
                widget.image,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 10),
                child: Text(
                  widget.name,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          title: isuuperbutton
              ? Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: RaisedButton(
                    child: Text("name"),
                    onPressed: () {
                      setState(() {
                        isuuperbutton = false;
                      });
                    },
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        key: ValueKey("name"),
                        onFieldSubmitted: (newValue) {
                          if (formkey.currentState.validate()) {
                            print(namecontroller.text);

                            widget.storedata(namecontroller.text, widget.image,
                                'name', widget.j);
                          }
                        },
                        validator: (value) {
                          if (value.length == 0 || !isAlpha(value)) {
                            return "enter name only";
                          }
                          return null;
                        },
                        controller: namecontroller,
                        decoration: InputDecoration(hintText: "name"),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isuuperbutton = true;

                            namecontroller.clear();

                            widget.storedata(
                                widget.name,
                                imagecontroller.text.isEmpty
                                    ? widget.image
                                    : imagecontroller.text,
                                'nameremove',
                                widget.j);
                          });
                        },
                        icon: Icon(Icons.cancel_rounded))
                  ],
                ),
          subTitle: islowerbutton
              ? Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: RaisedButton(
                    child: Text("imageurl"),
                    onPressed: () {
                      setState(() {
                        islowerbutton = false;
                      });
                    },
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (newValue) {
                          if (formkey.currentState.validate()) {
                            print(namecontroller.text);
                            print(imagecontroller.text);

                            widget.storedata(widget.name, imagecontroller.text,
                                'image', widget.j);
                          }
                        },
                        key: ValueKey("image"),
                        validator: (value) {
                          if (value.length == 0 ||
                              !Uri.parse(value).isAbsolute) {
                            return "enter image url";
                          }
                          return null;
                        },
                        controller: imagecontroller,
                        decoration: InputDecoration(hintText: "imageurl"),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            islowerbutton = true;
                            imagecontroller.clear();
                            widget.storedata(
                                namecontroller.text.isEmpty
                                    ? widget.name
                                    : namecontroller.text,
                                widget.image,
                                'imageremove',
                                widget.j);
                          });
                        },
                        icon: Icon(Icons.cancel_rounded))
                  ],
                ),
        ),
      ),
    );
  }
}






// ListTile(
//           leading: CircleAvatar(
//             maxRadius: 35,
//             backgroundImage: NetworkImage(widget.image),
//           ),
//           title: isuuperbutton
//               ? RaisedButton(
//                   child: Text("name"),
//                   onPressed: () {
//                     setState(() {
//                       isuuperbutton = false;
//                     });
//                   },
//                 )
//               : Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         key: ValueKey("name"),
//                         onFieldSubmitted: (newValue) {
//                           if (formkey.currentState.validate()) {
//                             print(namecontroller.text);
//                             print(imagecontroller.text);
//                             //   if(imagecontroller.text == null ){

//                             //   }
//                             // List<Map<String, String>> temp = [];
//                             // temp.add({namecontroller.text: imagecontroller.text});
//                             //  widget.storedata(temp);

//                           }
//                         },
//                         validator: (value) {
//                           if (value.length == 0 || !isAlpha(value)) {
//                             return "enter name only";
//                           }
//                           return null;
//                         },
//                         controller: namecontroller,
//                         decoration: InputDecoration(hintText: "name"),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 80,
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isuuperbutton = true;
//                           });
//                         },
//                         icon: Icon(Icons.cancel_rounded))
//                   ],
//                 ),
//           subtitle: islowerbutton
//               ? RaisedButton(
//                   child: Text("imageurl"),
//                   onPressed: () {
//                     setState(() {
//                       islowerbutton = false;
//                     });
//                   },
//                 )
//               : Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         onFieldSubmitted: (newValue) {
//                           if (formkey.currentState.validate()) {
//                             print(namecontroller.text);
//                             print(imagecontroller.text);
//                             if (islowerbutton == false) {}
//                             List<Map<String, String>> temp = [];
//                             temp.add(
//                                 {namecontroller.text: imagecontroller.text});
//                             // widget.storedata(temp);

//                           }
//                         },
//                         key: ValueKey("image"),
//                         validator: (value) {
//                           if (value.length == 0 ||
//                               !Uri.parse(value).isAbsolute) {
//                             return "enter image url";
//                           }
//                           return null;
//                         },
//                         controller: imagecontroller,
//                         decoration: InputDecoration(hintText: "imageurl"),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 80,
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           setState(() {
//                             islowerbutton = true;
//                           });
//                         },
//                         icon: Icon(Icons.cancel_rounded))
//                   ],
//                 ),
//         ),