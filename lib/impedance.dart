import 'package:aio4getco/data/classFile.dart';
import 'package:aio4getco/data/zoneDisplayScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/conductorImpedanceList.dart';

class ImpedanceScreen extends StatefulWidget {
  @override
  _ImpedanceState createState() => _ImpedanceState();
}

class _ImpedanceState extends State<ImpedanceScreen> {
  List<ConductorImpedance> conductList;

  @override
  void initState() {
    super.initState();
    conductList = initiateConductorData();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _voltageText = "Line Voltage(kV)";
  final _maxPowerFlowText = "Max. Power Flow(MVA)";
  final _ctrText = "CT Ratio";
  final _ptrText = "PT Ratio";
  final _faultLevelLocalText = "Fault Level Local(MVA)";
  final _faultLevelRemoteText = "Fault Level Remote(MVA)";
  final _lineLengthToBeProtectedText = "Length of Line to be Protected";
  final _nextShortestFromOtherEndText =
      "Length of Next Shortest Line from Remote End";
  final _nextLongestFromOtherEndText =
      "Length of Next Longest Line from Remote End";
  final _shortedLineLocalText = "Length of Shortest Line Local End";
  final _lineDoubleCktText = "Is this double circuit line?";

  double _voltageLevel,
      _maxPowerFlow,
      _ctr,
      _ptr,
      _faultLevelLocal,
      _faultLevelRemote,
      _lineLength,
      _nextShortestLine,
      _nextLongestLine,
      _shortestLine;

  ConductorImpedance _lineConductor,
      _nextLongestConductor,
      _nextShortestConductor,
      _shortestConductor;

  bool _isLineDoubleCKT = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Impedance Settings"),
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
                buildLineLengthField(),
                SizedBox(
                  height: 10.0,
                ),
                buildList4ConductorType(),
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
