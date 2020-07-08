import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:huncha/Helper/apis.dart';
import 'package:huncha/Models/Admin/RecentDelModel.dart';
import 'package:shimmer/shimmer.dart';

class RecentDel extends StatefulWidget {
  @override
  _RecentDelState createState() => _RecentDelState();
}

class _RecentDelState extends State<RecentDel> {
  Future<List<RecentDelModel>> _getData() async {
    Response response = await get(GETDELCOMP);
    print(response.body);
    List<dynamic> data = jsonDecode(response.body);
    List<RecentDelModel> userItems = [];
    for (var mod in data) {
      RecentDelModel x = RecentDelModel.fromJson(mod);
      userItems.add(x);
    }
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
        title: Text('Recently deleted competitions'),
        centerTitle: true,
        elevation: 10.0,
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
                reverse: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                    child: SizedBox(
                      height: 60.0,
                      child: Card(
                        elevation: 10.0,
                        child: Center(
                          child: Text(snapshot.data[index].name,
                              style: TextStyle(fontSize: 20.0)),
                        ),
                      ),
                    ),
                  );
                });
          }
        });
  }
}
