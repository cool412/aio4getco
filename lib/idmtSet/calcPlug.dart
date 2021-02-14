import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlugScreen extends StatefulWidget {
  _PlugState createState() => _PlugState();
}

class _PlugState extends State<PlugScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Calculate TMS"),
      ),
      body: new Container(),
    );
  }
}
