import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zena/pages/needs.dart';
import 'package:zena/pages/values.dart';
import 'package:zena/pages/personalityfo.dart';
import 'package:zena/pages/personalityon.dart';
import 'package:zena/pages/personalityth.dart';
import 'package:zena/pages/personalitytw.dart';
import 'package:zena/pages/personalityze.dart';
import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import 'package:zena/manager.dart';

Map responsee = {};
bool _loading = false;

class tag extends StatefulWidget {
  String data = "";

  tag(this.data);

  @override
  State<StatefulWidget> createState() {
    return tagstate(data);
  }
}

class tagstate extends State<tag> {
  String data = "";

  tagstate(this.data);

  Future<Null> load() async {
    responsee = await getJson1(data);
    setState(() {
      _loading = true;

      new Future.delayed(new Duration(seconds: 1), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  build(BuildContext context) {
    //returns a circular loading indicator while waiting for data to be fetched.

    var bodyProgress = new Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            alignment: AlignmentDirectional.center,
            decoration: new BoxDecoration(
              color: Colors.white70,
            ),
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.pinkAccent.withOpacity(0.8),
                  borderRadius: new BorderRadius.circular(10.0)),
              width: 300.0,
              height: 200.0,
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                    child: new SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: new CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        value: null,
                        strokeWidth: 7.0,
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: new Center(
                      child: new Text(
                        "understanding you",
                        style: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            "Stats",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        body: new Column(children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 400.0,
                height: 200.0,
                color: Colors.pink,
              ),
              new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: new Container(
                  width: 400.0,
                  height: 200.0,
                  decoration:
                      new BoxDecoration(color: Colors.black.withOpacity(0.1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Center(
                  child: Text(
                    "your big five",
                    style: TextStyle(color: Colors.white, fontSize: 40.0),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Flexible(
              child: _loading
                  ? bodyProgress
                  : ListView(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return personalityze(
                                  responsee["personality"][0]["children"]);
                            }));
                          },
                          child: new Card(
                              child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "${responsee["personality"][0]["name"]} ",
                                    style: TextStyle(fontSize: 30.0),
                                  )),
                              LinearProgressIndicator(
                                  value: responsee["personality"][0]
                                      ["percentile"])
                            ],
                          )),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return personalityon(
                                  responsee["personality"][1]["children"]);
                            }));
                          },
                          child: new Card(
                              child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "${responsee["personality"][1]["name"]} ",
                                    style: TextStyle(fontSize: 30.0),
                                  )),
                              LinearProgressIndicator(
                                  value: responsee["personality"][1]
                                      ["percentile"])
                            ],
                          )),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return personalitytw(
                                  responsee["personality"][2]["children"]);
                            }));
                          },
                          child: new Card(
                              child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "${responsee["personality"][2]["name"]} ",
                                    style: TextStyle(fontSize: 30.0),
                                  )),
                              LinearProgressIndicator(
                                  value: responsee["personality"][2]
                                      ["percentile"])
                            ],
                          )),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return personalityth(
                                  responsee["personality"][3]["children"]);
                            }));
                          },
                          child: new Card(
                              child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "${responsee["personality"][3]["name"]} ",
                                    style: TextStyle(fontSize: 30.0),
                                  )),
                              LinearProgressIndicator(
                                  value: responsee["personality"][3]
                                      ["percentile"])
                            ],
                          )),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return personalityfo(
                                  responsee["personality"][4]["children"]);
                            }));
                          },
                          child: new Card(
                              child: Column(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "${responsee["personality"][4]["name"]} ",
                                    style: TextStyle(fontSize: 30.0),
                                  )),
                              LinearProgressIndicator(
                                  value: responsee["personality"][4]
                                      ["percentile"])
                            ],
                          )),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        new Card(
                            child: new ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return needs(responsee["needs"]);
                            }));
                          },
                          title: Text(
                            "needs",
                            style: new TextStyle(fontSize: 17.9),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.greenAccent,
                            child: new Text(
                              "N",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                        new Card(
                            child: new ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return values(responsee["values"]);
                            }));
                          },
                          title: Text(
                            "values",
                            style: new TextStyle(fontSize: 17.9),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.greenAccent,
                            child: new Text(
                              "V",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                        new ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return manager();
                              }));
                            },
                            subtitle: Text("check Eligibility"))
                      ],
                    ))
        ]));
  }
}

Future<Map> getJson1(String data) async {
  http.Response r = await http.post(
    'https://gateway.watsonplatform.net/personality-insights/api/v3/profile?version=2017-10-13&consumption_preferences=true&raw_scores=true',
    body: data,
    headers: {
      'Accept': 'application/json',
      'Authorization': basicAuthorizationHeader(
        '6cfcbb79-1801-4588-a1b3-5c3ec101244f',
        'YFM6h0rIFfzf',
      )
    },
  );
  print(r.statusCode);
  print(r.body);
  return json.decode(r.body);
}

String basicAuthorizationHeader(String username, String password) {
  return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
}
