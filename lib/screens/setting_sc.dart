import 'package:flutter/material.dart';

class setting_sc extends StatelessWidget {
  //const setting_sc({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 633,
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: 130,
          ),
          CircleAvatar(
            backgroundColor: Colors.greenAccent,
            maxRadius: 50,
            child: Text("profile"),
          ),
          SizedBox(
            height: 40,
          ),
          CircleAvatar(
            backgroundColor: Colors.redAccent,
            maxRadius: 50,
            child: Text("logout"),
          ),
        ],
      ),
    );
  }
}
