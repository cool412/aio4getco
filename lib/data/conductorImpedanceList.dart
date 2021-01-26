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
  return populateList;
}
