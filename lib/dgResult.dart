import 'package:aio4getco/data/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aio4getco/data/classFile.dart';
import 'package:collection/collection.dart';

class DGReportScreen extends StatefulWidget {
  final DGDetails dgDetails;
  DGReportScreen(this.dgDetails);
  _DGReportState createState() => _DGReportState();
}

class _DGReportState extends State<DGReportScreen> {
  bool isDTapplicable = false;

  double valueCh4,
      valueC2h4,
      valueC2h2,
      valueH2,
      valueC2H6,
      valueCO2,
      valueCO,
      valueO2,
      valueN2;

  double _perCh4, _perC2h4, _perC2h2, _tdcg;

  String finalResult;

  String tdcgResult, ratioResult, keyGasResult;

  bool ratioMethodFail, dualTriangularFail;

  @override
  void initState() {
    super.initState();
    valueCh4 = widget.dgDetails.getMythen();
    valueC2h4 = widget.dgDetails.getC2h4();
    valueC2h2 = widget.dgDetails.getc2h2();
    valueH2 = widget.dgDetails.getHydrogen();
    valueC2H6 = widget.dgDetails.getC2h6();
    valueCO2 = widget.dgDetails.getCo2();
    valueCO = widget.dgDetails.getCo();
    valueO2 = widget.dgDetails.getOxygen();
    valueN2 = widget.dgDetails.getNitrogen();
    
    isDTapplicable = (valueCh4 >= 1 && valueC2h4 >= 1 && valueC2h2 >= 1);
    if (isDTapplicable) {
      finalResult = defineFault();
    } else {
      finalResult = "Dual Triangular method can not be applied";
    }
    calcRatioResult();
    calculateKeyGas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DGA Result"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal[300]),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Result base on "Dual Triangular Method"',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        finalResult,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal[300]),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Result base on "Ratio Method"',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Note: ' + tdcgResult,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 15.0, color: Colors.red),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        ratioResult,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal[300]),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Result base on "Key-Gas Method"',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        keyGasResult,
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String defineFault() {
    double totalSum = valueCh4 + valueC2h4 + valueC2h2;
    _perCh4 = 100 * valueCh4 / totalSum;
    _perC2h4 = 100 * valueC2h4 / totalSum;
    _perC2h2 = 100 * valueC2h2 / totalSum;

    print(_perCh4);
    print(_perC2h2);
    print(_perC2h4);

    if (_perCh4 >= 98.0) {
      return DT_RESLUT_PD;
    }
    if (_perC2h2 <= 4.0 && _perC2h4 <= 20) {
      return DT_RESULT_T1;
    }
    if (_perC2h2 <= 4.0 && _perC2h4 > 20.0 && _perC2h4 <= 50) {
      return DT_RESULT_T2;
    }
    if (_perC2h4 > 50 && _perC2h2 <= 15) {
      return DT_RESULT_T3;
    }
    if (_perC2h2 >= 13.0 && _perC2h4 <= 23) {
      return DT_RESULT_D1;
    }
    if ((23.0 < _perC2h4 && _perC2h4 <= 40.0 && _perC2h2 >= 13.0) ||
        (_perC2h2 >= 29.0 && _perC2h4 > 40.0)) {
      return DT_RESULT_D2;
    }
    if ((_perC2h4 < 40 && _perC2h2 > 4 && _perC2h2 < 13) ||
        (_perC2h4 > 50 && _perC2h2 > 15 && _perC2h2 < 29) ||
        (_perC2h4 > 40 && _perC2h4 < 50 && _perC2h2 > 4 && _perC2h4 < 29)) {
      return DT_RESULT_DT;
    }
    return DT_RESULT_FAIL;
  }

  void calcRatioResult() {
    int _ratio1, _ratio2, _ratio3, _ratio4;
    double _ratio5 = valueCO2 / valueCO;
    //Calculate for Ratio-1.
    if (valueH2 == 0) {
      _ratio1 = 1;
    } else if (valueCh4 / valueH2 <= 0.1) {
      _ratio1 = 5;
    } else if (valueCh4 / valueH2 > 0.1 && valueCh4 / valueH2 < 1) {
      _ratio1 = 0;
    } else if (valueCh4 / valueH2 >= 1 && valueCh4 / valueH2 < 3) {
      _ratio1 = 1;
    } else {
      _ratio1 = 2;
    }
    //Calculate for Ratio-2.
    if (valueCh4 == 0) {
      _ratio2 = 1;
    } else if (valueC2H6 / valueCh4 < 1) {
      _ratio2 = 0;
    } else {
      _ratio2 = 1;
    }
    //Calculate for Ratio-3.
    if (valueC2H6 == 0) {
      _ratio3 = 1;
    } else if (valueC2h4 / valueC2H6 < 1) {
      _ratio3 = 0;
    } else if (valueC2h4 / valueC2H6 >= 1 && valueC2h4 / valueC2H6 < 3) {
      _ratio3 = 1;
    } else {
      _ratio3 = 2;
    }
    //Calculate for Ratio-4.
    if (valueC2h4 == 0) {
      _ratio4 = 1;
    } else if (valueC2h2 / valueC2h4 < 0.5) {
      _ratio4 = 0;
    } else if (valueC2h2 / valueC2h4 >= 0.5 && valueC2h2 / valueC2h4 < 3) {
      _ratio4 = 1;
    } else {
      _ratio4 = 2;
    }
    _tdcg = valueH2 + valueCh4 + valueC2h4 + valueC2H6 + valueC2h2 + valueCO;
    //Calculate for Ratio-5.

    /* List<int> ratioList = [_ratio1, _ratio2, _ratio3, _ratio4];
    Function eq = const ListEquality().equals;
    print(eq(ratioList, RATIO_ARRAY1));
    if (eq(ratioList, RATIO_ARRAY1)) {} */
    if ((_ratio1 == 1 || _ratio1 == 2) &&
        _ratio2 == 0 &&
        _ratio3 == 0 &&
        _ratio4 == 0) {
      ratioResult = RATIO_RESULT3;
    } else if ((_ratio1 == 1 || _ratio1 == 2) &&
        _ratio2 == 1 &&
        _ratio3 == 0 &&
        _ratio4 == 0) {
      ratioResult = RATIO_RESULT4;
    } else if (_ratio1 == 0 && _ratio2 == 1 && _ratio3 == 0 && _ratio4 == 0) {
      ratioResult = RATIO_RESULT5;
    } else if (_ratio1 == 0 && _ratio2 == 0 && _ratio3 == 1 && _ratio4 == 0) {
      ratioResult = RATIO_RESULT6;
    } else if (_ratio1 == 1 && _ratio2 == 0 && _ratio3 == 1 && _ratio4 == 0) {
      ratioResult = RATIO_RESULT7;
    } else if (_ratio1 == 1 && _ratio2 == 0 && _ratio3 == 2 && _ratio4 == 0) {
      ratioResult = RATIO_RESULT8;
    } else if (_ratio1 == 0 && _ratio2 == 0 && _ratio3 == 0 && _ratio4 == 0) {
      ratioResult = RATIO_RESULT1;
    } else {
      if (_ratio1 == 5 && _ratio2 == 0 && _ratio3 == 0 && _ratio4 == 0) {
        ratioResult = RATIO_RESULT2;
      } else if (_ratio1 == 5 &&
          _ratio2 == 0 &&
          _ratio3 == 0 &&
          (_ratio4 == 1 || _ratio4 == 2)) {
        ratioResult = RATIO_RESULT12;
      } else if (_ratio1 == 0 && _ratio2 == 0 && _ratio3 == 2 && _ratio4 == 2) {
        ratioResult = RATIO_RESULT11;
      } else if (_ratio1 == 0 &&
          _ratio2 == 0 &&
          (_ratio3 == 1 || _ratio3 == 2) &&
          (_ratio4 == 1 || _ratio4 == 2)) {
        ratioResult = RATIO_RESULT10;
      } else if (_ratio1 == 0 && _ratio2 == 0 && _ratio3 == 0 && _ratio4 == 1) {
        ratioResult = RATIO_RESULT9;
      } else {
        ratioResult =
            'Sorry, It is not possible to conculde using ratio method. Please refer key-gas method';
      }
    }

    if (_tdcg > TDCG) {
      tdcgResult = RATIO_GOOD;
    } else {
      tdcgResult = RATIO_NOT_GOOD;
    }

    if (_ratio5 > 11) {
      ratioResult = ratioResult + "\n" + RATIO_RESULT_CO2_CO_NORMAL;
    } else {
      ratioResult = ratioResult + "\n" + RATIO_RESULT_CO2_CO_ABNORMAL;
    }
  }

  void calculateKeyGas() {
    keyGasResult = "";
    
    if (valueH2 < 100) {
      keyGasResult = keyGasResult + KEY_GAS_H2_NORMAL;
    } else if (valueH2 < 700) {
      keyGasResult = keyGasResult + KEY_GAS_H2_HIGH;
    } else {
      keyGasResult = keyGasResult + KEY_GAS_H2_ABNORMAL;
    }

    if (valueC2h4 < 120) {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_CH4_NORMAL;
    } else if (valueCh4 < 400) {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_CH4_HIGH;
    } else {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_CH4_ABNORMAL;
    }

    if (valueC2h4 < 50) {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_C2H4_NORMAL;
    } else if (valueC2h4 < 100) {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_C2H4_HIGH;
    } else {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_C2H4_ABNORMAL;
    }
    //print(valueC2H6);

    if (valueC2H6 < 65) {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_C2H6_NORMAL;
    } else if (valueC2H6 < 100) {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_C2H6_HIGH;
    } else {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_C2H6_ABNORMAL;
    }

    if (valueC2h2 < 35) {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_C2H2_NORMAL;
    } else if (valueC2h2 < 50) {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_C2H2_HIGH;
    } else {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_C2H2_ABNORMAL;
    }

    if (valueCO2 < 10000) {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_CO2_NORMAL;
    } else if (valueCO2 < 15000) {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_CO2_HIGH;
    } else {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_CO2_ABNORMAL;
    }

    if (valueCO < 350) {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_CO_NORMAL;
    } else if (valueCO < 570) {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_CO_HIGH;
    } else {
      keyGasResult = keyGasResult + '\n' + KEY_GAS_CO_ABNORMAL;
    }
  }
}
