import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:huncha/Helper/RequestHttp.dart';
import 'package:huncha/Helper/apis.dart';
import 'package:huncha/Models/User/CompetitionsModel.dart';
import 'package:shimmer/shimmer.dart';

class DeleteComp extends StatefulWidget {
  @override
  _DeleteCompState createState() => _DeleteCompState();
}

class _DeleteCompState extends State<DeleteComp> {
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

  bool delYes = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xff3c40c6),
          elevation: 5.0,
          title: Text(
            'Competitions',
            style: TextStyle(fontSize: 20.0),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2.0),
                                        ),
                                        Container(
                                          width: 40.0,
                                          height: 8.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
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
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[400],
                                  blurRadius: 20.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(
                                    15.0,
                                    15.0,
                                  ),
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              color: (index % 2 == 0)
                                  ? Colors.tealAccent[700]
                                  : Colors.purple[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              bottomLeft:
                                                  Radius.circular(20.0)),
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
                                    Container(
                                      child: Wrap(
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
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 30.0,
                                      ),
                                      onPressed: () {
                                        return showDialog(
                                                context: context,
                                                builder:
                                                    (context) => AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0)),
                                                          title: new Text(
                                                              'Are you sure you want to delete?'),
                                                          content: new Text(
                                                              ' This will delete all entries as well'),
                                                          actions: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                child: Text(
                                                                  "NO",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blueAccent),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 25,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  deleteComp(
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .sId);
                                                                  setState(() {
                                                                    snapshot
                                                                        .data
                                                                        .remove(
                                                                            index);
                                                                  });
                                                                  _scaffoldKey
                                                                      .currentState
                                                                      .showSnackBar(SnackBar(
                                                                          content:
                                                                              Text(snapshot.data[index].name + ' is deleted')));
                                                                },
                                                                child: Text(
                                                                  "YES",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blueAccent),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )) ??
                                            false;
                                      }),
                                )
                              ],
                            ),
                          ));
                    });
              }
            }),
      ),
    );
  }
}
