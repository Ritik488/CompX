import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Models/MainUser.dart';
import 'package:huncha/Screens/Competitions.dart';
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
  getUSerDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userResponse = pref.getString('Uresponse');
    userData = MainUser.fromJson(json.decode(userResponse));
    setState(() {
      username = userData.user.name;
      userMail = userData.user.email;
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
          backgroundColor: Colors.deepPurpleAccent[900],
          elevation: 5.0,
          title: Text(
            'Huncha',
            style: TextStyle(fontSize: 20.0),
          ),
          centerTitle: true,
        ),
        drawer: DrawerWidget(
          name: username,
          email: userMail,
        ),
        body: Center(
          child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Huncha \n',
                      style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        text: 'Huncha is a common Nepali word indicating an enthusiastic and positive response. Register and' +
                            'upload your artwork here. All artistic expression is priceless, however sometimes feedback from others is helpflul' +
                            ', so you will soon be able to get reviews by Huncha members and artists.\n \n',
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
                      highlightElevation: 10.0,
                        child: Text('New Competitions',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal)),
                        color: Colors.deepPurple[400],
                        onPressed: ()=>changeScreen(context, Competitions()),
                  ))
                ],
              )),
        ),
      ),
    );
  }
}
