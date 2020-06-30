import 'package:flutter/material.dart';
import 'package:huncha/Screens/Admin/adminHome.dart';
import 'package:huncha/Screens/User/HomePage.dart';
import 'package:huncha/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Controller(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Controller extends StatefulWidget {
  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  String p;

  isLoggedin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('ltoken');
    var email = pref.get('AdminEmail');
    print(token);
    print(email);
    if (token == null) {
      setState(() {
        p = 'login';
      });
    } else {
      if (email == 'org.main@admin.com') {
        setState(() {
          p = 'homeadmin';
        });
      } else {
        setState(() {
          p = 'home';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    isLoggedin();
  }

  @override
  Widget build(BuildContext context) {
    // final database = Provider.of<TokenDB>(context);
    switch (p) {
      case 'login':
        return LoginPage();
      case 'home':
        return HomePage();
      case 'homeadmin':
        return AdminHomePage();
      default:
        return LoginPage();
    }
  }
}
