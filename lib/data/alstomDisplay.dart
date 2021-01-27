import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aio4getco/data/classFile.dart';

class AlstomScreen extends StatelessWidget {
  final AlstomDetails alstomDetails;
  const AlstomScreen(this.alstomDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Relay Settings for P442/P444",
          style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
        ),
      ),
      body: (new Container(
        padding: EdgeInsets.all(15.0),
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
                "Zone-2 Settings",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              tableZone2(),
              SizedBox(height: 7.0),
              Text(
                "Zone-3 Settings",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              tableZone3(),
              SizedBox(height: 7.0),
              Text(
                "Zone-4 Settings",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              tableZone4(),
              SizedBox(height: 7.0),
              Text(
                "Other Settings",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              otherSettings(),
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
          TableCell(child: containerString("Positive Sequence Impedance Z1")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.z1.toStringAsFixed(3)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-ph) RZ1")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.rZ1.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-e) REZ1")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.rEZ1.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zone-1 Operate Time")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.t1.toStringAsFixed(0)),
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
          TableCell(child: containerString("Positive Sequence Impedance Z2")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.z2.toStringAsFixed(3)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-ph) RZ2")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.rZ2.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-e) REZ2")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.rEZ2.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zone-2 Operate Time")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.t2.toStringAsFixed(0)),
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
          TableCell(child: containerString("Positive Sequence Impedance Z3")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.z3.toStringAsFixed(3)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-ph) RZ3")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.rZ3.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-e) REZ3")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.rEZ3.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zone-3 Operate Time")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.t3.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
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
          TableCell(child: containerString("Positive Sequence Impedance Z4")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.z4.toStringAsFixed(3)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-ph) RZ4")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.rZ4.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Fault Resistance (ph-e) REZ4")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.rEZ4.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zone-4 Operate Time")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.t4.toStringAsFixed(0)),
          ),
          TableCell(child: containerString("ms")),
        ]),
      ],
    );
  }

  Widget otherSettings() {
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
          TableCell(
              child: containerString("Residual E/F Compensation Magnitude")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(
                alstomDetails.residualCompMangnitude.toStringAsFixed(3)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Residual E/F Compensation Angle (Degree)")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(
                alstomDetails.residualCompAngle.toStringAsFixed(3)),
          ),
          TableCell(child: containerString(" ")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Power Swing Delta R")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.deltaR.toStringAsFixed(3)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Power Swing Delta X")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(alstomDetails.deltaX.toStringAsFixed(3)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
      ],
    );
  }

  
}
