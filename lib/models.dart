part of 'responsive_ui.dart';

enum DEVICE_SIZE_TYPE { MOBILE, TABLET, DESKTOP, NONE }

class DeviceDetails {
  late DEVICE_SIZE_TYPE _deviceType;
  late double _height;
  late double _width;
  late double _designWidth;
  late double _designHeight;
  late double _scaleWidth;
  late double _scaleHeight;
  late Orientation _orientation;
  late bool _isAdaptFontOnWindows;
  late bool _isMobile;
  late bool _adaptWidthAndHeightOnWindows;


  set setAdaptWidthAndHeightOnWindows(bool isAdapt) => _adaptWidthAndHeightOnWindows = isAdapt;
  bool get isAdaptWidthAndHeightOnWindows => _adaptWidthAndHeightOnWindows;

  set setIsMobile(bool isMobile) => _isMobile = isMobile;
  bool get isMobile => _isMobile;

  set setAdaptFontOnWindows(bool isAdapt) => _isAdaptFontOnWindows = isAdapt;
  bool get isAdaptFontOnWindows => _isAdaptFontOnWindows;

  set setDeviceType(DEVICE_SIZE_TYPE deviceType) => _deviceType = deviceType;
  DEVICE_SIZE_TYPE get deviceType => _deviceType;

  set setHeight(double height) => _height = height;
  double get height => _height;

  set setWidth(double width) => _width = width;
  double get width => _width;

  set setDesignHeight(double designHeight) => _designHeight = designHeight;
  double get designHeight => _designHeight;

  set setDesignWidth(double designWidth) => _designWidth = designWidth;
  double get designWidth => _designWidth;

  set setScaleWidth(double scaleWidth) => _scaleWidth = scaleWidth;
  double get scaleWidth => _scaleWidth;

  set setScaleHeight(double scaleHeight) => _scaleHeight  = scaleHeight;
  double get scaleHeight => _scaleHeight;

  set setOrientation(Orientation orientation) => _orientation = orientation;
  Orientation get orientation => _orientation;

}