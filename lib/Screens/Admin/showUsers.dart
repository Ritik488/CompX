import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:huncha/Helper/apis.dart';
import 'package:huncha/Models/Admin/allUsersModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowUsers extends StatefulWidget {
  @override
  _ShowUsersState createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
  Future<List<AllUsersModel>> _getData() async {
    Response response = await post(SHOWALLUSERS);
    print(response.body);
    List<dynamic> data = jsonDecode(response.body);
    List<AllUsersModel> userItems = [];
    for (var mod in data) {
      AllUsersModel x = AllUsersModel.fromJson(mod);
      if (x.email != "org.main@admin.com") {
        userItems.add(x);
      }
    }
    print(userItems[0]);
    print(userItems.length);
    if (userItems.length == 0) {
      return null;
    } else {
      return userItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3c40c6),
        title: Text('All Users'),
        centerTitle: true,
        elevation: 10.0,
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return SafeArea(
      child: new Container(
        margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
        child: new Column(
          children: <Widget>[
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Flexible(
      child: FutureBuilder(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48.0,
                                height: 48.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: 40.0,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 7,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          // height: 80.0,
                          child: Card(
                            color: (index % 2 == 0)
                                ? Colors.blue[300]
                                : Colors.pink[200],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                            text: 'Name: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: snapshot.data[index].name,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0),
                                              )
                                            ]),
                                      ),
                                      RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                            text: 'Email: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    snapshot.data[index].email,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0),
                                              )
                                            ]),
                                      ),
                                      RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                            text: 'Phone Number: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: snapshot
                                                    .data[index].phoneno,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0),
                                              )
                                            ]),
                                      )
                                    ],
                                  ),
                                  Icon(
                                    FontAwesomeIcons.xbox,
                                    color: Colors.green[700],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ));
                });
          }
        },
      ),
    );
  }
}
