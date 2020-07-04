import 'package:flutter/material.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Screens/User/Competitions.dart';
import 'package:huncha/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDrawerWidget extends StatefulWidget {
  @override
  _AdminDrawerWidgetState createState() => _AdminDrawerWidgetState();
}

class _AdminDrawerWidgetState extends State<AdminDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: AssetImage('assets/admin2.jpg'),
                ),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Logout'),
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
                changeScreenRepacement(context, LoginPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
