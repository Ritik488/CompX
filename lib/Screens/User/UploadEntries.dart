import 'dart:async';
import 'dart:ui';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:huncha/Helper/RequestHttp.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Models/User/CompetitionsModel.dart';
import 'package:huncha/Screens/User/HomePage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EntriesPage extends StatefulWidget {
  final CompetitionsModel mod;
  final String userId;

  const EntriesPage({Key key, this.mod, this.userId}) : super(key: key);
  @override
  _EntriesPageState createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  TextEditingController textControl1 = TextEditingController();
  TextEditingController textControl2 = TextEditingController();

  var imageUrl;
  bool isloading = false;
  String videoUrl;
  String message;
  bool showResponse = false;
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
        title: Text('Add Details'),
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
                Text(widget.mod.name,
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
                  controller: textControl1,
                  autocorrect: false,
                  decoration: InputDecoration(
                      icon: Icon(Icons.airplay), hintText: 'Enter video URL'),
                  // validator: (val) => val.isEmpty ? 'Enter some data' : null,
                  onSaved: (value) {
                    videoUrl = value;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: textControl2,
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
                      height: 50.0,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(color: Colors.red)),
                          child: Text('Choose Image',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                          color: Colors.pinkAccent[400],
                          onPressed: () => uploadImage()),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    SizedBox(
                      width: 160.0,
                      child: RoundedLoadingButton(
                          controller: _btnController,
                          child: Text('Submit Entries',
                              style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)),
                          color: Colors.pinkAccent[400],
                          onPressed: () async {
                            print(widget.mod.sId);
                            print(widget.userId);
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              String status;
                              if (imageUrl == null) {
                                String dummyImage =
                                    'https://res.cloudinary.com/dcsqiv7je/image/upload/v1593545859/do%20not%20delete/no_image_available_e1tinz.png';
                                status = await submitEntries(
                                    widget.mod.sId,
                                    widget.userId,
                                    dummyImage,
                                    videoUrl,
                                    message);
                              } else {
                                status = await submitEntries(widget.mod.sId,
                                    widget.userId, imageUrl, videoUrl, message);
                              }

                              print(status);
                              if (status.compareTo(200.toString()) == 0) {
                                setState(() {
                                  error =
                                      'Details has been submitted now you will be redirected to HomePage';
                                  showResponse = true;
                                  textControl1.clear();
                                  textControl2.clear();
                                  _btnController.success();
                                  Timer(
                                      Duration(seconds: 8),
                                      () => changeScreenRepacement(
                                          context, HomePage()));
                                });
                              } else {
                                setState(() {
                                  error =
                                      "There's some error details cant be submitted";
                                  showResponse = true;
                                  _btnController.reset();
                                });
                              }
                            } else {
                              _btnController.reset();
                            }
                          }),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                showResponse
                    ? Text(error,
                        style:
                            TextStyle(color: Colors.green[600], fontSize: 30.0))
                    : Text(''),
              ],
            ),
          )),
    );
  }
}
