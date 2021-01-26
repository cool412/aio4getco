import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aio4getco/data/classFile.dart';

class AlstomScreen extends StatelessWidget {
  final AlstomDetails alstomDetails;
  const AlstomScreen(this.alstomDetails);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (new Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Relay Settings for P442/P444",style: TextStyle(fontSize: 20.0,fontStyle: FontStyle.italic),),
              SizedBox(height:10.0),
              Text("Zone-1 Settings"),
              displyAlstomSettings("Positive Sequence Impedance Z1", alstomDetails.z1.toStringAsFixed(3)),
              displyAlstomSettings("Fault Resistance (ph-ph) RZ1", alstomDetails.rZ1.toString()),
              displyAlstomSettings("Fault Resistance (ph-e)REZ1", alstomDetails.rEZ1.toString()),
              displyAlstomSettings("Zone Operate Time (ms)", alstomDetails.t1.toString()),
              SizedBox(height:5.0),
              Text("Zone-2 Settings"),
              displyAlstomSettings("Positive Sequence Impedance Z2", alstomDetails.z2.toStringAsFixed(3)),
              displyAlstomSettings("Fault Resistance (ph-ph) RZ2", alstomDetails.rZ2.toString()),
              displyAlstomSettings("Fault Resistance (ph-e)REZ2", alstomDetails.rEZ2.toString()),
              displyAlstomSettings("Zone Operate Time (ms)", alstomDetails.t2.toString()),
              SizedBox(height:5.0),
              Text("Zone-3 Settings"),
              displyAlstomSettings("Positive Sequence Impedance Z3", alstomDetails.z3.toStringAsFixed(3)),
              displyAlstomSettings("Fault Resistance (ph-ph) RZ3", alstomDetails.rZ3.toString()),
              displyAlstomSettings("Fault Resistance (ph-e)REZ3", alstomDetails.rEZ3.toString()),
              displyAlstomSettings("Zone Operate Time (ms)", alstomDetails.t3.toString()),
              SizedBox(height:5.0),
              Text("Zone-4 Settings"),
              displyAlstomSettings("Positive Sequence Impedance Z4", alstomDetails.z4.toStringAsFixed(3)),
              displyAlstomSettings("Fault Resistance (ph-ph) RZ4", alstomDetails.rZ4.toString()),
              displyAlstomSettings("Fault Resistance (ph-e)REZ4", alstomDetails.rEZ4.toString()),
              displyAlstomSettings("Zone Operate Time (ms)", alstomDetails.t4.toString()),
              SizedBox(height:5.0),
              Text("Residual E/F Compensation"),
              displyAlstomSettings("Magnitude", alstomDetails.residualCompMangnitude.toStringAsFixed(3)),
              displyAlstomSettings("Angle", alstomDetails.residualCompAngle.toStringAsFixed(3)),
              SizedBox(height: 5.0),
              Text("Line Parameters"),
              displyAlstomSettings("Line Length", alstomDetails.lineImpedance.toStringAsFixed(3)),
              displyAlstomSettings("Line Angle", alstomDetails.lineAngle.toStringAsFixed(3)),
            ],
          ),
        ),
      )),
    );
  }

   Widget displyAlstomSettings(String displayTag, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(displayTag),
            ),
            Text(" : "),
            Text(value)
          ],
        ),
      ],
    );
  }

}
