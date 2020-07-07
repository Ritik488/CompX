import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Models/User/CompetitionsModel.dart';
import 'package:huncha/Screens/User/UploadEntries.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class CompDescription extends StatefulWidget {
  final CompetitionsModel mod;
  final String userId;
  const CompDescription({Key key, this.mod, this.userId}) : super(key: key);

  @override
  _CompDescriptionState createState() => _CompDescriptionState();
}

class _CompDescriptionState extends State<CompDescription> {
  bool isButtonDisabled = false;
  var nowDate = DateTime.now();
  var difference;

  @override
  void initState() {
    super.initState();

    print(nowDate);
    var x = DateFormat("dd-MM-yyyy", "en_US").parse(widget.mod.enddate);
    print(x);
    difference = nowDate.difference(x).inDays;
    print(difference);
  }

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
        backgroundColor: Color(0xff3c40c6),
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
          difference >= 0
              ? SizedBox(
                  height: 30.0,
                )
              : SizedBox(
                  height: 0.0,
                ),
          difference >= 0
              ? Text("This Competition has ended you can't submit entries",
                  style: TextStyle(color: Colors.red, fontSize: 20.0))
              : Text(''),
          difference < 0
              ? SizedBox(
                  height: 30.0,
                )
              : SizedBox(height: 0.0),
          difference < 0
              ? SizedBox(
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
                      color: Color(0xff05c46b),
                      onPressed: () {
                        changeScreen(
                            context,
                            EntriesPage(
                                mod: widget.mod, userId: widget.userId));
                      }))
              : Text('')
        ],
      ),
    );
  }
}
