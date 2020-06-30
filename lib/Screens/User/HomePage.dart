import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Models/User/MainUser.dart';
import 'package:huncha/Screens/User/Competitions.dart';
import 'package:huncha/Widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainUser userData;
  String username;
  String userMail;
  String userId;
  getUSerDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userResponse = pref.getString('Uresponse');
    userData = MainUser.fromJson(json.decode(userResponse));
    setState(() {
      username = userData.user.name;
      userMail = userData.user.email;
      userId = userData.user.sId;
    });
  }

  @override
  void initState() {
    super.initState();
    getUSerDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[900],
          elevation: 10.0,
          title: Text(
            'CompX',
            style: TextStyle(fontSize: 20.0),
          ),
          centerTitle: true,
        ),
        drawer: DrawerWidget(
          name: username,
          email: userMail,
          userId: userId,
        ),
        body: Center(
          child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'CompX \n',
                      style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        text:
                            'Thanks for downloading this app, you can participate in the competitions running at the moment..' +
                                'Please share your entries \n \n',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        elevation: 10.0,
                        highlightElevation: 30.0,
                        disabledElevation: 10.0,
                        focusElevation: 10.0,
                        child: Text('Submit your entry',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal)),
                        color: Colors.pinkAccent[400],
                        onPressed: () => changeScreen(
                            context,
                            Competitions(
                              userId: userData.user.sId,
                            )),
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
