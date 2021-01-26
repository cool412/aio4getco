import 'package:aio4getco/data/abbDisplay.dart';
import 'package:aio4getco/data/alstomDisplay.dart';
import 'package:aio4getco/data/siemensDisplay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aio4getco/data/classFile.dart';

class RelayPageScreen extends StatefulWidget {
  final AlstomDetails alstomDetails;
  RelayPageScreen(this.alstomDetails);

  @override
  _RelayPageState createState() => _RelayPageState();
}

class _RelayPageState extends State<RelayPageScreen> {
  PageController controller = PageController();
  //AlstomDetails alstom = widget.alstomDetails;
  List<Widget> _list;

  @override
  void initState() {
    
    super.initState();
    _list = <Widget>[
    AlstomScreen(widget.alstomDetails),
    ABBScreen(),
    SiemensScreen(),
  ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relay Settings"),
      ),
      body: PageView(
        children: _list,
        scrollDirection: Axis.horizontal,
        reverse: true,
        physics: BouncingScrollPhysics(),
        controller: controller,
      ),
    );
  }
}
