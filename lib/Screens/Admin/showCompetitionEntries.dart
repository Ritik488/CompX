import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:huncha/Helper/apis.dart';
import 'package:huncha/Helper/navigation.dart';
import 'package:huncha/Helper/subDesign.dart';
import 'package:huncha/Models/Admin/CompSubmissionsModel.dart';
import 'package:huncha/Models/User/CompetitionsModel.dart';
import 'package:huncha/Screens/Admin/compEntriesDetails.dart';
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
        backgroundColor: Color(0xff3c40c6),
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
                        child: GestureDetector(
                      onTap: () => changeScreen(
                          context,
                          EntryDetails(
                            mod: snapshot.data[index],
                          )),
                      child: RecDesign(
                        imgURL: snapshot.data[index].imageurl,
                        title: snapshot.data[index].username,
                        email: snapshot.data[index].useremail,
                      ),
                    ));
                  }),
            );
          }
        },
      ),
    );
  }
}
