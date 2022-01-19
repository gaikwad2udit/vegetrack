import 'package:flutter/material.dart';

class loading extends StatefulWidget {
  //const loading({ Key? key }) : super(key: key);

  @override
  _loadingState createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.greenAccent,
          ),
        ),
      ),
    );
  }
}
