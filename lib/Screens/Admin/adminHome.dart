import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Screens/Admin/addnewComp.dart';
import 'package:huncha/Screens/Admin/showUsers.dart';
import 'package:huncha/Screens/User/Competitions.dart';
import 'package:huncha/Screens/login.dart';
import 'package:huncha/Widgets/admindrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: Text('Admin Panel'),
        centerTitle: true,
        elevation: 10.0,
        actions: <Widget>[
          IconButton(
            tooltip: 'Logout',
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear();
              changeScreenRepacement(context, LoginPage());
            },
          )
        ],
      ),
      // drawer: AdminDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'CompX Admin \n\n',
                style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                    elevation: 10.0,
                    highlightElevation: 30.0,
                    disabledElevation: 10.0,
                    focusElevation: 10.0,
                    child: Text('Add New Competitions',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal)),
                    color: Colors.pinkAccent[400],
                    onPressed: () {
                      changeScreen(context, AddCompetition());
                    })),
            SizedBox(height: 30.0),
            SizedBox(
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                    elevation: 10.0,
                    highlightElevation: 30.0,
                    disabledElevation: 10.0,
                    focusElevation: 10.0,
                    child: Text('Show Competitions Submissions',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal)),
                    color: Colors.pinkAccent[400],
                    onPressed: () => changeScreen(context, Competitions()))),
            SizedBox(height: 30.0),
            SizedBox(
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                    elevation: 10.0,
                    highlightElevation: 30.0,
                    disabledElevation: 10.0,
                    focusElevation: 10.0,
                    child: Text('Show Users',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal)),
                    color: Colors.pinkAccent[400],
                    onPressed: () => changeScreen(context, ShowUsers()))),
          ],
        ),
      ),
    );
  }
}
