part of "responsive_ui.dart";

extension ResponsiveSizes on num {
  double get w => this * deviceDetails.scaleWidth;
  double get wMin => max(toDouble(), w);
  double get wp => this * deviceDetails.width;
  // double wBetween(double value) => w.clamp(toDouble(), value);

  double get h => this * deviceDetails.scaleHeight;
  double get hMin => max(toDouble(), h);
  double get hp => this * deviceDetails.height;
  // double hBetween(double value) => h.clamp(toDouble(), value);

  // for the fonts scale
  /*
  this *
      min(deviceDetails.scaleWidth,
          deviceDetails.scaleHeight)
  */
  double get spAdapt =>
      this * (0.6 * deviceDetails.scaleHeight + 0.4 * deviceDetails.scaleWidth) ;

  // double get spAdaptMin => min(toDouble(), spAdapt);

  double get spAdaptMin =>  max(toDouble(), spAdapt);

  // for the font
  double get sp => this * (deviceDetails.scaleWidth + deviceDetails.scaleHeight)/ 1.4 ;
  // double get sp2 => this * deviceDetails.scaleWidth;

  // double get spMin => min(toDouble(), sp);

  double get spMin =>  max(toDouble(), sp) ;

  // double spBetween(double value) => sp.clamp(toDouble(), value);

  // for radius scale
  double get r =>
      this *
      min(deviceDetails.scaleWidth,
          deviceDetails.scaleHeight);
  // double rBetween(double value) => r.clamp(toDouble(), value);

  SizedBox get verticalSpace => SizedBox(height: h);
  SizedBox get verticalSpaceMax => SizedBox(height: min(toDouble(), h));
  SizedBox get verticalSpaceMin => SizedBox(height: max(toDouble(), h));

  SizedBox get horizontalSpace => SizedBox(width: w);
  SizedBox get horizontalSpaceMax => SizedBox(width: min(toDouble(), w));
  SizedBox get horizontalSpaceMin => SizedBox(width: max(toDouble(), w));

  // Adapt according to the both width and height
  double get diagonal => this * deviceDetails.scaleWidth * deviceDetails.scaleHeight;
  // Adapt according to the maximum value of scale width and scale height
  double get diameter => this * max(deviceDetails.scaleWidth , deviceDetails.scaleHeight);

}

extension handle on dynamic{
  T apply<T>(T Function(dynamic it) callback) => callback(this);
}
