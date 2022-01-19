import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetrack/providers/sbji.dart';
import 'package:vegetrack/screens/add_sc.dart';
import 'package:vegetrack/screens/new_vege_toggle.dart';
import 'package:vegetrack/screens/remove.sc.dart';
import 'package:vegetrack/screens/update_sc.dart';
import 'package:vegetrack/widgets/future_builderforvegetoggle.dart';
import 'package:vegetrack/widgets/futurebuilder_remove.dart';
import 'package:vegetrack/widgets/futurebuilderforupdatesc.dart';

class hommm extends StatelessWidget {
  //const hommm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //alignment: Alignment.center,
        margin: EdgeInsets.only(top: 50),
        height: 600,
        padding: EdgeInsets.only(top: 50),
        width: double.infinity,
        color: Colors.black54,
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 2),
          children: [
            InkWell(
              onTap: () {
                Provider.of<sbjiBhaji>(context, listen: false).initialize();

                Navigator.of(context)
                    .pushNamed(futurebuilderforvegetoggle.routename);
              },
              child: Card(
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
                      Image(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2016/10/25/13/16/pumpkin-1768857__340.jpg'),
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30, top: 80),
                        child: Text(
                          "vegetables",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                print("add pushed");
                Navigator.pushNamed(context, add_sc.routename);
              },
              child: Card(
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
                      Image(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2016/08/11/08/04/vegetables-1584999__340.jpg'),
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 60, top: 80),
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(futurebuilder_remove.routename);
              },
              child: Card(
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
                      Image(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/05/30/01/18/vegetables-790022__340.jpg'),
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 50, top: 80),
                        child: Text(
                          "remove",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(futurebuilderforupdate.routename);
              },
              child: Card(
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
                      Image(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/12/09/17/11/vegetables-1085063__340.jpg'),
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 60, top: 80),
                        child: Text(
                          "edit",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}


// Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             Card(
//               color: Colors.black12,
//               child: ListTile(
//                 onTap: () {
//                   //Navigator.pushNamed(context, Sbji.routename);
//                 },
//                 leading:
//                     CircleAvatar(maxRadius: 30, child: Icon(Icons.food_bank)),
//                 title: Text("all sbjis"),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Card(
//               color: Colors.black12,
//               child: ListTile(
//                 onTap: () {
//                   //Navigator.of(context).pushNamed(records.routename);
//                 },
//                 leading:
//                     CircleAvatar(maxRadius: 30, child: Icon(Icons.food_bank)),
//                 title: Text("your purchases"),
//               ),
//             ),
//           ],
//         )