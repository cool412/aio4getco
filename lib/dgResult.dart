import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aio4getco/data/classFile.dart';

class DGReportScreen extends StatefulWidget {
  final DGDetails dgDetails;
  DGReportScreen(this.dgDetails);
  _DGReportState createState() => _DGReportState();
}

class _DGReportState extends State<DGReportScreen> {
  bool isDTapplicable = false;

  double valueCh4, valueC2h4, valueC2h2;

  double _perCh4, _perC2h4, _perC2h2;

  String finalResult;

  @override
  void initState() {
    super.initState();
    valueCh4 = widget.dgDetails.getMythen();
    valueC2h4 = widget.dgDetails.getC2h4();
    valueC2h2 = widget.dgDetails.getc2h2();
    print(valueCh4);
    print(valueC2h4);
    print(valueC2h2);
    isDTapplicable = (valueCh4 >= 50 && valueC2h4 >= 10 && valueC2h2 >= 1);
    if (isDTapplicable) {
      finalResult = defineFault();
    } else {
      finalResult = "Test Failed";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DGA"),
      ),
      body: Center(
        child: Text(finalResult),
      ),
    );
  }

  String defineFault() {
    double totalSum = valueCh4 + valueC2h4 + valueC2h2;
    _perCh4 = 100 * valueCh4 / totalSum;
    _perC2h4 = 100 * valueC2h4 / totalSum;
    _perC2h2 = 100 * valueC2h2 / totalSum;
    

    if (_perCh4 >= 98.0) {
      return "PD: Partial discharges";
    }
    if (_perC2h2 <= 4.0 && _perC2h4 <= 20) {
      return "T1: Thermal fault, T <300 °C";
    }
    if (_perC2h2 <= 4.0 && _perC2h4 > 20.0 && _perC2h4 <= 50) {
      return "T2: Thermal fault, 300 <T<700 °C";
    }
    if (_perC2h4 > 50 && _perC2h2 <= 15) {
      return "T3: Thermal fault, T >700 °C";
    }
    if (_perC2h2 >= 13.0 && _perC2h4 <= 23) {
      return "D1: Discharges of low energy";
    }
    if ((23.0 < _perC2h4 && _perC2h4 <= 40.0 && _perC2h2 >= 13.0) ||
        (_perC2h2 >= 29.0 && _perC2h4 > 40.0)) {
      return "D2: Discharges of high energy";
    }
    if ((_perC2h4 < 40 && _perC2h2 > 4 && _perC2h2 < 13) ||
        (_perC2h4 > 50 && _perC2h2 > 15 && _perC2h2 < 29) ||
        (_perC2h4 > 40 && _perC2h4 < 50 && _perC2h2 > 4 && _perC2h4 < 29)) {
      return "DT";
    }
    return "Dual Triangle fails to give comment";
  }
}
