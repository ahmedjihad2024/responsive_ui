part of '../responsive_ui.dart';

/// desktop attribute it is the web too but when web screen in the size of desktop
double size({Object? mobile, Object? tablet, Object? desktop}) {
  return switch (deviceDetails.deviceType) {
    DEVICE_SIZE_TYPE.MOBILE => (mobile ?? tablet ?? desktop!).apply<double>(
        (it) => it is (num, num)
            ? orientationSize(it.$1.toDouble(), it.$2.toDouble())
            : it),
    DEVICE_SIZE_TYPE.TABLET => (tablet ?? mobile ?? desktop!).apply<double>(
        (it) => it is (num, num)
            ? orientationSize(it.$1.toDouble(), it.$2.toDouble())
            : it),
    DEVICE_SIZE_TYPE.DESKTOP => (desktop ?? tablet ?? mobile!).apply<double>(
        (it) => it is (num, num)
            ? orientationSize(it.$1.toDouble(), it.$2.toDouble())
            : it),
    _ => 0
  };
}

double desktopSize(double other, double desktop) {
  if (TargetPlatform.values
      .sublist(3, 6)
      .contains(deviceDetails.targetPlatform)) {
    if(kIsWeb){
      if(deviceDetails.deviceType == DEVICE_SIZE_TYPE.DESKTOP){
        return desktop;
      }else{
        return other;
      }
    }else{
      return desktop;
    }
  }else {
    return other;
  }
}

double orientationSize(double portrait, double landscape) {
  return deviceDetails.orientation == Orientation.landscape
      ? landscape
      : portrait;
}
