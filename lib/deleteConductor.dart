import 'package:aio4getco/data/conductorImpedanceList.dart';
import 'package:aio4getco/dbHelperFolder/dbProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteConductorScreen extends StatefulWidget {
  @override
  _DeleteConductorState createState() => _DeleteConductorState();
}

class _DeleteConductorState extends State<DeleteConductorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Delete Conductor Data"),
      ),
      body: new FutureBuilder<List<ConductorSqliteData>>(
        future: DBProvider.db.getConductor(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ConductorSqliteData>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length >= 1) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  ConductorSqliteData item = snapshot.data[index];
                  return Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              SizedBox(height: 10.0),
                              containerTitle(item.nameConuctor),
                              SizedBox(height: 10.0),
                              buidShowConductorData(item),
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FloatingActionButton.extended(
                                heroTag:
                                    'delete"${item.nameConuctor}"', //heroTag is very importanat in floating action button. It is required to give different heroTag fo all the floating action button in flutter...
                                onPressed: () {
                                  //_showMyDialog(item);
                                  final snackBar = SnackBar(
                                    content: Text('Do you want to delete?'),
                                    action: SnackBarAction(
                                      label: 'Yes',
                                      onPressed: () {
                                        DBProvider.db.deleteConductor(item.id);
                                        setState(() {});
                                      },
                                    ),
                                  );

                                  // Find the ScaffoldMessenger in the widget tree
                                  // and use it to show a SnackBar.
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                backgroundColor: Colors.teal[200],
                                foregroundColor: Colors.black,
                                isExtended: true,
                                icon: Icon(Icons.delete_forever),
                                label:
                                    new Text('Delete "${item.nameConuctor}" '),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("Sorry! Nothing is stored in your database."),
                /* child: Image(
                  image: AssetImage('empty-product.png'),
                ), */
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget containerString(String text) {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget containerTitle(String text) {
    return Container(
      padding: EdgeInsets.all(2.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget buidShowConductorData(ConductorSqliteData _lineConductor) {
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
            child: containerString(_lineConductor.positiveSequenceReactance),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Positive Sequence Resistance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.positiveSequenceResistance),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Positive Sequence Impedance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.positiveSequenceImpedance),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero Sequence Reactance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.zeroSequenceReactance),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero Sequence Resistance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.zeroSequenceResistance),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero Sequence Impedance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.zeroSequenceImpedance),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Positive Sequence Angle")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.positiveSequenceAngle),
          ),
          TableCell(child: containerString("°")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero Sequence Angle")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_lineConductor.zeroSequenceAngle),
          ),
          TableCell(child: containerString("°")),
        ]),
      ],
    );
  }

  Future<void> _showMyDialog(ConductorSqliteData _lineConductor) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Conductor Data'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                    'Would you like to delete "${_lineConductor.nameConuctor}" ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                DBProvider.db.deleteConductor(_lineConductor.id);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
