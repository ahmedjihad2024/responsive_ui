

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

class AdaptScreen extends StatelessWidget {
  final Widget Function(BuildContext context)? mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;
  final Widget Function(BuildContext context)? windows;

  const AdaptScreen({
    Key? key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.windows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows && windows != null) {
      return windows?.call(context) ?? const SizedBox.shrink();
    }

    // Adapt to device type for non-Windows platforms
    if (deviceDetails.deviceType == DEVICE_SIZE_TYPE.MOBILE) {
      return mobile?.call(context) ?? const SizedBox.shrink();
    } else if (deviceDetails.deviceType == DEVICE_SIZE_TYPE.TABLET) {
      return tablet?.call(context) ?? const SizedBox.shrink();
    } else if (deviceDetails.deviceType == DEVICE_SIZE_TYPE.DESKTOP) {
      return desktop?.call(context) ?? const SizedBox.shrink();
    } else {
      return const SizedBox.shrink();
    }
  }
}

class AdaptOrientation extends StatelessWidget {
  final Widget Function(BuildContext context)? mobilePort;
  final Widget Function(BuildContext context)? mobileLand;
  final Widget Function(BuildContext context)? tabletPort;
  final Widget Function(BuildContext context)? tabletLand;
  final Widget Function(BuildContext context)? desktopPort;
  final Widget Function(BuildContext context)? desktopLand;
  final Widget Function(BuildContext context)? windows;

  const AdaptOrientation({
    Key? key,
    this.mobilePort,
    this.mobileLand,
    this.tabletPort,
    this.tabletLand,
    this.desktopPort,
    this.desktopLand,
    this.windows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isWindows && windows != null) {
      return windows?.call(context) ?? const SizedBox.shrink();
    }

    // Determine device orientation and type
    final Orientation orientation = MediaQuery.of(context).orientation;
    final bool isMobile = deviceDetails.deviceType == DEVICE_SIZE_TYPE.MOBILE;
    final bool isTablet = deviceDetails.deviceType == DEVICE_SIZE_TYPE.TABLET;
    final bool isDesktop = deviceDetails.deviceType == DEVICE_SIZE_TYPE.DESKTOP;

    if (orientation == Orientation.portrait) {
      // Portrait Mode
      if (isDesktop) {
        return desktopPort?.call(context) ?? tabletPort?.call(context) ?? mobilePort?.call(context) ?? const SizedBox.shrink();
      } else if (isTablet) {
        return tabletPort?.call(context) ?? mobilePort?.call(context) ?? const SizedBox.shrink();
      } else if (isMobile) {
        return mobilePort?.call(context) ?? const SizedBox.shrink();
      }
    } else {
      // Landscape Mode
      if (isDesktop) {
        return desktopLand?.call(context) ?? tabletLand?.call(context) ?? mobileLand?.call(context) ?? const SizedBox.shrink();
      } else if (isTablet) {
        return tabletLand?.call(context) ?? mobileLand?.call(context) ?? const SizedBox.shrink();
      } else if (isMobile) {
        return mobileLand?.call(context) ?? const SizedBox.shrink();
      }
    }

    return const SizedBox.shrink();
  }
}