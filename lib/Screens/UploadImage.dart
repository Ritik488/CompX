import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:huncha/Helper/RequestHttp.dart';
import 'package:huncha/Models/CompetitionsModel.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

class EntriesPage extends StatefulWidget {
  final CompetitionsModel mod;
  final String userId;

  const EntriesPage({Key key, this.mod, this.userId}) : super(key: key);
  @override
  _EntriesPageState createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  var imageUrl;
  bool isloading = false;
  String videoUrl;
  String message;
  bool showResponse;
  String error = '';
  final picker = ImagePicker();
  var _formKey = GlobalKey<FormState>();
  Future uploadImage() async {
    const url = "https://api.cloudinary.com/v1_1/dcsqiv7je/image/upload";
    var image = await picker.getImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        isloading = true;
      });
    }

    if (image != null) {
      FormData formData = new FormData.fromMap({
        "file": await MultipartFile.fromFile(
          image.path,
        ),
        "upload_preset": "project78",
        "cloud_name": "dcsqiv7je",
      });
      try {
        Response response = await Dio().post(url, data: formData);
        var data = jsonDecode(response.toString());
        print(response.data);
        print(data['secure_url']);

        setState(() {
          isloading = false;
          imageUrl = data['secure_url'];
          print(imageUrl);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
        backgroundColor: Colors.pink[900],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text('Upload Contest Information',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700])),
                ),
                SizedBox(height: 10.0),
                Text('Title',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                SizedBox(height: 10.0),
                Text(widget.mod.minidesc, style: TextStyle(fontSize: 15.0)),
                SizedBox(height: 30.0),
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.pink[900],
                    backgroundImage: imageUrl != null
                        ? NetworkImage(imageUrl, scale: 0.3)
                        : null,
                    child: imageUrl == null
                        ? !isloading
                            ? Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.white,
                              )
                            : Loading(
                                indicator: BallPulseIndicator(),
                                size: 100.0,
                                color: Colors.green,
                              )
                        : Container(),
                  ),
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                      icon: Icon(Icons.airplay), hintText: 'Enter video URL'),
                  validator: (val) => val.isEmpty ? 'Enter some data' : null,
                  onSaved: (value) {
                    videoUrl = value;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  // selectionHeightStyle: BoxHeightStyle.max,
                  autocorrect: false,
                  maxLines: 3,
                  maxLength: 200,
                  decoration: InputDecoration(
                      icon: Icon(Icons.message),
                      hintText: 'Enter your message'),
                  validator: (val) => val.isEmpty ? 'Enter some data' : null,
                  onSaved: (value) {
                    setState(() {
                      message = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      child: RaisedButton(
                          elevation: 10.0,
                          highlightElevation: 30.0,
                          disabledElevation: 10.0,
                          focusElevation: 10.0,
                          child: Text('Choose Image',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                          color: Colors.pinkAccent[400],
                          onPressed: () => uploadImage()),
                    ),
                    SizedBox(
                      child: RaisedButton(
                          elevation: 10.0,
                          highlightElevation: 30.0,
                          disabledElevation: 10.0,
                          focusElevation: 10.0,
                          child: Text('Submit Entries',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                          color: Colors.pinkAccent[400],
                          onPressed: () async{
                            print(widget.mod.sId);
                            print(widget.userId);
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              String status = await submitEntries(widget.mod.sId,
                                  widget.userId, imageUrl, videoUrl, message);
                              print(status);
                              if (status.compareTo(200.toString())==0) {
                                setState(() {
                                  error =
                                      'Details has been submitted now you can go back to HomePage';
                                  showResponse = true;
                                });
                              } else {
                                error =
                                    "There's some error details cant be submitted";
                                showResponse = true;
                              }
                            }
                          }),
                    ),
                    showResponse ? Text(error) : Text(''),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
