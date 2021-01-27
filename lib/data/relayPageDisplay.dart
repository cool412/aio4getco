import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aio4getco/data/classFile.dart';

class RelayPageScreen extends StatefulWidget {
  final List<ZoneImpedances> zoneList;
  RelayPageScreen(this.zoneList);

  @override
  _RelayPageState createState() => _RelayPageState();
}

class _RelayPageState extends State<RelayPageScreen> {
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Zone Settings",
          style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
        ),
      ),
      body: new Container(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Zone-1 Settings",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              tableZone(widget.zoneList[0]),
              SizedBox(height: 7.0),
              Text(
                "Zone-2 Settings",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              tableZone(widget.zoneList[1]),
              SizedBox(height: 7.0),
              Text(
                "Zone-3 Settings",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              tableZone(widget.zoneList[2]),
              SizedBox(height: 7.0),
              Text(
                "Zone-3 Settings",
                style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 3.0),
              tableZone(widget.zoneList[3]),
              //SizedBox(height: 7.0),
            ],
          ),
        ),
      ),
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

  Widget tableZone(ZoneImpedances zone) {
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
          TableCell(child: containerString("Positive seqence Resistance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(zone.r1Final.toStringAsFixed(4)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Positive seqence Reactaance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(zone.x1Final.toStringAsFixed(4)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Positive seqence Impedance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(zone.z1Final.toStringAsFixed(4)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero seqence Resistance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(zone.r0Final.toStringAsFixed(4)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero seqence Reactaance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(zone.x0Final.toStringAsFixed(4)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero seqence Impedance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(zone.z0Final.toStringAsFixed(4)),
          ),
          TableCell(child: containerString("Ω")),
        ]),
      ],
    );
  }
}
