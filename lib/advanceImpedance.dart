import 'package:aio4getco/data/classFile.dart';
import 'package:aio4getco/data/conductorImpedanceList.dart';
import 'package:aio4getco/data/zoneDisplayScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdvanceImpedanceScreen extends StatefulWidget {
  @override
  _AdvanceImpedanceState createState() => _AdvanceImpedanceState();
}

class _AdvanceImpedanceState extends State<AdvanceImpedanceScreen> {
  List<ConductorImpedance> conductList;

  @override
  void initState() {
    super.initState();
    _value = 0;
    conductList = initiateConductorData();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _voltageText = "Line Voltage(kV)";
  final _maxPowerFlowText = "Max. Power Flow(MVA)";
  final _ctrText = "CT Ratio";
  final _ptrText = "PT Ratio";
  final _faultLevelLocalText = "Fault Level Local(MVA)";
  final _faultLevelRemoteText = "Fault Level Remote(MVA)";
  final _positiveSequenceResistanceText = "Rp";
  final _zeroSequenceResistanceText = "R0";
  final _positiveSequenceReactanceText = "Xp";
  final _zeroSequenceReactanceText = "X0";
  final _positiveSequenceImpedanceText = "Zp";
  final _zeroSequenceImpedanceText = "Z0";
  final _zeroSequenceAngleText = "Z0 Angle";
  final _positiveSequenceAngleText = "Zp Angle";
  final _lineLengthToBeProtectedText = "Length of Line to be Protected";
  final _nextShortestFromOtherEndText =
      "Length of Next Shortest Line from Remote End";
  final _nextLongestFromOtherEndText =
      "Length of Next Longest Line from Remote End";
  final _shortedLineLocalText = "Length of Shortest Line Local End";
  final _lineDoubleCktText = "Is this double circuit line?";

  int _value;

  double _voltageLevel,
      _maxPowerFlow,
      _ctr,
      _ptr,
      _faultLevelLocal,
      _faultLevelRemote,
      _lineLength,
      _nextShortestLine,
      _nextLongestLine,
      _shortestLine,
      _positiveSequenceResistance,
      _zeroSequenceResistance,
      _positiveSequenceReactance,
      _zeroSequenceReactance,
      _positiveSequenceImpedance,
      _zeroSequenceImpedance,
      _positiveSequenceAngle,
      _zeroSequenceAngle;

  ConductorImpedance _lineConductor,
      _nextLongestConductor,
      _nextShortestConductor,
      _shortestConductor;

  bool _isLineDoubleCKT = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Advance Calculation"),
      ),
      body: new Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                buildVoltPowerContainer(),
                SizedBox(
                  height: 10.0,
                ),
                buildCTRPTRContainer(),
                SizedBox(
                  height: 10.0,
                ),
                buildFaultLevelContainer(),
                SizedBox(
                  height: 10.0,
                ),
                buildMainLineContainer(),
                SizedBox(
                  height: 10.0,
                ),
                buildNextLongestLengthField(),
                SizedBox(
                  height: 10.0,
                ),
                buildList4ConductorType4NextLongest(),
                SizedBox(
                  height: 10.0,
                ),
                buildNextShortestLengthField(),
                SizedBox(
                  height: 10.0,
                ),
                buildList4ConductorType4NextShortest(),
                SizedBox(
                  height: 10.0,
                ),
                buildShortestLengthField(),
                SizedBox(
                  height: 10.0,
                ),
                buildList4ConductorOfShortestType(),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_lineDoubleCktText),
                      flex: 5,
                    ),
                    Expanded(
                      child: Checkbox(
                          value: _isLineDoubleCKT,
                          onChanged: (bool value) {
                            setState(() {
                              _isLineDoubleCKT = value;
                            });
                          }),
                      flex: 1,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                buildButtonContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onChangeRadio(int radioValue) {
    setState(() {
      _value = radioValue;
    });
  }

  Widget buildMainLineContainer() {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Line to be Protected",
              style: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.blueAccent),
            ),
          ),
          new Row(
            children: [
              new Radio(value: 0, groupValue: _value, onChanged: onChangeRadio),
              new Text("Hybrid Conductor"),
              new Radio(value: 1, groupValue: _value, onChanged: onChangeRadio),
              new Text("Custome data"),
            ],
          ),
          _value == 1 ? buildLineLengthField() : buidHybridConductorContainer(),
          SizedBox(
            height: 10.0,
          ),
          _value == 1 ? customeConductorData() : buidHybridConductorContainer(),
        ],
      ),
    );
  }

  Widget buidHybridConductorContainer() {
    return Container(
      child: Text("Wdget is under development"),
    );
  }

  Widget customeConductorData() {
    return Container(
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

  Widget buildVoltPowerContainer() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 5.0),
              child: buildVoltageField(),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5.0),
              child: buildMaxPowerFlowField(),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget buildVoltageField() {
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
        _voltageLevel = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _voltageText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "kV",
      ),
    );
  }

  Widget buildMaxPowerFlowField() {
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
        _maxPowerFlow = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _maxPowerFlowText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "MVA",
      ),
    );
  }

  Widget buildCTRPTRContainer() {
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

  Widget buildFaultLevelContainer() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 5.0),
              child: buildLocalFaultField(),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5.0),
              child: buildRemoteFaultField(),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget buildLocalFaultField() {
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
        _faultLevelLocal = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _faultLevelLocalText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "MVA",
      ),
    );
  }

  Widget buildRemoteFaultField() {
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
        _faultLevelRemote = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _faultLevelRemoteText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "MVA",
      ),
    );
  }

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

  Widget buildNextLongestLengthField() {
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
        _nextLongestLine = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _nextLongestFromOtherEndText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "km",
      ),
    );
  }

  Widget buildNextShortestLengthField() {
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
        _nextShortestLine = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _nextShortestFromOtherEndText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "km",
      ),
    );
  }

  Widget buildShortestLengthField() {
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
        _shortestLine = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _shortedLineLocalText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "km",
      ),
    );
  }

  Widget buildList4ConductorType4NextLongest() {
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
      value: _nextLongestConductor,
      onChanged: (ConductorImpedance value) {
        setState(() {
          _nextLongestConductor = value;
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

  Widget buildList4ConductorType4NextShortest() {
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
      value: _nextShortestConductor,
      onChanged: (ConductorImpedance value) {
        setState(() {
          _nextShortestConductor = value;
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

  Widget buildList4ConductorOfShortestType() {
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
      value: _shortestConductor,
      onChanged: (ConductorImpedance value) {
        setState(() {
          _shortestConductor = value;
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

  Widget buildButtonContainer() {
    return ButtonBar(children: <Widget>[
      (RaisedButton(
        color: Colors.teal,
        elevation: 5.0,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0),
        ),
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return;
          }
          _formKey.currentState.save();

          double ctptRatio = _ctr / _ptr;
          double zoneMulti = _isLineDoubleCKT ? 1.5 : 1.2;

          _lineConductor = ConductorImpedance(
              "Custome Data",
              _positiveSequenceResistance,
              _positiveSequenceReactance,
              _positiveSequenceImpedance,
              _zeroSequenceResistance,
              _zeroSequenceReactance,
              _zeroSequenceImpedance,
              _positiveSequenceAngle,
              _zeroSequenceAngle);

          Details userDetail = Details(
              _voltageLevel,
              _maxPowerFlow,
              ctptRatio,
              _faultLevelLocal,
              _faultLevelRemote,
              _lineLength,
              _lineConductor,
              _nextLongestLine,
              _nextLongestConductor,
              _nextShortestLine,
              _nextShortestConductor,
              _shortestLine,
              _shortestConductor,
              zoneMulti);

          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => ZoneDisplayScreen(userDetail)));

          setState(() {
            //_isButtonClicked = true;
          });
        },
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
      ))
    ]);
  }
}
