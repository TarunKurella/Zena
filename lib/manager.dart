import 'package:flutter/material.dart';

class manager extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: ListView(children: <Widget>[SizedBox(height: 60.0,),
         Center(child: Text("Role : Manager")),Center(child: Text("Openness : check")),Center(child: Text("emotional Intelligence : check")),Center(child: Text("Assertiveness : check")),
         Center(child: Text("Eligible : yes")),
       ],),
     ),
   );
  }


}