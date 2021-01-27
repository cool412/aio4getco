import 'package:aio4getco/data/classFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SiemensScreen extends StatelessWidget {
  final SiemensDetails siemensDetails;
  SiemensScreen(this.siemensDetails);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Siemens Settings",
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
            children: [
              Text(
                "Zone-1",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              tableZone1(),
              SizedBox(height: 7.0),
              Text(
                "Zone-2",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              tableZone2(),
              SizedBox(height: 7.0),
              Text(
                "Zone-3",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              tableZone3(),
              SizedBox(height: 7.0),
              Text(
                "Zone-4",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              tableZone4(),
              SizedBox(height: 7.0),
              Text(
                "Other Details",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              tableOther(),
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

  Widget tableZone1() {
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
          TableCell(child: containerString("Positive Sequence Reactance XZ1")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.xZ1.toStringAsFixed(3)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-ph) RZ1")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.rZ1.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-e) REZ1")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.rEZ1.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zone-1 Operate Time")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.t1.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("ms")),
        ]),
      ],
    );
  }

  Widget tableZone2() {
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
          TableCell(child: containerString("Positive Sequence Reactance XZ2")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.xZ2.toStringAsFixed(3)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-ph) RZ2")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.rZ2.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-e) REZ2")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.rEZ2.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zone-2 Operate Time")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.t2.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("ms")),
        ]),
      ],
    );
  }

  Widget tableZone3() {
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
          TableCell(child: containerString("Positive Sequence Reactance XZ3")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.xZ3.toStringAsFixed(3)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-ph) RZ3")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.rZ3.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-e) REZ3")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.rEZ3.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zone-3 Operate Time")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.t3.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("ms")),
        ]),
      ],
    );
  }

  Widget tableZone4() {
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
          TableCell(child: containerString("Positive Sequence Reactance XZ4")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.xZ4.toStringAsFixed(3)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-ph) RZ4")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.rZ4.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-e) REZ4")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.rEZ4.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zone-3 Operate Time")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.t4.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
      ],
    );
  }

  Widget tableOther() {
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
          TableCell(child: containerString("Line Length")),
          TableCell(child: containerString(":")),
          TableCell(
            child:
                containerString(siemensDetails.lineLength.toStringAsFixed(3)),
          ),
          TableCell(child: containerString("km")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Line Angle (Degree)")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.lineAngle.toStringAsFixed(3)),
          ),
          TableCell(child: containerString(" ")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("X'")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.siemensX.toStringAsFixed(4)),
          ),
          TableCell(child: containerString(" ")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Re/Rl")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.ratioReRl.toStringAsFixed(4)),
          ),
          TableCell(child: containerString(" ")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Xe/Xl")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(siemensDetails.ratioXeXl.toStringAsFixed(4)),
          ),
          TableCell(child: containerString(" ")),
        ]),
      ],
    );
  }
}
