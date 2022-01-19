import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegetrack/providers/entry.dart';
import 'package:vegetrack/providers/sbji.dart';
import 'package:vegetrack/records_screen/daywise.dart';
import 'package:vegetrack/records_screen/weekwise.dart';
import 'package:vegetrack/screens/add_sc.dart';
import 'package:vegetrack/screens/all_purchase_record.dart';
import 'package:vegetrack/screens/current_user_purchase.dart';
import 'package:vegetrack/screens/home_sc.dart';
import 'package:vegetrack/screens/loding_sc.dart';
import 'package:vegetrack/screens/login_sc.dart';
import 'package:vegetrack/screens/new_vege_toggle.dart';
import 'package:vegetrack/screens/profile_page_sc.dart';
import 'package:vegetrack/screens/purchased_detail_sc.dart';
import 'package:vegetrack/screens/remove.sc.dart';
import 'package:vegetrack/screens/update_sc.dart';
import 'package:vegetrack/screens/user_record.dart';
import 'package:vegetrack/widgets/future_builderforvegetoggle.dart';
import 'package:vegetrack/widgets/futurebuilder_remove.dart';
import 'package:vegetrack/widgets/futurebuilderforupdatesc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("loginin ini nn inin ni");
          return loading();
        }
        if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (ctx) {
                return sbjiBhaji();
              }),
              ChangeNotifierProvider(create: (ctx) {
                return entry();
              }),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.grey,
                  appBarTheme: AppBarTheme(
                      titleSpacing: 85,
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
              initialRoute: Home_sc.routename,
              routes: {
                '/home': (_) => Home_sc(),
                //Sbji_list.routename: (_) => Sbji_list(),
                purchased_detail.routename: (_) => purchased_detail(),
                current_detail.routename: (_) => current_detail(),
                records.routename: (_) => records(),
                new_veg_toggle.routename: (_) => new_veg_toggle(),
                user_records.routename: (_) => user_records(),
                daywise.Routename: (_) => daywise(),
                week.Routename: (_) => week(),
                add_sc.routename: (_) => add_sc(),
                futurebuilderforvegetoggle.routename: (_) =>
                    futurebuilderforvegetoggle(),
                remove_sc.routename: (_) => remove_sc(),
                futurebuilder_remove.routename: (_) => futurebuilder_remove(),
                update_sc.routename: (_) => update_sc(),
                futurebuilderforupdate.routename: (_) =>
                    futurebuilderforupdate(),
                profile_page.routename: (_) => profile_page(),
              },
            ),
          );
        } else {
          return MaterialApp(
            home: Login_page(),
          );
        }
      },
    );
  }
}
