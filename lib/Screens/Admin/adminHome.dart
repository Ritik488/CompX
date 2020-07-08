import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Screens/Admin/DeleteComp.dart';
import 'package:huncha/Screens/Admin/RecentDeletes.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xff3c40c6),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.business_center),
        onPressed: () => changeScreen(context, RecentDel()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'CompX Admin \n',
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.green[800],
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.0,
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
                      color: Color(0xff05c46b),
                      onPressed: () {
                        // changeScreen(context, AddCompetition());
                        _navigateAndDisplaySelection(context, AddCompetition());
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
                      color: Color(0xff05c46b),
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
                      color: Color(0xff05c46b),
                      onPressed: () => changeScreen(context, ShowUsers()))),
              SizedBox(height: 30.0),
              SizedBox(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      elevation: 10.0,
                      highlightElevation: 30.0,
                      disabledElevation: 10.0,
                      focusElevation: 10.0,
                      child: Text('Delete Competition',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                      color: Color(0xff05c46b),
                      onPressed: () {
                        _navigateAndDisplaySelection(context, DeleteComp());
                      })),
            ],
          ),
        ),
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context, Widget widget) async {
    final result = await Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => widget,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(-1.0, 0.0), end: Offset.zero)
                  .animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1.0, 0.0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          }),
    );
    _scaffoldKey.currentState
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: result != null ? Text("$result") : Text('Not interacted'),
        duration: Duration(seconds: 1),
      ));
  }
}
