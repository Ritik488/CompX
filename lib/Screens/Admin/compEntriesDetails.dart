import 'package:flutter/material.dart';
import 'package:huncha/Models/Admin/CompSubmissionsModel.dart';
import 'package:url_launcher/url_launcher.dart';

class EntryDetails extends StatefulWidget {
  final CompSubmissionsModel mod;

  const EntryDetails({Key key, this.mod}) : super(key: key);

  @override
  _EntryDetailsState createState() => _EntryDetailsState();
}

class _EntryDetailsState extends State<EntryDetails> {
  _launchUrl(String url) async {
    // await launch(widget.mod.urls.toString());
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[800],
        elevation: 10.0,
        title: Text('User Submission'),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // padding: EdgeInsets.all(12.0),
              height: 300.0,
              width: double.infinity,
              child: widget.mod.imageurl == ""
                  ? Image(image: AssetImage("assets/noImage"))
                  : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image(
                          image: NetworkImage(widget.mod.imageurl),
                          fit: BoxFit.fill),
                    ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text("Description",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            Text(widget.mod.message,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontStyle: FontStyle.italic)),
            SizedBox(
              height: 30.0,
            ),
            Text("Download Image",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
            InkWell(
              child: Text("Click on this text to download this image",
                  style: TextStyle(color: Colors.blue, fontSize: 18.0)),
              onTap: () {
                _launchUrl(widget.mod.imageurl);
              },
            ),
            widget.mod.videourl == ""
                ? Text('')
                : SizedBox(
                    height: 30.0,
                  ),
            widget.mod.videourl == ""
                ? Text('')
                : Text("Download Video",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
            widget.mod.videourl == ""
                ? Text('')
                : InkWell(
                    child: Text(
                        "Click on this link to download video submitted",
                        style: TextStyle(color: Colors.blue, fontSize: 18.0)),
                    onTap: () {
                      _launchUrl(widget.mod.videourl);
                    },
                  ),
            widget.mod.videourl == ""
                ? Text('')
                : SizedBox(
                    height: 30.0,
                  ),
            Center(
              child: Text("Participants Information",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Name: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        Text(widget.mod.username,
                            style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Email: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        Text(widget.mod.useremail,
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("PhoneNo: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        Text(widget.mod.userphoneno,
                            style: TextStyle(
                                color: Colors.deepPurple[700],
                                fontSize: 20.0,
                                fontStyle: FontStyle.italic))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
