import 'package:aio4getco/advanceImpedance.dart';
import 'package:aio4getco/idmtCalc.dart';
import 'package:aio4getco/listCondParameters.dart';
import 'package:aio4getco/refCalc.dart';
import 'package:flutter/material.dart';
import 'dga.dart';
import 'impedance.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AIO4GETCO',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'AIO 4 GETCO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String impedaceCalc = "Impedance Calculation";
  static const String dgaAnalysis = "DGA";
  static const String refCalc = "REF Calculation";
  static const String idmtCalc = "IDMT Calulation";
  static const String listCondImp = "Conductor Impedance";
  static const String advanceImpCalc = "Advance Impe. Calc.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              buildButtonContainer(impedaceCalc),
              SizedBox(
                height: 5.0,
              ),
              buildButtonContainer(advanceImpCalc),
              SizedBox(
                height: 5.0,
              ),
              buildButtonContainer(dgaAnalysis),
              SizedBox(
                height: 5.0,
              ),
              buildButtonContainer(refCalc),
              SizedBox(
                height: 5.0,
              ),
              buildButtonContainer(idmtCalc),
              SizedBox(
                height: 5.0,
              ),
              buildButtonContainer(listCondImp),
              SizedBox(
                height: 5.0,
              ),
              /* GridView.count(
                crossAxisCount: 2,
                primary: false,
                padding: const EdgeInsets.all(20.0),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                children: [
                  gridButton('assets/omega.png', impedaceCalc),
                  gridButton('assets/dgaicon.png', dgaAnalysis),
                  gridButton('assets/ref.png', refCalc),
                  gridButton('assets/ref.png', idmtCalc),
                  gridButton('assets/ref.png', listCondImp),
                ],
              ) */
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget gridButton(String imageURL, String displayText) {
    return RaisedButton(
      color: Colors.white,
      elevation: 5.0,
      onPressed: () {
        _pushToNextActivity(displayText);
        //print('Button presses');
      },
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(imageURL),
            height: 100.0,
            width: 100.0,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            displayText,
            style: TextStyle(color: Colors.blue, fontSize: 17.0),
          )
        ],
      ),
    );
  }

  Widget buildButtonContainer(String displayText) {
    return ButtonBar(children: <Widget>[
      (RaisedButton(
        color: Colors.white,
        elevation: 5.0,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0),
        ),
        onPressed: () {
          _pushToNextActivity(displayText);
        },
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              displayText,
              style: TextStyle(color: Colors.teal, fontSize: 20.0),
            ),
          ),
        ),
      ))
    ]);
  }

  void _pushToNextActivity(String selection) {
    switch (selection) {
      case impedaceCalc:
        {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => ImpedanceScreen()));
        }
        break;
      case advanceImpCalc:
        {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => AdvanceImpedanceScreen()));
        }
        break;
      case dgaAnalysis:
        {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => DGanalysisScreen()));
        }
        break;
      case refCalc:
        {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => RefCalcScreen()));
        }
        break;
      case idmtCalc:
        {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => IDMTScreen()));
        }
        break;
      case listCondImp:
        {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => ListCondParaScreen()));
        }
        break;
    }
  }
}
