import 'dart:async';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:huncha/Helper/RequestHttp.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Models/User/CompetitionsModel.dart';
import 'package:huncha/Screens/Admin/adminHome.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

class AddCompetition extends StatefulWidget {
  @override
  _AddCompetitionState createState() => _AddCompetitionState();
}

class _AddCompetitionState extends State<AddCompetition> {
  var imageUrl;
  bool isloading = false;
  bool showResponse = false;
  String error = '';

  String compName;
  String miniDesc;
  String compDesc;
  String compImportant;
  String compCampaeign;
  String videoUrl;

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
          contentType: new MediaType("image", "jpg"),
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
        title: Text('Add Competition'),
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
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    radius: 60,
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
                showResponse
                    ? Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 15.0))
                    : Text(''),
                SizedBox(height: 20.0),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.adobe),
                      hintText: 'Enter competition name'),
                  validator: (val) => val.isEmpty ? 'Enter some data' : null,
                  onSaved: (value) {
                    compName = value;
                  },
                ),
                SizedBox(height: 30.0),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                      icon: Icon(Icons.art_track),
                      hintText: 'Enter mini description'),
                  validator: (val) => val.isEmpty ? 'Enter some data' : null,
                  onSaved: (value) {
                    miniDesc = value;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  autocorrect: false,
                  maxLines: 2,
                  maxLength: 300,
                  decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.bars),
                      hintText: 'Enter competition descritpion'),
                  validator: (val) => val.isEmpty ? 'Enter some data' : null,
                  onSaved: (value) {
                    setState(() {
                      compDesc = value;
                    });
                  },
                ),
                // SizedBox(height: 5.0),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.wpforms),
                      hintText: 'Enter important message'),
                  validator: (val) => val.isEmpty ? 'Enter some data' : null,
                  onSaved: (value) {
                    compImportant = value;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  autocorrect: false,
                  maxLines: 4,
                  maxLength: 300,
                  decoration: InputDecoration(
                      icon: Icon(Icons.book),
                      hintText:
                          'Enter Campeign Breif in form \n1...\n2.. \n3..'),
                  validator: (val) => val.isEmpty ? 'Enter some data' : null,
                  onSaved: (value) {
                    setState(() {
                      compCampaeign = value;
                    });
                  },
                ),
                // SizedBox(height: 10.0),
                TextFormField(
                  autocorrect: false,
                  decoration: InputDecoration(
                      icon: Icon(Icons.aspect_ratio),
                      hintText: 'Enter FAQ Url '),
                  validator: (val) => val.isEmpty ? 'Enter some data' : null,
                  onSaved: (value) {
                    setState(() {
                      videoUrl = value;
                    });
                  },
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      child: RaisedButton(
                          elevation: 10.0,
                          highlightElevation: 30.0,
                          disabledElevation: 10.0,
                          focusElevation: 10.0,
                          child: Text('Upload Image',
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
                          child: Text('Add Competition',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                          color: Colors.pinkAccent[400],
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              print(compName);
                              print(compDesc);
                              String status = await addCompetition(
                                  compName,
                                  compDesc,
                                  compImportant,
                                  miniDesc,
                                  compCampaeign,
                                  videoUrl,
                                  imageUrl);
                              print(status);
                              if (status.compareTo(200.toString()) == 0) {
                                setState(() {
                                  error =
                                      'Details has been submitted now you will be redirected to HomePage';
                                  showResponse = true;
                                });
                                Timer(
                                    Duration(seconds: 4),
                                    () => changeScreenRepacement(
                                        context, AdminHomePage()));
                              } else {
                                setState(() {
                                  error =
                                      "There's some error details cant be submitted";
                                  showResponse = true;
                                });
                              }
                            }
                          }),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            ),
          )),
    );
  }
}
