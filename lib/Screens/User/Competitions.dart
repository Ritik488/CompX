import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:huncha/Helper/apis.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Models/User/CompetitionsModel.dart';
import 'package:huncha/Screens/Admin/showCompetitionEntries.dart';
import 'package:huncha/Screens/User/competitionDescription.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Competitions extends StatefulWidget {
  final String userId;

  const Competitions({Key key, this.userId}) : super(key: key);

  @override
  _CompetitionsState createState() => _CompetitionsState();
}

class _CompetitionsState extends State<Competitions> {
  Future<List<CompetitionsModel>> _getData() async {
    Response response = await get(ALLCOMPETITIONS);
    print(response.body);
    List<dynamic> data = jsonDecode(response.body);
    List<CompetitionsModel> compItems = [];
    for (var mod in data) {
      compItems.add(CompetitionsModel.fromJson(mod));
    }
    print(compItems[0]);
    if (compItems.length == 0) {
      return null;
    } else {
      return compItems;
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[900],
          elevation: 5.0,
          title: Text(
            'Competitions',
            style: TextStyle(fontSize: 20.0),
          ),
          centerTitle: true,
        ),
        body: _buildList(context),
      ),
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
                        onTap: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          var email = pref.getString('AdminEmail');
                          if (email != 'org.main@admin.com') {
                            changeScreen(
                                context,
                                CompDescription(
                                  mod: snapshot.data[index],
                                  userId: widget.userId,
                                ));
                          } else {
                            changeScreen(
                                context,
                                ShowEntries(
                                  mod: snapshot.data[index],
                                ));
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: (index % 2 == 0)
                                ? Colors.pink[400]
                                : Colors.pink[100],
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        bottomLeft: Radius.circular(20.0)),
                                    child: Image(
                                      matchTextDirection: true,
                                      image: NetworkImage(
                                        snapshot.data[index].images == ""
                                            ? 'https://www.kreedon.com/wp-content/uploads/2019/05/capturing-Chess-Kreedon-1280x720.jpg'
                                            : snapshot.data[index].images,
                                      ),
                                      height: 100.0,
                                      width: 100.0,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Wrap(
                                        children: <Widget>[
                                          Text(
                                            snapshot.data[index].name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                      Wrap(
                                        children: <Widget>[
                                          Text(
                                            snapshot.data[index].minidesc,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
