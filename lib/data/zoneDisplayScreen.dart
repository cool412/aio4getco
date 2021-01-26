import 'dart:math';

import 'package:aio4getco/data/classFile.dart';
import 'package:aio4getco/data/conductorImpedanceList.dart';
import 'package:aio4getco/data/relayPageDisplay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math.dart';

class ZoneDisplayScreen extends StatefulWidget {
  final Details detailsObject;
  ZoneDisplayScreen(this.detailsObject);
  @override
  _ZoneDisplayState createState() => _ZoneDisplayState();
}

class _ZoneDisplayState extends State<ZoneDisplayScreen> {
  ZoneImpedances _zone1, _zone2, _zone3, _zone4;
  LineImpedance _mainLine, _nextLongest, _nextShortest, _shortestLine;

  bool isLineLengthMoreThen50km = false;
  double lineImepdance,
      lineAngle,
      lineImpedance,
      siemensX,
      siemensReRl,
      siemensXeXl,
      residualCompMagnitude,
      residualCompAngle;

  AlstomDetails _alstomDetails;

  static const List<int> _listFaultPh2Ph1 = [4, 5, 6, 6];
  static const List<int> _listFaultPh2Ph2 = [5, 6, 7, 7];
  static const List<int> _listFaultPh2E1 = [10, 12, 14, 14];
  static const List<int> _listFaultPh2E2 = [12, 14, 16, 16];
  static const String mainLineText = "protested line",
      nextLongestText = "next longest line",
      nextShortestLineText = "next shortest line",
      shortestLineText = "shortest line";
  static const int zone1Number = 1,
      zone2Number = 2,
      zone3Number = 3,
      zone4Number = 4;

  @override
  void initState() {
    super.initState();
    double lineLength = widget.detailsObject.getLineLength();
    isLineLengthMoreThen50km = lineLength > 50;
    lineAngle = widget.detailsObject.getLineParameter().zPAngle;
    calculatSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Zome Settings"),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 5.0),
                Text(
                  "Zone-1 Settings",
                  style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 5.0),
                displayZoneSettings(_zone1),
                SizedBox(height: 5.0),
                Text(
                  "Zone-2 Settings",
                  style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 5.0),
                displayZoneSettings(_zone2),
                SizedBox(height: 5.0),
                Text(
                  "Zone-3 Settings",
                  style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 5.0),
                displayZoneSettings(_zone3),
                SizedBox(height: 5.0),
                Text(
                  "Zone-4 Settings",
                  style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 5.0),
                displayZoneSettings(_zone4),
                SizedBox(height: 10.0),
                buildButtonContainer(),
              ],
            ),
          ),
        ));
  }

  Widget displayZoneSettings(ZoneImpedances zoneSetting) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text("Positive seqence Resistance"),
            ),
            Text(" : "),
            Text(zoneSetting.r1Final.toStringAsFixed(4) ?? "")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text("Positive seqence Reactaance"),
            ),
            Text(" : "),
            Text(zoneSetting.x1Final.toStringAsFixed(4) ?? ""),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text("Positive seqence Impedance"),
            ),
            Text(" : "),
            Text(zoneSetting.z1Final.toStringAsFixed(4) ?? ""),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text("Zero seqence Resistance "),
            ),
            Text(":"),
            Text(zoneSetting.r0Final.toStringAsFixed(4) ?? ""),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text("Zero seqence Reactance "),
            ),
            Text(":"),
            Text(zoneSetting.x0Final.toStringAsFixed(4) ?? ""),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text("Zero seqence Impedance "),
            ),
            Text(":"),
            Text(zoneSetting.z0Final.toStringAsFixed(4) ?? ""),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text("Fault Resistance (ph-ph) "),
            ),
            Text(":"),
            Text(zoneSetting.rPh2Ph.toString() ?? ""),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text("Fault Resistance (ph-E) "),
            ),
            Text(":"),
            Text(zoneSetting.rPh2E.toString() ?? ""),
          ],
        ),
      ],
    );
  }

  Future<void> calculatSettings() async {
    _mainLine = calcLineParameter(mainLineText);
    _nextLongest = calcLineParameter(nextLongestText);
    _nextShortest = calcLineParameter(nextShortestLineText);
    _shortestLine = calcLineParameter(shortestLineText);
    _zone1 = calculateZoneSetting(zone1Number);
    _zone2 = calculateZoneSetting(zone2Number);
    _zone3 = calculateZoneSetting(zone3Number);
    _zone4 = calculateZoneSetting(zone4Number);
    lineImpedance = _mainLine.z1Line;
    calcResidualComponenets();
  }

  Widget buildButtonContainer() {
    return ButtonBar(children: <Widget>[
      (RaisedButton(
        //color: Colors.teal,
        elevation: 5.0,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0),
        ),
        onPressed: () {
          prepareRelayData();
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => RelayPageScreen(_alstomDetails)));
        },
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: const Text(
              'Disply Makewise Settings',
              //style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
      ))
    ]);
  }

  LineImpedance calcLineParameter(String line) {
    ConductorImpedance lineObject;
    double lineLength;
    double ratioCtPt = widget.detailsObject.getCtPtRatio();
    switch (line) {
      case mainLineText:
        {
          lineObject = widget.detailsObject.getLineParameter();
          lineLength = widget.detailsObject.getLineLength();
        }
        break;
      case nextLongestText:
        {
          lineObject = widget.detailsObject.getNextLongestParameter();
          lineLength = widget.detailsObject.getNextLongestLineLength();
        }
        break;
      case nextShortestLineText:
        {
          lineObject = widget.detailsObject.getNextShortestParameter();
          lineLength = widget.detailsObject.getNextShortestLineLength();
        }
        break;
      case shortestLineText:
        {
          lineObject = widget.detailsObject.getShortestParameter();
          lineLength = widget.detailsObject.getShortestLineLength();
        }
        break;
    }
    double multiplier = ratioCtPt * lineLength;
    return LineImpedance(
        multiplier * lineObject.rP,
        multiplier * lineObject.xP,
        multiplier * lineObject.zP,
        multiplier * lineObject.r0,
        multiplier * lineObject.x0,
        multiplier * lineObject.z0);
  }

  ZoneImpedances calculateZoneSetting(int number) {
    LineImpedance lineData;
    double multiplier;
    int time;
    List faultResisPh2PhList =
            isLineLengthMoreThen50km ? _listFaultPh2Ph2 : _listFaultPh2Ph1,
        faultResisPh2EList =
            isLineLengthMoreThen50km ? _listFaultPh2E2 : _listFaultPh2E1;
    int faultResiPh2Ph, faultResisPh2E;
    switch (number) {
      case zone1Number:
        {
          multiplier = 0.8;
          lineData = _mainLine;
          time = 0;
          faultResiPh2Ph = faultResisPh2PhList[0];
          faultResisPh2E = faultResisPh2EList[0];
        }
        break;
      case zone2Number:
        {
          multiplier = widget.detailsObject.getZoneMultiplier();
          print(_mainLine.z1Line);
          print(_nextShortest.z1Line);
          if (multiplier * _mainLine.z1Line >= (_mainLine.z1Line + _nextShortest.z1Line * 0.8)) {
            time = 450;
          } else {
            time = 350;
          }
          lineData = _mainLine;
          faultResiPh2Ph = faultResisPh2PhList[1];
          faultResisPh2E = faultResisPh2EList[1];
        }
        break;
      case zone3Number:
        {
          multiplier = 1.2;
          time = 800;
          lineData = _mainLine.add(_nextLongest);
          faultResiPh2Ph = faultResisPh2PhList[2];
          faultResisPh2E = faultResisPh2EList[2];
        }
        break;
      case zone4Number:
        {
          multiplier = 0.5;
          time = 500;
          lineData = _shortestLine;
          faultResiPh2Ph = faultResisPh2PhList[3];
          faultResisPh2E = faultResisPh2EList[3];
        }
        break;
    }
    return ZoneImpedances(
        number,
        multiplier * lineData.r1Line,
        multiplier * lineData.x1Line,
        multiplier * lineData.z1Line,
        multiplier * lineData.r0Line,
        multiplier * lineData.x0Line,
        multiplier * lineData.z0Line,
        faultResiPh2Ph,
        faultResisPh2E,
        time);
  }

  void calcResidualComponenets() {
    ConductorImpedance linePara = widget.detailsObject.getLineParameter();
    double ratioCTPT = widget.detailsObject.getCtPtRatio();
    double realCompCondZero = linePara.r0,
        realCompCondPositive = linePara.rP,
        imageCompCondZero = linePara.x0,
        imageCompCondPositive = linePara.xP,
        impedancePositive = linePara.zP;
    double numeratorReal = realCompCondZero - realCompCondPositive;
    double numeratorImage = imageCompCondZero - imageCompCondPositive;
    double numertorImpedance =
        sqrt(pow(numeratorReal, 2) + pow(numeratorImage, 2));
    double numertorAngle = degrees(atan(numeratorImage / numeratorReal));
    residualCompMagnitude = numertorImpedance / (3 * impedancePositive);
    residualCompAngle = numertorAngle - linePara.zPAngle;
    siemensX = imageCompCondPositive / ratioCTPT;
    siemensReRl = (realCompCondZero / realCompCondPositive - 1) / 3;
    siemensXeXl = (imageCompCondZero / imageCompCondPositive - 1) / 3;
  }

  Future<void> prepareRelayData() async {
    _alstomDetails = AlstomDetails(
        lineImpedance,
        lineAngle,
        residualCompMagnitude,
        residualCompAngle,
        _zone1.z1Final,
        _zone1.rPh2Ph.toDouble(),
        _zone1.rPh2E.toDouble(),
        _zone1.zoneTime.toDouble(),
        _zone2.z1Final,
        _zone2.rPh2Ph.toDouble(),
        _zone2.rPh2E.toDouble(),
        _zone2.zoneTime.toDouble(),
        _zone3.z1Final,
        _zone3.rPh2Ph.toDouble(),
        _zone3.rPh2E.toDouble(),
        _zone3.zoneTime.toDouble(),
        _zone4.z1Final,
        _zone4.rPh2Ph.toDouble(),
        _zone4.rPh2E.toDouble(),
        _zone4.zoneTime.toDouble());
  }
}
