import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RefCalcScreen extends StatefulWidget {
  @override
  _RefCalcState createState() => _RefCalcState();
}

class _RefCalcState extends State<RefCalcScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _voltageText = "System Voltage";
  final _faultLevelText = "Fault Level";
  final _impedanceText = "TR Impedance";
  final _ratingMVAText = "TR Rating";
  final _ratioCTPhaseText = "CT Ratio";
  final _ratioCTNeutralText = "CT Ratio";
  final _resistanceMKText = "Average CT Sec. Resistance";
  final _resistanceLeadText = "Lead Resistance (2RL)";
  final _relayPickUpCurrentText = "Relay Pick up current";
  final _relayOhmicBurdenText = "Relay Ohmic Burdon";
  final _additionalMarginText = "Additional Margin for Safety";

  double _voltageLevel,
      _faultLevelMVA,
      _impedacePer,
      _ratingMVA,
      _ratioPhaseCT,
      _ratioNeutralCT,
      _resistanceMK,
      _resistanceLead;

  double _relayPickUpCurrent = 0.2;
  double _relayOhmicVA = 0.1;
  double _additionMargin = 20;

  bool makeSourceImpedanceZero = false;
  bool _isButtonClicked = false;

  double _finalVoltageToBeSet,
      _finalResistanceToBeSet,
      _finalVoltageWithMargin,
      _finalReswithMargin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REF Calculation"),
      ),
      body: Container(
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
                  height: 5.0,
                ),
                buildImpedanceRatingContainer(),
                SizedBox(
                  height: 5.0,
                ),
                buildRatioCTNeutralField(),
                SizedBox(
                  height: 5.0,
                ),
                buildResistanceMKField(),
                SizedBox(
                  height: 5.0,
                ),
                buildResistanceLeadField(),
                SizedBox(
                  height: 5.0,
                ),
                buildBurdonPickUpContainer(),
                SizedBox(
                  height: 5.0,
                ),
                buildMarginField(),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                          "Make Calculation independent of source Impedance"),
                      flex: 5,
                    ),
                    Flexible(
                      child: Checkbox(
                          value: makeSourceImpedanceZero,
                          onChanged: (bool value) {
                            setState(() {
                              makeSourceImpedanceZero = value;
                            });
                          }),
                      flex: 1,
                    ),
                  ],
                ),
                buildButtonContainer(),
                SizedBox(
                  height: 5.0,
                ),
                _isButtonClicked ? buildShowAfterSubmission() : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildShowAfterSubmission() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  "Stabilising Voltage:",
                  style: TextStyle(fontSize: 16),
                ),
                flex: 3,
              ),
              SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: Text(
                  _finalVoltageToBeSet.toStringAsFixed(2) ?? "",
                  style: TextStyle(fontSize: 16),
                ),
                flex: 1,
              ),
              SizedBox(
                width: 5.0,
              ),
              Flexible(
                child: Text(
                  "V",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                flex: 1,
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  "Stabilising Resistance:",
                  style: TextStyle(fontSize: 16),
                ),
                flex: 3,
              ),
              SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: Text(
                  _finalResistanceToBeSet.toStringAsFixed(2) ?? "",
                  style: TextStyle(fontSize: 16),
                ),
                flex: 1,
              ),
              SizedBox(
                width: 5.0,
              ),
              Flexible(
                child: Text(
                  "Ω",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                flex: 1,
              )
            ],
          ),
          SizedBox(height: 5.0),
          Text(
            "With Safety Margin of $_additionMargin",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18.0),
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  "Stabilising Voltage:",
                  style: TextStyle(fontSize: 16),
                ),
                flex: 3,
              ),
              SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: Text(
                  _finalVoltageWithMargin.toStringAsFixed(2) ?? "",
                  style: TextStyle(fontSize: 16),
                ),
                flex: 1,
              ),
              SizedBox(
                width: 5.0,
              ),
              Flexible(
                child: Text(
                  "V",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                flex: 1,
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  "Stabilising Resistance:",
                  style: TextStyle(fontSize: 16),
                ),
                flex: 3,
              ),
              SizedBox(
                width: 15.0,
              ),
              Flexible(
                child: Text(
                  _finalReswithMargin.toStringAsFixed(2) ?? "",
                  style: TextStyle(fontSize: 16),
                ),
                flex: 1,
              ),
              SizedBox(
                width: 5.0,
              ),
              Flexible(
                child: Text(
                  "Ω",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                flex: 1,
              )
            ],
          ),
        ],
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
              child: buildFaultLevelField(),
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
          hintText: "Voltage",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          //prefixIcon: Icon(Icons.email),
          suffixText: "kV"),
    );
  }

  Widget buildFaultLevelField() {
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
        if (test == null || test <= 0.0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _faultLevelMVA = double.tryParse(value);
      },
      decoration: InputDecoration(
          labelText: _faultLevelText,
          hintText: "Fault Level",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          //prefixIcon: Icon(Icons.email),
          suffixText: "MVA"),
    );
  }

  Widget buildImpedanceRatingContainer() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 5.0),
              child: buildImpedanceField(),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5.0),
              child: buildRatingMVAField(),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget buildImpedanceField() {
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
        if (test == null || test <= 0.0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _impedacePer = double.tryParse(value);
      },
      decoration: InputDecoration(
          labelText: _impedanceText,
          hintText: "%Impedance",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          //prefixIcon: Icon(Icons.email),
          suffixText: "%"),
    );
  }

  Widget buildRatingMVAField() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0.0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _ratingMVA = double.tryParse(value);
      },
      decoration: InputDecoration(
          labelText: _ratingMVAText,
          hintText: "TR Rating",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          //prefixIcon: Icon(Icons.email),
          suffixText: "MVA"),
    );
  }

  Widget buildRatioCTPhaseField() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0.0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _ratioPhaseCT = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _ratioCTPhaseText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildRatioCTNeutralField() {
    return TextFormField(
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0.0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _ratioNeutralCT = double.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _ratioCTNeutralText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildResistanceMKField() {
    return TextFormField(
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0.0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _resistanceMK = double.tryParse(value);
      },
      decoration: InputDecoration(
          labelText: _resistanceMKText,
          hintText: "Average of all CT Sec. Resistance",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          suffixText: "Ω"
          //prefixIcon: Icon(Icons.email),
          ),
    );
  }

  Widget buildResistanceLeadField() {
    return TextFormField(
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0.0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _resistanceLead = double.tryParse(value);
      },
      decoration: InputDecoration(
          labelText: _resistanceLeadText,
          hintText: "RL is resis of wire from CT MK to CR",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          suffixText: "Ω"
          //prefixIcon: Icon(Icons.email),
          ),
    );
  }

  Widget buildRelayBurdonField() {
    return TextFormField(
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test <= 0.0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _relayOhmicVA = double.tryParse(value);
      },
      decoration: InputDecoration(
          labelText: _relayOhmicBurdenText,
          hintText: "$_relayOhmicVA",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          suffixText: "VA"
          //prefixIcon: Icon(Icons.email),
          ),
    );
  }

  Widget buildRelayPUField() {
    return TextFormField(
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test >= 1.0 || test <= 0.0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _relayPickUpCurrent = double.tryParse(value);
      },
      decoration: InputDecoration(
          labelText: _relayPickUpCurrentText,
          hintText: "$_relayPickUpCurrent",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          suffixText: "A"
          //prefixIcon: Icon(Icons.email),
          ),
    );
  }

  Widget buildBurdonPickUpContainer() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 5.0),
              child: buildRelayPUField(),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 5.0),
              child: buildRelayBurdonField(),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget buildMarginField() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        double test = double.tryParse(value);
        if (test == null || test >= 100.0 || test <= 0.0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _additionMargin = double.tryParse(value);
      },
      decoration: InputDecoration(
          labelText: _additionalMarginText,
          hintText: "$_additionMargin",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          //prefixIcon: Icon(Icons.email),
          suffixText: "%"),
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
          calcResult();
          setState(() {
            _isButtonClicked = true;
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

  Future<void> calcResult() async {
    double volSquare = (_voltageLevel * _voltageLevel);
    // print(volSquare);
    double sourceImpedance =
        !makeSourceImpedanceZero ? volSquare / _faultLevelMVA : 0.0;
    // print(sourceImpedance.toString() + "source");
    double trLeackageImpedance =
        (_impedacePer * volSquare) / (100 * _ratingMVA);
    // print(trLeakageImpedance.toString() + "hey");
    double totalImpedance = sourceImpedance + trLeackageImpedance;
    // print(totalImpedance.toString() + "hi");
    double totalPathResistance = _resistanceMK + _resistanceLead;
    double maxThroughFault = (_voltageLevel * 1000 / 1.732) / totalImpedance;
    double voltageSet =
        (maxThroughFault / _ratioNeutralCT) * totalPathResistance;
    double resistanceToBeSet = (voltageSet / _relayPickUpCurrent) -
        (_relayOhmicVA / (_relayPickUpCurrent * _relayPickUpCurrent));
    //print(resistanceToBeSet);
    setState(() {
      _finalVoltageToBeSet = voltageSet;
      _finalResistanceToBeSet = resistanceToBeSet;
      _finalVoltageWithMargin = voltageSet * (100 +_additionMargin)/100;
      _finalReswithMargin = resistanceToBeSet * (100 + _additionMargin)/100;
    });
  }
}
