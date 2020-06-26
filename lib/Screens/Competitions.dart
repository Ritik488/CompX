import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:huncha/Helper/apis.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Models/CompetitionsModel.dart';
import 'package:huncha/Screens/competitionDescription.dart';

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
    for(var mod in data){
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
            return(
            Center(
              child: CircularProgressIndicator(),
            )
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          changeScreen(context, CompDescription(mod: snapshot.data[index],userId: widget.userId,));
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
                                  child: Image(
                                    matchTextDirection: true,
                                    image: NetworkImage(
                                        snapshot.data[index].images==""? 'https://www.kreedon.com/wp-content/uploads/2019/05/capturing-Chess-Kreedon-1280x720.jpg':
                                        snapshot.data[index].images,
                                        ),
                                    height: 100.0,
                                    width: 100.0,
                                    fit: BoxFit.fill,
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
