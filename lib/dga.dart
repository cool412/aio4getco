import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DGanalysisScreen extends StatefulWidget {
  @override
  _DGanalysisState createState() => _DGanalysisState();
}

class _DGanalysisState extends State<DGanalysisScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /*var h2Controller = TextEditingController();
  var o2Controller = TextEditingController();
  var n2Controller = TextEditingController();
  var ch4Controller = TextEditingController();
  var c2h4Controller = TextEditingController();
  var c2h6Controller = TextEditingController();
  var c2h2Controller = TextEditingController();
  var c3h6c3h8Controller = TextEditingController();
  var co2Controller = TextEditingController();
  var coController = TextEditingController();*/
  final _h2Text = 'Hydrogen(H2)';
  final _o2Text = 'Oxygen(O2)';
  final _n2Text = 'Nitrogen(N2)';
  final _ch4Text = 'Methane(CH4)';
  final _c2h4Text = 'Ethylene(C2H4)';
  final _c2h6Text = 'Ethane(C2H6)';
  final _c2h2Text = 'Acetylene(C2H2)';
  final _c3h6c3h8Text = 'Propylene + Propane(C3H6 + C3H8)';
  final _co2Text = 'Carbon Dioxide(CO2)';
  final _coText = 'Carbon Monoxide(CO)';
  int _h2Input,
      _o2Input,
      _n2Input,
      _ch4Input,
      _c2h4Input,
      _c2h6Input,
      _c3h6c3h8Input,
      _co2Input,
      _coInput,
      _c2h2Input;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("DG Analysis"),
      ),
      body: Container(
        padding: EdgeInsets.only(left:15.0,right: 15.0,bottom: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10.0,),
                buildh2Field(),
                SizedBox(
                  height: 5.0,
                ),
                buildo2Field(),
                SizedBox(
                  height: 5.0,
                ),
                buildn2Field(),
                SizedBox(
                  height: 5.0,
                ),
                buildch4Field(),
                SizedBox(
                  height: 5.0,
                ),
                buildc2h4Field(),
                SizedBox(
                  height: 5.0,
                ),
                buildc2h6Field(),
                SizedBox(
                  height: 5.0,
                ),
                buildc2h2Field(),
                SizedBox(
                  height: 5.0,
                ),
                buildc3h6c3h8Field(),
                SizedBox(
                  height: 5.0,
                ),
                buildco2Field(),
                SizedBox(
                  height: 5.0,
                ),
                buildcoField(),
                SizedBox(
                  height: 5.0,
                ),
                buildButtonContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildh2Field() {
    return TextFormField(
      //controller: h2Controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        int test = int.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _h2Input = int.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _h2Text,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildo2Field() {
    return TextFormField(
      //controller: o2Controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        int test = int.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _o2Input = int.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _o2Text,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildn2Field() {
    return TextFormField(
      //controller: n2Controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        int test = int.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _n2Input = int.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _n2Text,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildch4Field() {
    return TextFormField(
      //controller: ch4Controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        int test = int.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _ch4Input = int.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _ch4Text,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildc2h4Field() {
    return TextFormField(
      //controller: c2h4Controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        int test = int.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _c2h4Input = int.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _c2h4Text,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildc2h6Field() {
    return TextFormField(
      //controller: c2h6Controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        int test = int.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _c2h6Input = int.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _c2h6Text,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildc2h2Field() {
    return TextFormField(
      //controller: c2h2Controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        int test = int.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _c2h2Input = int.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _c2h2Text,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildc3h6c3h8Field() {
    return TextFormField(
      //controller: c3h6c3h8Controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        int test = int.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _c3h6c3h8Input = int.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _c3h6c3h8Text,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildco2Field() {
    return TextFormField(
      //controller: co2Controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        int test = int.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _co2Input = int.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _co2Text,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget buildcoField() {
    return TextFormField(
      //controller: coController,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Field can not be empty';
        }
        int test = int.tryParse(value);
        if (test == null || test <= 0) {
          return 'Entered value is invalid';
        }
        return null;
      },
      onSaved: (value) {
        _coInput = int.tryParse(value);
      },
      decoration: InputDecoration(
        labelText: _coText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        //prefixIcon: Icon(Icons.email),
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
          print(_h2Input);
          print(_o2Input);
          print(_n2Input);
          print(_ch4Input);
          print(_c2h4Input);
          print(_c2h6Input);
          print(_c2h2Input);
          print(_c3h6c3h8Input);
          print(_co2Input);
          print(_coInput);
          //_onButtonPressed();
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
