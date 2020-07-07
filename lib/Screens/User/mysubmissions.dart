import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:huncha/Helper/apis.dart';
import 'package:huncha/Helper/subDesign.dart';
import 'package:huncha/Models/User/MySubmissionModel.dart';
import 'package:shimmer/shimmer.dart';

class MySubmission extends StatefulWidget {
  final String userId;

  const MySubmission({Key key, this.userId}) : super(key: key);
  @override
  _MySubmissionState createState() => _MySubmissionState();
}

class _MySubmissionState extends State<MySubmission> {
  Future<List<SubmissionModel>> _getData() async {
    Response response = await post(VIEWSUBMISSION + widget.userId);
    print(response.body);
    List<dynamic> data = jsonDecode(response.body);
    List<SubmissionModel> compItems = [];
    for (var mod in data) {
      compItems.add(SubmissionModel.fromJson(mod));
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3c40c6),
        elevation: 10.0,
        title: Text('My Submissions'),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder(
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
          return Container(
            padding: EdgeInsets.all(10.0),
            child: GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15),
                itemBuilder: (context, index) {
                  return GridTile(
                      child: RecDesign(
                    imgURL: snapshot.data[index].imageurl,
                    title: snapshot.data[index].competitionname,
                  ));
                }),
          );
        }
      },
    );
  }
}
