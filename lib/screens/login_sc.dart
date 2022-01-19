import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login_page extends StatelessWidget {
  //const Login_page({ Key? key }) : super(key: key);
  static const Routename = "authscreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.pinkAccent,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.srcOver),
            fit: BoxFit.cover,
            image: const AssetImage('lib/assets/home.jpg'),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: auth_card(),
        ),
      ),
    );
  }
}

class auth_card extends StatefulWidget {
  //const auth_card({ Key? key }) : super(key: key);

  @override
  _auth_cardState createState() => _auth_cardState();
}

class _auth_cardState extends State<auth_card> {
  var auth = true;
  var _key = GlobalKey<FormState>();
  var confirmpassword;

  var username = "";
  var Password = '';

  final authuser = FirebaseAuth.instance;

  void formsubittofirebsae() async {
    try {
      if (auth) {
        await authuser.signInWithEmailAndPassword(
            email: username, password: Password);
      } else {
        await authuser.createUserWithEmailAndPassword(
            email: username, password: Password);
      }
    } on PlatformException catch (error) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("error occured ")));
    } catch (error) {}
  }

//raised buttons swapping based on auth value
  List<Widget> showbuttons() {
    //List<RaisedButton> data;
    if (auth) {
      return [
        RaisedButton(
          onPressed: () {
            if (!_key.currentState.validate()) {
              return;
            }
            _key.currentState.save();
            formsubittofirebsae();
            setState(() {});
          },
          color: Colors.greenAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Text(
            "  Log In  ",
            style: TextStyle(fontSize: 22),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        RaisedButton(
          onPressed: () {
            _key.currentState.reset();

            setState(() {
              auth = false;
              print(auth);
            });
          },
          color: Colors.greenAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Text(
            "  Sign Up  ",
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ];
    } else {
      return [
        RaisedButton(
          onPressed: () {
            if (!_key.currentState.validate()) {
              return;
            }
            _key.currentState.save();
            formsubittofirebsae();
            print("$username - $Password");
            setState(() {});
          },
          color: Colors.greenAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Text(
            "  sign up  ",
            style: TextStyle(fontSize: 22),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        RaisedButton(
          onPressed: () {
            _key.currentState.reset();

            setState(() {
              auth = true;
              print(auth);
            });
          },
          color: Colors.greenAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Text(
            "  login  ",
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    print("supp");
    return Opacity(
      opacity: 0.7,
      child: Card(
        margin: EdgeInsets.only(top: 150, bottom: 150, left: 20, right: 20),
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    key: ValueKey("username"),
                    decoration: InputDecoration(labelText: "UserName"),
                    //autovalidate: true,
                    validator: (value) {
                      if (value.isEmpty || value.length <= 3) {
                        return "username must be greater than 4 characters";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      username = newValue;
                    },
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      Password = newValue;
                    },
                    //autovalidate: true,
                    validator: (value) {
                      if (value.length < 6 || value.contains(' ')) {
                        return "greator than 6 characters and do not include whitespace";
                      }
                      confirmpassword = value;
                      return null;
                    },

                    key: ValueKey("password"),
                    decoration: InputDecoration(labelText: "password"),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  if (!auth)
                    TextFormField(
                      validator: (value) {
                        if (value != confirmpassword) {
                          return "password do not match";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Re enter password",
                          labelStyle: TextStyle(color: Colors.blue)),
                    ),
                  ...showbuttons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
