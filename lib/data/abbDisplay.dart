import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ABBScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Alsto"),
      ),
      body: (new Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("ABB Data"),
            ],
          ),
        ),
      )),
    );
  }
}
