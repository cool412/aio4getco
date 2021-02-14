import 'package:aio4getco/idmtSet/calcFaultCurrent.dart';
import 'package:aio4getco/idmtSet/calcFaultTime.dart';
import 'package:aio4getco/idmtSet/calcPlug.dart';
import 'package:aio4getco/idmtSet/calcTMS.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IDMTScreen extends StatefulWidget {
  _IDMTState createState() => _IDMTState();
}

class _IDMTState extends State<IDMTScreen> {
  static const String faultTime = "Fault Clearance Time";
  static const String setTms = "Required TMS";
  static const String faultCurrent = "Fault Current";
  static const String plugSetting = "Plug Setting";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("IDMT Calculation"),
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              gridButton(setTms),
              SizedBox(height: 10.0),
              gridButton(faultTime),
              SizedBox(height: 10.0),
              gridButton(faultCurrent),
              SizedBox(height: 10.0),
              gridButton(plugSetting),
            ],
          ),
        ),
      ),
    );
  }

  Widget gridButton(String displayText) {
    return RaisedButton(
      color: Colors.white,
      elevation: 5.0,
      onPressed: () {
        _pushToNextActivity(displayText);
      },
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Center(
            child: Text(
              displayText,
              style: TextStyle(color: Colors.blue, fontSize: 17.0),
            ),
          ),
        ],
      ),
    );
  }

  void _pushToNextActivity(String selection) {
    switch (selection) {
      case setTms:
        {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => TMSScreen()));
        }
        break;
      case faultTime:
        {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => FaultTimeScreen()));
        }
        break;
      case faultCurrent:
        {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => FaultCurrentScreen()));
        }
        break;
      case plugSetting:
        {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => PlugScreen()));
        }
    }
  }
}
