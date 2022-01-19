import 'package:flutter/material.dart';

class new_card extends StatelessWidget {
  //const new_card({ Key? key }) : super(key: key);
  final String name;
  final String image;
  final bool isselected;

  const new_card({this.name, this.image, this.isselected});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      // elevation: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),

        // decoration: BoxDecoration(borderRadius: BorderRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
                child: Image(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
                opacity: isselected ? 0.5 : 1),
            Container(
              margin: EdgeInsets.only(left: 30, top: 80),
              child: Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}
