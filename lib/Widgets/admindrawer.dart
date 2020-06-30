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
                  image: NetworkImage(
                      'https://image.shutterstock.com/image-photo/admin-login-sign-made-wood-260nw-1738232339.jpg'),
                ),
              ),
              child: Container(
                  // alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'CompX',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        ),
                        // Text(
                        //   'Welcome',
                        //   style:
                        //       TextStyle(fontSize: 30, color: Colors.pink[800]),
                        // ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: <Widget>[
                        //     Text(
                        //       'Admin',
                        //       style:
                        //           TextStyle(fontSize: 15, color: Colors.black),
                        //     ),
                        //   ],
                        // )
                      ])),
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
