import 'package:aio4getco/data/classFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ABBScreen extends StatelessWidget {
  final List<ZoneImpedances> zoneList;
  final double ratioCTPT;
  const ABBScreen(this.zoneList, this.ratioCTPT);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "ABB Setting",
          style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
        ),
      ),
      body: (new Container(
        padding:
            EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0, top: 15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            //Centre(),
            children: [
              displayHeader(),
              SizedBox(height: 3.0),
              tableZone(zoneList[0]),
              SizedBox(height: 5.0),
              tableZone(zoneList[1]),
              SizedBox(height: 5.0),
              tableZone(zoneList[2]),
              SizedBox(height: 5.0),
              tableZone(zoneList[3]),
              SizedBox(height: 5.0),
              Text(
                "Time Settings",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              displayTime(),
            ],
          ),
        ),
      )),
    );
  }

  Widget containerString(String text) {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget displayTime() {
    return Table(
      textDirection: TextDirection.ltr,
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FractionColumnWidth(0.65),
        1: FractionColumnWidth(0.05),
        2: FractionColumnWidth(0.2),
        3: FractionColumnWidth(0.1),
      },
      children: [
        TableRow(children: [
          TableCell(child: containerString("Zone-1 Operate Time")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(zoneList[0].zoneTime.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("ms")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zone-2 Operate Time")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(zoneList[1].zoneTime.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("ms")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zone-3 Operate Time")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(zoneList[2].zoneTime.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("ms")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zone-4 Operate Time")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(zoneList[3].zoneTime.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("ms")),
        ]),
      ],
    );
  }

  Widget displayHeader() {
    return Table(
      textDirection: TextDirection.ltr,
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FractionColumnWidth(0.35),
        1: FractionColumnWidth(0.05),
        2: FractionColumnWidth(0.2),
        3: FractionColumnWidth(0.05),
        4: FractionColumnWidth(0.2),
        5: FractionColumnWidth(0.05),
      },
      children: [
        TableRow(children: [
          Container(
            padding: EdgeInsets.all(2.0),
            child: Text(
              "Parameters",
              style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            ),
          ),
          containerString(" "),
          Container(
            padding: EdgeInsets.all(2.0),
            child: Text(
              "REL670",
              style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            ),
          ),
          containerString(" "),
          Container(
            padding: EdgeInsets.all(2.0),
            child: Text(
              "REL511",
              style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
            ),
          ),
          containerString(" "),
        ]),
      ],
    );
  }

  Widget tableZone(ZoneImpedances zoneImpedances) {
    return Table(
      textDirection: TextDirection.ltr,
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FractionColumnWidth(0.35),
        1: FractionColumnWidth(0.05),
        2: FractionColumnWidth(0.2),
        3: FractionColumnWidth(0.05),
        4: FractionColumnWidth(0.2),
        5: FractionColumnWidth(0.05),
      },
      children: [
        TableRow(children: [
          containerString("Z" + "${zoneImpedances.zoneNumber}" + "-R1PP"),
          containerString(":"),
          containerString(
              (zoneImpedances.r1Final / ratioCTPT).toStringAsFixed(4)),
          containerString("Ω"),
          containerString(zoneImpedances.r1Final.toStringAsFixed(4)),
          containerString("Ω"),
        ]),
        TableRow(children: [
          containerString("Z" + "${zoneImpedances.zoneNumber}" + "-X1PP"),
          containerString(":"),
          containerString(
              (zoneImpedances.x1Final / ratioCTPT).toStringAsFixed(4)),
          containerString("Ω"),
          containerString(zoneImpedances.x1Final.toStringAsFixed(4)),
          containerString("Ω"),
        ]),
        TableRow(children: [
          containerString("Z" + "${zoneImpedances.zoneNumber}" + "-R0PE"),
          containerString(":"),
          containerString(
              (zoneImpedances.r0Final / ratioCTPT).toStringAsFixed(4)),
          containerString("Ω"),
          containerString(zoneImpedances.r0Final.toStringAsFixed(4)),
          containerString("Ω"),
        ]),
        TableRow(children: [
          containerString("Z" + "${zoneImpedances.zoneNumber}" + "-X0PE"),
          containerString(":"),
          containerString(
              (zoneImpedances.x0Final / ratioCTPT).toStringAsFixed(4)),
          containerString("Ω"),
          containerString(zoneImpedances.x0Final.toStringAsFixed(4)),
          containerString("Ω"),
        ]),
        TableRow(children: [
          containerString("Z" + "${zoneImpedances.zoneNumber}" + "-RFPP"),
          containerString(":"),
          containerString(
              (zoneImpedances.rPh2Ph / ratioCTPT).toStringAsFixed(4)),
          containerString("Ω"),
          containerString(zoneImpedances.rPh2Ph.toStringAsFixed(4)),
          containerString("Ω"),
        ]),
        TableRow(children: [
          containerString("Z" + "${zoneImpedances.zoneNumber}" + "-RFPE"),
          containerString(":"),
          containerString(
              (zoneImpedances.rPh2E / ratioCTPT).toStringAsFixed(4)),
          containerString("Ω"),
          containerString(zoneImpedances.rPh2E.toStringAsFixed(4)),
          containerString("Ω"),
        ]),
      ],
    );
  }
}
