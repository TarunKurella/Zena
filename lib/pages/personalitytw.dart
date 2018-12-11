import 'package:flutter/material.dart';

class personalitytw extends StatelessWidget{
  List responsee=[];
  personalitytw(this.responsee);
  String help(int i){
    double helpp;
    int helppp;
    helpp=responsee[i]['percentile'];
    helpp=helpp*100;
    helppp=helpp.round();
    return helppp.toString()+"%";

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
          child: new ListView.builder(
              itemCount: responsee.length,
              padding: const EdgeInsets.all(14.5),
              itemBuilder: (BuildContext context, int position) {
                return Column(
                  children: <Widget>[
                    new Divider(height: 5.5),
                    new ListTile(
                      title: Text(
                        "${responsee[position]['name']}",
                        style: new TextStyle(fontSize: 17.9),
                      ),
                      subtitle: Text(help(position),
                          style: new TextStyle(
                              fontSize: 13.9,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic)),



                    )
                  ],
                );
              })),
    );
  }
}