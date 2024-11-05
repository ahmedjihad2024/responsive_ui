

import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

class AdaptScreen extends StatelessWidget {
  final Widget Function(BuildContext context)? mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;
  const AdaptScreen({super.key, this.mobile, this.tablet, this.desktop});

  @override
  Widget build(BuildContext context) {
    if(deviceDetails.deviceType == DEVICE_SIZE_TYPE.MOBILE){
      return mobile?.call(context) ?? SizedBox.shrink();
    }else if(deviceDetails.deviceType == DEVICE_SIZE_TYPE.TABLET){
      return tablet?.call(context) ?? SizedBox.shrink();
    }else if(deviceDetails.deviceType == DEVICE_SIZE_TYPE.DESKTOP){
      return desktop?.call(context) ?? SizedBox.shrink();
    }else{
      return SizedBox.shrink();
    }
  }
}

class AdaptOrientation extends StatelessWidget {
  final Widget Function(BuildContext context)? mobilePort;
  final Widget Function(BuildContext context)? mobileLand;
  final Widget Function(BuildContext context)? tabletPort;
  final Widget Function(BuildContext context)? tabletLand;

  const AdaptOrientation({
    Key? key,
    this.mobilePort,
    this.mobileLand,
    this.tabletPort,
    this.tabletLand,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isMobile = deviceDetails.deviceType == DEVICE_SIZE_TYPE.MOBILE;
    final bool isTablet = deviceDetails.deviceType == DEVICE_SIZE_TYPE.TABLET;

    if (orientation == Orientation.portrait) {
      if (isTablet) {
        return (tabletPort ?? mobilePort)?.call(context) ?? const SizedBox.shrink();
      } else if (isMobile) {
        return mobilePort?.call(context) ?? const SizedBox.shrink();
      }
    } else {
      if (isTablet) {
        return (tabletLand ?? mobileLand)?.call(context) ?? const SizedBox.shrink();
      } else if (isMobile) {
        return mobileLand?.call(context) ?? const SizedBox.shrink();
      }
    }

    return const SizedBox.shrink();
  }
}