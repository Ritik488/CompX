import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:huncha/Helper/apis.dart';
import 'package:huncha/Models/Admin/CompSubmissionsModel.dart';
import 'package:huncha/Models/User/CompetitionsModel.dart';
import 'package:shimmer/shimmer.dart';

class ShowEntries extends StatefulWidget {
  final CompetitionsModel mod;

  const ShowEntries({Key key, this.mod}) : super(key: key);

  @override
  _ShowEntriesState createState() => _ShowEntriesState();
}

class _ShowEntriesState extends State<ShowEntries> {
  Future<List<CompSubmissionsModel>> _getData() async {
    Response response = await post(SHOWENTRIES + widget.mod.sId);
    print(response.body);
    List<dynamic> data = jsonDecode(response.body);
    List<CompSubmissionsModel> compEntries = [];
    for (var mod in data) {
      CompSubmissionsModel x = CompSubmissionsModel.fromJson(mod);
      compEntries.add(x);
    }
    print(compEntries[0]);
    print(compEntries.length);
    if (compEntries.length == 0) {
      return null;
    } else {
      return compEntries;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[800],
        title: Text(widget.mod.name),
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0)),
                          ),
                          child: Card(
                            color: (index % 2 == 0)
                                ? Colors.blue[300]
                                : Colors.pink[200],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: ClipRRect(
                                      // borderRadius: BorderRadius.only(
                                      //     topLeft: Radius.circular(20.0),
                                      //     bottomLeft: Radius.circular(20.0)),
                                      child: Image(
                                        matchTextDirection: true,
                                        image: NetworkImage(
                                          snapshot.data[index].imageurl == ""
                                              ? 'https://www.kreedon.com/wp-content/uploads/2019/05/capturing-Chess-Kreedon-1280x720.jpg'
                                              : snapshot.data[index].imageurl,
                                        ),
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(
                                              text: '',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: snapshot.data[index]
                                                      .competitionname,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0),
                                                )
                                              ]),
                                        ),
                                        RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(
                                              text: "Participant's Name: ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: snapshot
                                                      .data[index].username,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0),
                                                )
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
