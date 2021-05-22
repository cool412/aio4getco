import 'package:aio4getco/addNewConductor.dart';
import 'package:aio4getco/dbHelperFolder/dbProvider.dart';
import 'package:aio4getco/deleteConductor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data/conductorImpedanceList.dart';

class ListCondParaScreen extends StatefulWidget {
  @override
  _ListCondParaState createState() => _ListCondParaState();
}

class _ListCondParaState extends State<ListCondParaScreen> {
  List<ConductorImpedance> conductList;

  ConductorImpedance _lineConductor;

  @override
  void initState() {
    super.initState();
    conductList = initiateConductorData();
    getSqliteData();
    _lineConductor = conductList[0];
  }

  Future getSqliteData() async {
    List<ConductorSqliteData> sqliteDataList =
        await DBProvider.db.getConductor();
    if (sqliteDataList.length == 0) return;

    for (int i = 0; i < sqliteDataList.length; i++) {
      ConductorSqliteData sqliteData = sqliteDataList[i];
      conductList.add(new ConductorImpedance(
          sqliteData.nameConuctor,
          double.parse(sqliteData.positiveSequenceResistance),
          double.parse(sqliteData.positiveSequenceReactance),
          double.parse(sqliteData.positiveSequenceImpedance),
          double.parse(sqliteData.zeroSequenceResistance),
          double.parse(sqliteData.zeroSequenceReactance),
          double.parse(sqliteData.zeroSequenceImpedance),
          double.parse(sqliteData.positiveSequenceAngle),
          double.parse(sqliteData.zeroSequenceAngle)));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Conductor Parameter"),
      ),
      body: new Container(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildList4ConductorType(),
                    SizedBox(height: 10.0),
                    containerString(_lineConductor.nameConductor),
                    SizedBox(height: 10.0),
                    buidShowConductorData(),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          new FloatingActionButton.extended(
                            heroTag: "btn1",
                            backgroundColor: Colors.teal[100],
                            foregroundColor: Colors.black,
                            isExtended: true,
                            icon: Icon(Icons.add),
                            label: Text("Add New Conductor"),
                            onPressed: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) =>
                                      AddNewConductorScreen()));
                            },
                          ),
                          SizedBox(height: 20.0),
                          FloatingActionButton.extended(
                            heroTag: "btn2",
                            onPressed: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) =>
                                      DeleteConductorScreen()));
                            },
                            backgroundColor: Colors.teal[100],
                            foregroundColor: Colors.black,
                            isExtended: true,
                            icon: Icon(Icons.delete_forever),
                            label: new Text("Delete Data"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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

  Widget buildList4ConductorType() {
    return new DropdownButtonFormField<ConductorImpedance>(
      isDense: true,
      isExpanded: true,
      focusColor: Colors.deepOrangeAccent,
      dropdownColor: Colors.blue[100],
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(20.0),
            ),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.blue[100]),
          hintText: "Select Conductor",
          fillColor: Colors.blue[100]),
      hint: new Text("Select Conductor"),
      elevation: 10,
      value: _lineConductor,
      onChanged: (ConductorImpedance value) {
        setState(() {
          _lineConductor = value;
        });
      },
      validator: (ConductorImpedance value) {
        if (value == null) {
          return 'Please select conductor';
        }
        return null;
      },
      items: conductList.map((ConductorImpedance list) {
        return new DropdownMenuItem<ConductorImpedance>(
          value: list,
          child: new Text(
            list.nameConductor,
            overflow: TextOverflow.clip,
          ),
        );
      }).toList(),
    );
  }

  Widget buidShowConductorData() {
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
          TableCell(child: containerString("Positive Sequence Reactance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.xP.toString()),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Positive Sequence Resistance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.rP.toString()),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Positive Sequence Impedance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.zP.toString()),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero Sequence Reactance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.x0.toString()),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero Sequence Resistance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.r0.toString()),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero Sequence Impedance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.z0.toString()),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Positive Sequence Angle")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.zPAngle.toString()),
          ),
          TableCell(child: containerString("°")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero Sequence Angle")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.z0Angle.toString()),
          ),
          TableCell(child: containerString("°")),
        ]),
      ],
    );
  }
}
