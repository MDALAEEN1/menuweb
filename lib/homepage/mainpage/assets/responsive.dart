import 'package:flutter/material.dart';

class R {
  static const double mobile = 720;
  static const double tablet = 1100;

  static bool isMobile(double w) => w < mobile;
  static bool isTablet(double w) => w >= mobile && w < tablet;
  static bool isDesktop(double w) => w >= tablet;

  static double pagePad(double w) {
    if (isMobile(w)) return 16;
    if (isTablet(w)) return 32;
    return 80;
  }

  static double gap(double w) {
    if (isMobile(w)) return 14;
    if (isTablet(w)) return 20;
    return 28;
  }

  static double heroTitle(double w) {
    if (isMobile(w)) return 32;
    if (isTablet(w)) return 40;
    return 48;
  }

  static int gridCols(double w, {int max = 4}) {
    if (isMobile(w)) return 1;
    if (isTablet(w)) return 2;
    return max >= 3 ? 2 : 2; // لهالصفحة: خليها 2 على الديسكتوب (نفس تصميمك)
  }
}
