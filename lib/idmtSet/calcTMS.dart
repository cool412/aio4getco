import 'dart:math';
import 'package:aio4getco/data/conductorImpedanceList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TMSScreen extends StatefulWidget {
  _TMSState createState() => _TMSState();
}

class _TMSState extends State<TMSScreen> {
  List<CurveClass> curveList;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CurveClass _selectCurve;

  double _setValue, _faultValue, _timeRequired;

  String _setValueText = "Set Current Value (A)";
  String _faultValueText = "Fault Current Value (A)";
  String _timeRequiredText = "Required Time delay to clear Fault (s)";

  String _requiredTMS = "";

  @override
  void initState() {
    super.initState();
    curveList = initiateCurveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Calculate TMS"),
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
                buildSetValueField(),
                SizedBox(height: 5.0),
                buildFaultValueField(),
                SizedBox(height: 5.0),
                buildTimeField(),
                SizedBox(height: 5.0),
                buildButtonContainer(),
                SizedBox(height: 10.0),
                buildResultText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResultText(){
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Text("Required TMS to be set in IDMT Relay: " + _requiredTMS),
        ],
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

  Widget buildSetValueField() {
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
        _setValue = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _setValueText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "A",
      ),
    );
  }

  Widget buildFaultValueField() {
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

  Widget buildTimeField() {
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
        _timeRequired = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _timeRequiredText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
        suffixText: "s",
      ),
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

          double currentRatio = _faultValue / _setValue;
          double currentRatioPower = pow(currentRatio, _selectCurve.aValue);
          double numeratorValue =
              _timeRequired * (currentRatioPower - _selectCurve.pValue);
          double timeMultiple = numeratorValue / _selectCurve.kValue;

          setState(() {
            _requiredTMS = timeMultiple.toStringAsFixed(2);
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
