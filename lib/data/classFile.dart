import 'package:aio4getco/data/conductorImpedanceList.dart';

class ZoneImpedances {
  int zoneNumber, zoneTime;
  double r1Final, x1Final, z1Final, r0Final, x0Final, z0Final;
  int rPh2Ph, rPh2E;
  ZoneImpedances(
      this.zoneNumber,
      this.r1Final,
      this.x1Final,
      this.z1Final,
      this.r0Final,
      this.x0Final,
      this.z0Final,
      this.rPh2Ph,
      this.rPh2E,
      this.zoneTime);
}

class LineImpedance {
  double r1Line, x1Line, z1Line, r0Line, x0Line, z0Line;
  LineImpedance(this.r1Line, this.x1Line, this.z1Line, this.r0Line, this.x0Line,
      this.z0Line);
  LineImpedance add(LineImpedance temp) {
    temp.r1Line = temp.r1Line + this.r1Line;
    temp.r0Line = temp.r0Line + this.r0Line;
    temp.x1Line = temp.x1Line + this.x1Line;
    temp.x0Line = temp.x0Line + this.x0Line;
    temp.z0Line = temp.z0Line + this.z0Line;
    temp.z1Line = temp.z1Line + this.z1Line;
    return temp;
  }
}

class Details {
  double _voltage,
      _maxPower,
      _ctrPTR,
      _localFault,
      _remoteFault,
      _lineLength,
      _nextShortest,
      _nextLongest,
      _shortestLine,
      _zone2Multi;
  ConductorImpedance _lineParameters,
      _nextLongestParameters,
      _nextShortestParameter,
      _shortestParameter;
  Details(
      this._voltage,
      this._maxPower,
      this._ctrPTR,
      this._localFault,
      this._remoteFault,
      this._lineLength,
      this._lineParameters,
      this._nextLongest,
      this._nextLongestParameters,
      this._nextShortest,
      this._nextShortestParameter,
      this._shortestLine,
      this._shortestParameter,
      this._zone2Multi);
  double getCtPtRatio() {
    return _ctrPTR;
  }

  double getLineLength() {
    return _lineLength;
  }

  double getNextLongestLineLength() {
    return _nextLongest;
  }

  double getNextShortestLineLength() {
    return _nextShortest;
  }

  double getShortestLineLength() {
    return _shortestLine;
  }

  double getZoneMultiplier() {
    return _zone2Multi;
  }

  ConductorImpedance getLineParameter() {
    return _lineParameters;
  }

  ConductorImpedance getNextLongestParameter() {
    return _nextLongestParameters;
  }

  ConductorImpedance getNextShortestParameter() {
    return _nextShortestParameter;
  }

  ConductorImpedance getShortestParameter() {
    return _shortestParameter;
  }
}

class AlstomDetails {
  double lineImpedance,
      lineAngle,
      residualCompMangnitude,
      residualCompAngle,
      deltaR,
      deltaX,
      z1,
      rZ1,
      rEZ1,
      t1,
      z2,
      rZ2,
      rEZ2,
      t2,
      z3,
      rZ3,
      rEZ3,
      t3,
      z4,
      rZ4,
      rEZ4,
      t4;
  AlstomDetails(
      this.lineImpedance,
      this.lineAngle,
      this.residualCompMangnitude,
      this.residualCompAngle,
      this.deltaR,
      this.deltaX,
      this.z1,
      this.rZ1,
      this.rEZ1,
      this.t1,
      this.z2,
      this.rZ2,
      this.rEZ2,
      this.t2,
      this.z3,
      this.rZ3,
      this.rEZ3,
      this.t3,
      this.z4,
      this.rZ4,
      this.rEZ4,
      this.t4);
}

class SiemensDetails {
  double lineLength,
      siemensX,
      ratioReRl,
      ratioXeXl,
      lineAngle,
      xZ1,
      rZ1,
      rEZ1,
      t1,
      xZ2,
      rZ2,
      rEZ2,
      t2,
      xZ3,
      rZ3,
      rEZ3,
      t3,
      xZ4,
      rZ4,
      rEZ4,
      t4;
  SiemensDetails(
      this.lineLength,
      this.lineAngle,
      this.siemensX,
      this.ratioReRl,
      this.ratioXeXl,
      this.xZ1,
      this.rZ1,
      this.rEZ1,
      this.t1,
      this.xZ2,
      this.rZ2,
      this.rEZ2,
      this.t2,
      this.xZ3,
      this.rZ3,
      this.rEZ3,
      this.t3,
      this.xZ4,
      this.rZ4,
      this.rEZ4,
      this.t4);
}

class DGDetails {
  double _h2, _o2, _n2, _ch4, _c2h4, _c2h6, _c2h2, _c3h6c3h8, _co2, _co;
  DGDetails(this._h2, this._o2, this._n2, this._ch4, this._c2h4, this._c2h6,
      this._c2h2, this._c3h6c3h8, this._co2, this._co);
  double getHydrogen() {
    return _h2;
  }

  double hetOxygen() {
    return _o2;
  }

  double getNitrogen() {
    return _n2;
  }

  double getMythen() {
    return _ch4;
  }

  double getC2h4() {
    return _c2h4;
  }

  double getC2h6() {
    return _c2h6;
  }

  double getc2h2() {
    return _c2h2;
  }

  double getC3h6C3h8() {
    return _c3h6c3h8;
  }

  double getCo2() {
    return _co2;
  }

  double getCo() {
    return _co;
  }
}
