import 'package:flutter/material.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  final String name;
  final String email;

  DrawerWidget({this.name, this.email});

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
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
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: NetworkImage(
                      'https://www.kreedon.com/wp-content/uploads/2019/05/capturing-Chess-Kreedon-1280x720.jpg'),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget>[
                    Text(
                      'Huncha',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        fontSize: 40,
                        color:Colors.black
                      ),
                    ),
                    Text(
                      'Welcome',
                      style:TextStyle(
                        fontSize: 30,
                        color:Colors.deepOrangeAccent[400]
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                      widget.name,
                      style:TextStyle(
                        fontSize: 15,
                        color:Colors.black
                      ),
                    ),
                    Text(
                      widget.email,
                      style:TextStyle(
                        fontSize: 15,
                        color:Colors.black
                      ),
                    ),
                      ],
                    )
                  ]
                )
              ),
              // accountEmail: Text(widget.email),
              // accountName: Text(widget.name),
            ),
            ListTile(
              trailing: Icon(Icons.home),
              title: Text('About Huncha'),
              onTap: () {
                Navigator.pop(context);
                // changeScreen(context, widget);
              },
            ),
            ListTile(
              trailing: Icon(Icons.school),
              title: Text('New Competition'),
              onTap: () {
                Navigator.pop(context);
                // changeScreen(context, widget);
              },
            ),
            ListTile(
              trailing: Icon(Icons.card_membership),
              title: Text('My Certificate'),
              onTap: () {
                Navigator.pop(context);
                // changeScreen(context, widget);
              },
            ),
            ListTile(
              trailing: Icon(Icons.exit_to_app),
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
