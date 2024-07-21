import 'dart:io';

import 'package:intellidesign/remainingarea.dart';

abstract class ResidentialArea {
  double frontSpace;
  double backSpace;
  double sideSpace;

  ResidentialArea(this.frontSpace, this.backSpace, this.sideSpace);

  double calculateRemainingArea(double width, double length) {
    double newWidth = width - (frontSpace + backSpace);
    double newLength = length - (sideSpace * 2);
    double remainingArea = newWidth * newLength;

    return remainingArea;
  }

  void printSpaces() {
    print('Front Space remaining: $frontSpace');
    print('Back Space remaining: $backSpace');
    print('Side Space remaining: $sideSpace');
  }
}

class ResidentialAreaA extends ResidentialArea {
  static const double uniqueFrontSpace = 5;
  static const double uniqueBackSpace = 5;
  static const double uniqueSideSpace = 4;

  ResidentialAreaA()
      : super(uniqueFrontSpace, uniqueBackSpace, uniqueSideSpace);
}

class ResidentialAreaB extends ResidentialArea {
  static const double uniqueFrontSpace = 4;
  static const double uniqueBackSpace = 4;
  static const double uniqueSideSpace = 3;

  ResidentialAreaB()
      : super(uniqueFrontSpace, uniqueBackSpace, uniqueSideSpace);
}

class ResidentialAreaC extends ResidentialArea {
  static const double uniqueFrontSpace = 3;
  static const double uniqueBackSpace = 3;
  static const double uniqueSideSpace = 2.5;

  ResidentialAreaC()
      : super(uniqueFrontSpace, uniqueBackSpace, uniqueSideSpace);
}

class ResidentialAreaD extends ResidentialArea {
  static const double uniqueFrontSpace = 3;
  static const double uniqueBackSpace = 2.5;
  static const double uniqueSideSpace = 2.5;

  ResidentialAreaD()
      : super(uniqueFrontSpace, uniqueBackSpace, uniqueSideSpace);
}

class AgriculturalResidentialArea extends ResidentialArea {
  static const double uniqueFrontSpace = 8;
  static const double uniqueBackSpace = 6;
  static const double uniqueSideSpace = 6;

  AgriculturalResidentialArea()
      : super(uniqueFrontSpace, uniqueBackSpace, uniqueSideSpace);
}

//countryside
class CountrysideResidentialArea extends ResidentialArea {
  static const double uniqueFrontSpace = 8;
  static const double uniqueBackSpace = 6;
  static const double uniqueSideSpace = 6;

  CountrysideResidentialArea()
      : super(uniqueFrontSpace, uniqueBackSpace, uniqueSideSpace);
}
