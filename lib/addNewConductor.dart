import 'dart:math';

import 'package:aio4getco/data/conductorImpedanceList.dart';
import 'package:aio4getco/dbHelperFolder/dbProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewConductorScreen extends StatefulWidget {
  @override
  _AddNewConductorState createState() => _AddNewConductorState();
}

class _AddNewConductorState extends State<AddNewConductorScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _positiveSequenceResistanceText = "Rp";
  final _zeroSequenceResistanceText = "R0";
  final _positiveSequenceReactanceText = "Xp";
  final _zeroSequenceReactanceText = "X0";
  final _positiveSequenceImpedanceText = "Zp";
  final _zeroSequenceImpedanceText = "Z0";
  final _zeroSequenceAngleText = "Z0 Angle";
  final _positiveSequenceAngleText = "Zp Angle";
  final _nameofConductorText = "Please specify name of the conductor";
  final _ctrText = "CT Ratio";
  final _ptrText = "PT Ratio";
  final _lineLengthToBeProtectedText = "Line Length";

  double _positiveSequenceResistance,
      _zeroSequenceResistance,
      _positiveSequenceReactance,
      _zeroSequenceReactance,
      _positiveSequenceImpedance,
      _zeroSequenceImpedance,
      _positiveSequenceAngle,
      _zeroSequenceAngle,
      _ctr,
      _ptr,
      _lineLength;

  String _nameOfConductor;

  int selectedValue;

  bool _valueInPrimary, dataSavedToDb;

  onRadioChange(int val) {
    setState(() {
      selectedValue = val;
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void initState() {
    super.initState();
    selectedValue = 1;
    _valueInPrimary = true;
    dataSavedToDb = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Add New Conductor"),
      ),
      body: Builder(
        builder: (context) => new Container(
          padding: EdgeInsets.all(15.0),
          child: Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    radioButtonContiner(),
                    SizedBox(
                      height: 10.0,
                    ),
                    new Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: buildRpField(),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: buildXpField(),
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: buildZpField(),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: buildAZpField(),
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: buildR0Field(),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: buildX0Field(),
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: buildZ0Field(),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: buildAZ0Field(),
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    buidNameOfConductorField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _valueInPrimary ? buildLineLengthField() : Container(),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildFlotingActionButton(context),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget radioButtonContiner() {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal[100]),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 5.0, left: 5.0),
              child: Text("Do you wish to enter primary value?"),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 5.0),
              child: Column(
                children: [
                  RadioListTile(
                    value: 1,
                    groupValue: selectedValue,
                    title: Text("Yes"),
                    onChanged: (val) {
                      _valueInPrimary = true;
                      onRadioChange(val);
                    },
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: selectedValue,
                    title: Text("No"),
                    onChanged: (val) {
                      _valueInPrimary = false;
                      onRadioChange(val);
                    },
                  ),
                ],
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget buildRpField() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,4}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _positiveSequenceResistance = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _positiveSequenceResistanceText, //Pending
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "Ω",
      ),
    );
  }

  Widget buildXpField() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,4}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _positiveSequenceReactance = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _positiveSequenceReactanceText, //Pending
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "Ω",
      ),
    );
  }

  Widget buildZpField() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,4}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _positiveSequenceImpedance = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _positiveSequenceImpedanceText, //Pending
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "Ω",
      ),
    );
  }

  Widget buildAZpField() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _positiveSequenceAngle = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _positiveSequenceAngleText, //Pending
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "°",
      ),
    );
  }

  Widget buildR0Field() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,4}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _zeroSequenceResistance = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _zeroSequenceResistanceText, //Pending
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "kV",
      ),
    );
  }

  Widget buildX0Field() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,4}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _zeroSequenceReactance = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _zeroSequenceReactanceText, //Pending
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "Ω",
      ),
    );
  }

  Widget buildZ0Field() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,4}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _zeroSequenceImpedance = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _zeroSequenceImpedanceText, //Pending
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "Ω",
      ),
    );
  }

  Widget buildAZ0Field() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _zeroSequenceAngle = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _zeroSequenceAngleText, //Pending
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "°",
      ),
    );
  }

  Widget buidNameOfConductorField() {
    return TextFormField(
      //keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        return null;
      },
      onSaved: (value) {
        _nameOfConductor = value;
      },
      decoration: InputDecoration(
        labelText: _nameofConductorText, //Pending
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  Widget buildFlotingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.teal[100],
      foregroundColor: Colors.black,
      isExtended: true,
      icon: Icon(Icons.save),
      label: Text("SAVE"),
      onPressed: () async {
        if (!_formKey.currentState.validate()) {
          return;
        }
        _formKey.currentState.save();
        if (_valueInPrimary) {
          int decimals = 4;
          int fac = pow(10, decimals);

          //double ratioCtPt = _ctr / _ptr;
          //double finalMultiplier = 1 / _lineLength;
          _positiveSequenceResistance =
              ((_positiveSequenceResistance / _lineLength) * fac)
                      .roundToDouble() /
                  fac;
          _zeroSequenceResistance =
              ((_zeroSequenceResistance / _lineLength) * fac).roundToDouble() /
                  fac;
          _positiveSequenceReactance =
              ((_positiveSequenceReactance / _lineLength) * fac)
                      .roundToDouble() /
                  fac;
          _zeroSequenceReactance =
              ((_zeroSequenceReactance / _lineLength) * fac).roundToDouble() /
                  fac;
          _positiveSequenceImpedance =
              ((_positiveSequenceImpedance / _lineLength) * fac)
                      .roundToDouble() /
                  fac;
          _zeroSequenceImpedance =
              ((_zeroSequenceImpedance) / _lineLength * fac).roundToDouble() /
                  fac;
          _showMyDialog();
        } else if (!_valueInPrimary) {
          _showMyDialog();
        } else {
          return;
        }
      },
    );
  }

  /* Widget buildCTRPTRLineContainer() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 5.0),
              child: buildCTRField(),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5.0),
              child: buildPTRField(),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5.0),
              child: buildLineLengthField(),
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }

  Widget buildCTRField() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _ctr = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _ctrText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildPTRField() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _ptr = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _ptrText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }
 */

  Widget buildLineLengthField() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      cursorHeight: 20,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _lineLength = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _lineLengthToBeProtectedText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "km",
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) => AlertDialog(
        title: Text(_valueInPrimary
            ? "You have entered values in primary secendory equivalent is below"
            : "Your entered values in secondary are"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buidShowConductorData(),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Do you wish to save?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              saveValueToDb(context);
              FocusScope.of(context).unfocus();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('No'),
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.of(context).pop();
              return;
            },
          ),
        ],
      ),
    );
  }

  saveValueToDb(BuildContext context) async {
    var newConductor = ConductorSqliteData(
        id: 500,
        nameConuctor: _nameOfConductor,
        positiveSequenceResistance: _positiveSequenceResistance.toString(),
        positiveSequenceReactance: _positiveSequenceReactance.toString(),
        positiveSequenceImpedance: _positiveSequenceImpedance.toString(),
        positiveSequenceAngle: _positiveSequenceAngle.toString(),
        zeroSequenceResistance: _zeroSequenceResistance.toString(),
        zeroSequenceReactance: _zeroSequenceReactance.toString(),
        zeroSequenceImpedance: _zeroSequenceImpedance.toString(),
        zeroSequenceAngle: _zeroSequenceAngle.toString());
    var response = await DBProvider.db.newConductor(newConductor);

    if (response > 0) {
      setState(() {
        dataSavedToDb = true;
      });

      Navigator.pop(context, true);
    } else {
      setState(() {
        dataSavedToDb = false;
      });

      //show failure message...
    }
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
            child: containerString(_positiveSequenceReactance.toString()),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Positive Sequence Resistance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_positiveSequenceResistance.toString()),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Positive Sequence Impedance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_positiveSequenceImpedance.toString()),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero Sequence Reactance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_zeroSequenceReactance.toString()),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero Sequence Resistance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_zeroSequenceResistance.toString()),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero Sequence Impedance")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_zeroSequenceImpedance.toString()),
          ),
          TableCell(child: containerString("Ω")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Positive Sequence Angle")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_positiveSequenceAngle.toString()),
          ),
          TableCell(child: containerString("°")),
        ]),
        TableRow(children: [
          TableCell(child: containerString("Zero Sequence Angle")),
          TableCell(child: containerString(":")),
          TableCell(
            child: containerString(_zeroSequenceAngle.toString()),
          ),
          TableCell(child: containerString("°")),
        ]),
      ],
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
}
