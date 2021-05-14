import 'dart:convert';

/* All for Conductor data. */
/* Fisr is for Static data stored in application */

class ConductorImpedance {
  String nameConductor;
  double rP, xP, zP, r0, x0, z0, zPAngle, z0Angle;

  ConductorImpedance(this.nameConductor, this.rP, this.xP, this.zP, this.r0,
      this.x0, this.z0, this.zPAngle, this.z0Angle);
}

List<ConductorImpedance> initiateConductorData() {
  List<ConductorImpedance> populateList = [];
  populateList.add(ConductorImpedance("66kV ACSR Dog(S/C)", 0.162, 0.3861,
      0.4188, 0.498, 1.4, 1.4859, 67.211, 70.42));
  populateList.add(ConductorImpedance("66kV ACSR Panther(S/C)", 0.0406, 0.09652,
      0.1047, 0.1014, 0.4055, 0.418, 67.211, 75.96));
  populateList.add(ConductorImpedance("132kV ACSR Panther(S/C)", 0.1622, 0.3861,
      0.4188, 0.4056, 1.6221, 1.6721, 67.211, 75.96));
  populateList.add(ConductorImpedance("220kV AAAC Zebra(S/C)", 0.0749, 0.3992,
      0.4062, 0.2199, 1.339, 1.3571, 79.387, 80.672));
  populateList.add(ConductorImpedance("220kV ACSR Zebra(S/C)", 0.0697, 0.3978,
      0.4039, 0.20478, 1.3343, 1.35, 80.063, 81.275));
  populateList.add(ConductorImpedance("220kV ACSR Single Moose(S/C)", 0.0749,
      0.3992, 0.4062, 0.2199, 1.339, 1.3571, 79.378, 80.672));
  populateList.add(ConductorImpedance("220kV ACSR Twin Moose(S/C)", 0.056,
      0.372, 0.3761, 0.286, 1.029, 1.068, 81.439, 74.467));
  populateList.add(ConductorImpedance("400kV ACSR Twin Moose(S/C)", 0.0298,
      0.332, 0.3333, 0.16192, 1.24, 1.2505, 84.872, 82.56));
  populateList.add(ConductorImpedance("400kV ACSR Twin Moose(D/C)", 0.0288,
      0.30768, 0.309, 0.26752, 1.07376, 1.1065, 84.652, 76.009));
  populateList.add(ConductorImpedance("400kV AAAC Twin Moose(S/C)", 0.0309,
      0.3304, 0.3318, 0.16816, 1.2368, 1.2481, 84.649, 82.257));
  populateList.add(ConductorImpedance("400kV ACSR Zebra Triple(S/C)", 0.0224,
      0.2992, 0.3, 12.1856, 1.11184, 12.2362, 85.715, 5.213));
  populateList.add(ConductorImpedance("400kV ACSR Zebra Quad(S/C)", 0.0168,
      0.2544, 0.2549, 9.1328, 0.9504, 9.1821, 86.221, 5.941));
  populateList.add(ConductorImpedance("400kV ACSR Moose Quad(S/C)", 0.0147,
      0.2528, 0.2532, 0.248, 1, 1.0302, 86.679, 76.071));
  populateList.add(ConductorImpedance("400kV ACSR Moose Quad(D/C)", 0.0147,
      0.25312, 0.2535, 0.24912, 0.99936, 1.0299, 86.68, 76.002));
  populateList.add(ConductorImpedance("400kV AAAC Moose Equ. Quad(S/C)", 0.0157,
      0.26816, 0.2686, 8.512, 1.0016, 8.5707, 6.656, 6.711));
  populateList.add(ConductorImpedance("400kV Triple AC Snow Bird", 0.01952,
      0.256, 0.2567, 0.2, 0.8624, 0.8852, 85.639, 76.943));
  populateList.add(ConductorImpedance("220kV Deer Conductor", 0.08002, 0.4008,
      0.4087, 0.229, 1.23, 1.2511, 78.709, 79.453));
  populateList.add(ConductorImpedance("132kV Underground Cable", 0.0495, 0.128,
      0.137, 0.08, 0.073, 0.108, 68, 42));
  populateList.add(ConductorImpedance("220kV Underground Cable(1200 mm2)", 0.02,
      0.13, 0.132, 0.062, 0.77, 0.772, 81.25, 85.39));
  populateList.add(ConductorImpedance("220kV Underground Cable(400/550 mm2)",
      0.0615, 0.157, 0.168, 0.12, 0.1, 0.156, 68.6, 39.8));
  populateList.add(ConductorImpedance("220kV AL 59 Equivalent to Moose", 0.066,
      0.399, 0.404, 0.198, 1.339, 1.35, 80.6, 81.58));
  return populateList;
}

/* Below class is for saving data to sqlite database. */

ConductorSqliteData clientFromJson(String str) {
  final jsonData = json.decode(str);
  return ConductorSqliteData.fromMap(jsonData);
}

String clientToJson(ConductorSqliteData data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class ConductorSqliteData {
  int id;
  String nameConuctor,
      positiveSequenceResistance,
      zeroSequenceResistance,
      positiveSequenceReactance,
      zeroSequenceReactance,
      positiveSequenceImpedance,
      zeroSequenceImpedance,
      positiveSequenceAngle,
      zeroSequenceAngle;

  ConductorSqliteData(
      {this.id,
      this.nameConuctor,
      this.positiveSequenceResistance,
      this.positiveSequenceReactance,
      this.positiveSequenceImpedance,
      this.positiveSequenceAngle,
      this.zeroSequenceResistance,
      this.zeroSequenceReactance,
      this.zeroSequenceImpedance,
      this.zeroSequenceAngle});

  factory ConductorSqliteData.fromMap(Map<String, dynamic> json) =>
      new ConductorSqliteData(
        id: json["id"],
        nameConuctor: json["conductor_name"],
        positiveSequenceResistance: json["positiveSequenceResistance"],
        positiveSequenceReactance: json["positiveSequenceReactance"],
        positiveSequenceImpedance: json["positiveSequenceImpedance"],
        positiveSequenceAngle: json["positiveSequenceAngle"],
        zeroSequenceResistance: json["zeroSequenceResistance"],
        zeroSequenceReactance: json["zeroSequenceReactance"],
        zeroSequenceImpedance: json["zeroSequenceImpedance"],
        zeroSequenceAngle: json["zeroSequenceAngle"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "conductor_name": nameConuctor,
        "positiveSequenceResistance": positiveSequenceResistance,
        "positiveSequenceReactance": positiveSequenceReactance,
        "positiveSequenceImpedance": positiveSequenceImpedance,
        "positiveSequenceAngle": positiveSequenceAngle,
        "zeroSequenceResistance": zeroSequenceResistance,
        "zeroSequenceReactance": zeroSequenceReactance,
        "zeroSequenceImpedance": zeroSequenceImpedance,
        "zeroSequenceAngle": zeroSequenceAngle,
      };
}

/* Below code is for characteristics curve */

class CurveClass {
  String typeCurve;
  double kValue, cValue, aValue, pValue;

  CurveClass(
      this.typeCurve, this.kValue, this.cValue, this.aValue, this.pValue);
}

List<CurveClass> initiateCurveData() {
  List<CurveClass> populateList = [];
  populateList
      .add(CurveClass("IEC Standard Inverse Time (SI)", 0.14, 0, 0.02, 1));
  populateList.add(CurveClass("IEC Very Inverse Time (VI)", 13.5, 0, 1, 1));
  populateList.add(CurveClass("IEC Extremely Inverse Time (EI)", 80, 0, 2, 1));
  populateList.add(CurveClass("IEC Long Time Inverse", 120, 0, 1, 1));
  populateList.add(CurveClass(
      "IEEE Moderately Invertime Time (MI)", 0.0515, 0.114, 0.02, 1));
  populateList
      .add(CurveClass("IEEE Very Inverse Time (VI)", 19.61, 0.491, 2, 1));
  populateList
      .add(CurveClass("IEEE Extremely Inverse Time (EI)", 28.2, 0.1217, 2, 1));
  populateList.add(CurveClass("US Time Inverse (CO8)", 5.95, 0.18, 2, 1));
  populateList.add(
      CurveClass("US Short Time Inverse (CO2 P20)", 0.02394, 0.01694, 0.02, 1));
  populateList.add(
      CurveClass("US Short Time Inverse (CO2 P40)", 0.16758, 0.11858, 0.02, 1));
  populateList.add(CurveClass("RI", -4.2373, 0, 1, 1.43644));

  return populateList;
}
