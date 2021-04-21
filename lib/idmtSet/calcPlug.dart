import 'dart:math';

import 'package:aio4getco/data/conductorImpedanceList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlugScreen extends StatefulWidget {
  _PlugState createState() => _PlugState();
}

class _PlugState extends State<PlugScreen> {
  List<CurveClass> curveList;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CurveClass _selectCurve;

  double _faultValue, _operateTime, _setTMS;

  String _faultValueText = "Fault Current Value (A)";
  String _operateTimeText = "Relay Operate Time (s)";
  String _setTMSText = "Time Dial Setting";

  String _plugSetting = "";

  @override
  void initState() {
    super.initState();
    curveList = initiateCurveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Calculate Plug Settings"),
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildList4CurveType(),
                SizedBox(height: 5.0),
                buildFaultCurrentField(),
                SizedBox(height: 5.0),
                buildOperateTimeField(),
                SizedBox(height: 5.0),
                buildSetTMSField(),
                SizedBox(height: 5.0),
                buildButtonContainer(),
                SizedBox(height: 10.0),
                buildResultText()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResultText() {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Text("Plug Setting required for above mentioned parameters: " + _plugSetting),
        ],
      ),
    );
  }

  Widget buildFaultCurrentField() {
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
        _faultValue = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _faultValueText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "A",
      ),
    );
  }

  Widget buildOperateTimeField() {
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
        _operateTime = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _operateTimeText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "s",
      ),
    );
  }

  Widget buildSetTMSField() {
    return TextFormField(
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
        _setTMS = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _setTMSText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        //suffixText: "",
      ),
    );
  }

  Widget buildList4CurveType() {
    return new DropdownButtonFormField<CurveClass>(
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
          hintText: "Select Curve Type",
          fillColor: Colors.blue[100]),
      hint: new Text("Select Curve Type"),
      elevation: 10,
      value: _selectCurve,
      onChanged: (CurveClass value) {
        setState(() {
          _selectCurve = value;
        });
      },
      validator: (CurveClass value) {
        if (value == null) {
          return 'Please select Curve Type';
        }
        return null;
      },
      items: curveList.map((CurveClass list) {
        return new DropdownMenuItem<CurveClass>(
          value: list,
          child: new Text(
            list.typeCurve,
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

          double timeRatio = _operateTime/_setTMS;
          double timeRatioWithConstAndK = _selectCurve.kValue/(timeRatio - _selectCurve.cValue);
          double intermedeateWithP = timeRatioWithConstAndK + _selectCurve.pValue;
          double finalPlugSetting = _faultValue * (pow(intermedeateWithP, -1/_selectCurve.aValue));

          setState(() {
            _plugSetting = finalPlugSetting.toStringAsFixed(2) + " A";
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
