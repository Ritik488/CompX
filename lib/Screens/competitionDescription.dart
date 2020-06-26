import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Models/CompetitionsModel.dart';
import 'package:huncha/Screens/UploadImage.dart';
import 'package:url_launcher/url_launcher.dart';

class CompDescription extends StatefulWidget {
  final CompetitionsModel mod;
  final String userId;
  const CompDescription({Key key, this.mod, this.userId}) : super(key: key);

  @override
  _CompDescriptionState createState() => _CompDescriptionState();
}

class _CompDescriptionState extends State<CompDescription> {
  _launchEmail() async {
    // await launch(widget.mod.urls.toString());
    if (await canLaunch(widget.mod.urls)) {
      await launch(widget.mod.urls);
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        elevation: 10.0,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          Container(
              height: 300.0,
              child: Image(
                  fit: BoxFit.fill, image: NetworkImage(widget.mod.images))),
          SizedBox(
            height: 20.0,
          ),
          Text('Title',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Text(widget.mod.name,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal)),
          SizedBox(
            height: 20.0,
          ),
          Text('Description',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Center(
            child: Text(widget.mod.name,
                style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal)),
          ),
          SizedBox(height: 20.0),
          Center(
              child: Text(widget.mod.minidesc,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
          SizedBox(height: 20.0),
          Text(widget.mod.description,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal)),
          SizedBox(height: 20.0),
          Wrap(
            children: <Widget>[
              Text(
                'Important: ' + widget.mod.important,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              // Text(widget.mod.important,
              // style:TextStyle(fontSize: 20.0,fontWeight: FontWeight.normal))
            ],
          ),
          SizedBox(height: 20.0),
          Text('Campaign brief',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 20.0),
          Text(widget.mod.campaignbrief,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal)),
          SizedBox(height: 30.0),
          Center(
            child: GestureDetector(
              child: Text(
                'Open this link to know More Details',
                style: TextStyle(
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w100),
              ),
              onTap: () {
                _launchEmail();
              },
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          SizedBox(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                elevation: 10.0,
                highlightElevation: 30.0,
                disabledElevation: 10.0,
                focusElevation: 10.0,
                child: Text('Add your details',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.normal)),
                color: Colors.pinkAccent[400],
                onPressed: () => changeScreen(context, EntriesPage(mod: widget.mod,userId: widget.userId,)),
              ))
        ],
      ),
    );
  }
}
