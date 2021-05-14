import 'package:aio4getco/data/conductorImpedanceList.dart';
import 'package:aio4getco/dbHelperFolder/dbProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  double _positiveSequenceResistance,
      _zeroSequenceResistance,
      _positiveSequenceReactance,
      _zeroSequenceReactance,
      _positiveSequenceImpedance,
      _zeroSequenceImpedance,
      _positiveSequenceAngle,
      _zeroSequenceAngle;

  String _nameOfConductor;

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
                    buildFlotingActionButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
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
        var newConductor = ConductorSqliteData(
            id: 50,
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
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Conductor added successfully!")));
          Navigator.pop(context, true);
        } else {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Sorry, There is something wrong.")));
          //show failure message...
        }
      },
    );
  }
}
