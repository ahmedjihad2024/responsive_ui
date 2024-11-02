library responsive_ui;

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'models.dart';

part 'extensions.dart';

part 'dynamic/adaptive_size.dart';

part 'dynamic/adaptive_widget.dart';

part 'dynamic/dynamic_orientation.dart';

// scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
// navigatorKey = GlobalKey<NavigatorState>();

final DeviceDetails deviceDetails = DeviceDetails();
late GlobalKey<NavigatorState> navigatorKey;
late GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
late NavigatorState? navigator;

class ResponsiveLayout extends StatefulWidget {
  final Widget Function(BuildContext context, DeviceDetails info) builder;
  final double? _designWidth;
  final double? _designHeight;
  final bool _splitScreenMode;

  const ResponsiveLayout._internal(
      {super.key,
      required this.builder,
      required double? designWidth,
      required double? designHeight,
      required bool splitScreenMode,})
      : _designWidth = designWidth,
        _designHeight = designHeight,
        _splitScreenMode = splitScreenMode;

  static ResponsiveLayout _instance(
          {key,
          required Widget Function(BuildContext context, DeviceDetails info)
              builder,
          required double? designWidth,
          required double? designHeight,
          required bool splitScreenMode,}) =>
      ResponsiveLayout._internal(
        key: key,
        builder: builder,
        designWidth: designWidth,
        designHeight: designHeight,
        splitScreenMode: splitScreenMode,
      );

  factory ResponsiveLayout(
          {key,
          required Widget Function(BuildContext context, DeviceDetails info)
              builder,
          double? designWidth,
          double? designHeight,
          bool splitScreenMode = false,}) =>
      _instance(
          key: key,
          builder: builder,
          designWidth: designWidth,
          designHeight: designHeight,
          splitScreenMode: splitScreenMode);

  @override
  State<StatefulWidget> createState() => _ResponsiveLayoutState(builder, _designWidth, _designHeight, _splitScreenMode);
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  final Widget Function(BuildContext context, DeviceDetails info) builder;
  final double? _designWidth;
  final double? _designHeight;
  final bool _splitScreenMode;

  _ResponsiveLayoutState(this.builder, this._designWidth, this._designHeight,
      this._splitScreenMode);

  @override
  void initState() {
    scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
    navigatorKey = GlobalKey<NavigatorState>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TargetPlatform platform = Theme
        .of(context)
        .platform;
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          Size size = Size(constraints.maxWidth, constraints.maxHeight);
          // var size =
          //     WidgetsBinding.instance.platformDispatcher.views.first.physicalSize /
          //         WidgetsBinding
          //             .instance.platformDispatcher.views.first.devicePixelRatio;
          // final Orientation orientation = size.width > size.height ? Orientation.landscape : Orientation.portrait;

          final isMobile =
              platform == TargetPlatform.android || platform == TargetPlatform.iOS;

          var deviceType = _deviceType(
            width: isMobile
                ? orientation == Orientation.landscape
                ? size.height
                : size.width
                : size.width,
            orientation: orientation,
          );

          /// check if size of other platforms is mobile then
          /// deals like a mobile
          var isMobile2 = ((platform != TargetPlatform.iOS &&
              platform != TargetPlatform.android) &&
              (kIsWeb && deviceType != DEVICE_SIZE_TYPE.DESKTOP));

          final originalWidth = isMobile || isMobile2
              ? orientation == Orientation.landscape
              ? size.height
              : size.width
              : size.width;

          final originalHeight = isMobile || isMobile2
              ? orientation == Orientation.landscape
              ? size.width
              : size.height
              : size.height;


          deviceDetails
            ..setOrientation = orientation
            ..setHeight = originalHeight
            ..setWidth = originalWidth
            ..setDesignHeight = _designHeight ?? deviceDetails.height
            ..setDesignWidth = _designWidth ?? deviceDetails.width
            ..setScaleWidth = deviceDetails.width / deviceDetails.designWidth
            ..setScaleHeight = (_splitScreenMode
                ? max(deviceDetails.height, 700)
                : deviceDetails.height) /
                deviceDetails.designHeight
            ..setDeviceType = deviceType
            ..setIsMobile = isMobile;

          Widget widget = builder(context, deviceDetails);
          if (widget is MaterialApp) {
            if (widget.scaffoldMessengerKey != null)
              scaffoldMessengerKey = widget.scaffoldMessengerKey!;
            if (widget.navigatorKey != null) navigatorKey = widget.navigatorKey!;
            var r = ReCreateApp.materialApp(
                widget, navigatorKey, scaffoldMessengerKey);
            navigator = navigatorKey.currentState;
            return r;
          } else if (widget is CupertinoApp) {
            if (widget.navigatorKey != null) navigatorKey = widget.navigatorKey!;
            var r = ReCreateApp.cupertinoApp(widget, navigatorKey);
            navigator = navigatorKey.currentState;
            return r;
          } else {
            return widget;
          }
        });
      }
    );
  }

  DEVICE_SIZE_TYPE _deviceType(
      {required double width, required Orientation orientation}) {
    return switch (width) {
      >= 1100 => DEVICE_SIZE_TYPE.DESKTOP,
      >= 650 => DEVICE_SIZE_TYPE.TABLET,
      < 650 => DEVICE_SIZE_TYPE.MOBILE,
      _ => DEVICE_SIZE_TYPE.NONE
    };
  }

}


class ReCreateApp {
  static MaterialApp materialApp(MaterialApp old,
      GlobalKey<NavigatorState> NewNavigatorKey,
      GlobalKey<ScaffoldMessengerState> newScaffoldMessengerKey) {
    var scaffoldMessengerKey =
        old.scaffoldMessengerKey ?? newScaffoldMessengerKey;
    var navigatorKey = old.navigatorKey ?? NewNavigatorKey;
    MaterialApp materialApp = MaterialApp(
      key: old.key,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: old.home,
      routes: old.routes ?? const <String, WidgetBuilder>{},
      initialRoute: old.initialRoute,
      onGenerateRoute: old.onGenerateRoute,
      onGenerateInitialRoutes: old.onGenerateInitialRoutes,
      onUnknownRoute: old.onUnknownRoute,
      onNavigationNotification: old.onNavigationNotification,
      navigatorObservers: old.navigatorObservers ?? const <NavigatorObserver>[],
      builder: old.builder,
      title: old.title,
      onGenerateTitle: old.onGenerateTitle,
      color: old.color,
      theme: old.theme,
      darkTheme: old.darkTheme,
      highContrastTheme: old.highContrastTheme,
      highContrastDarkTheme: old.highContrastDarkTheme,
      themeMode: old.themeMode,
      themeAnimationDuration: old.themeAnimationDuration,
      themeAnimationCurve: old.themeAnimationCurve,
      locale: old.locale,
      localizationsDelegates: old.localizationsDelegates,
      localeListResolutionCallback: old.localeListResolutionCallback,
      localeResolutionCallback: old.localeResolutionCallback,
      supportedLocales: old.supportedLocales,
      debugShowMaterialGrid: old.debugShowMaterialGrid,
      showPerformanceOverlay: old.showPerformanceOverlay,
      checkerboardRasterCacheImages: old.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: old.checkerboardOffscreenLayers,
      showSemanticsDebugger: old.showSemanticsDebugger,
      debugShowCheckedModeBanner: old.debugShowCheckedModeBanner,
      shortcuts: old.shortcuts,
      actions: old.actions,
      restorationScopeId: old.restorationScopeId,
      scrollBehavior: old.scrollBehavior,
      themeAnimationStyle: old.themeAnimationStyle,
    );
    return materialApp;
  }

  static CupertinoApp cupertinoApp(CupertinoApp old,
      GlobalKey<NavigatorState> NewNavigatorKey) {
    var navigatorKey = old.navigatorKey ?? NewNavigatorKey;
    CupertinoApp cupertinoApp = CupertinoApp(
      key: old.key,
      navigatorKey: navigatorKey,
      home: old.home,
      routes: old.routes ?? const <String, WidgetBuilder>{},
      initialRoute: old.initialRoute,
      onGenerateRoute: old.onGenerateRoute,
      onGenerateInitialRoutes: old.onGenerateInitialRoutes,
      onUnknownRoute: old.onUnknownRoute,
      onNavigationNotification: old.onNavigationNotification,
      navigatorObservers: old.navigatorObservers ?? const <NavigatorObserver>[],
      builder: old.builder,
      title: old.title,
      onGenerateTitle: old.onGenerateTitle,
      color: old.color,
      theme: old.theme,
      locale: old.locale,
      localizationsDelegates: old.localizationsDelegates,
      localeListResolutionCallback: old.localeListResolutionCallback,
      localeResolutionCallback: old.localeResolutionCallback,
      supportedLocales: old.supportedLocales,
      showPerformanceOverlay: old.showPerformanceOverlay,
      checkerboardRasterCacheImages: old.checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: old.checkerboardOffscreenLayers,
      showSemanticsDebugger: old.showSemanticsDebugger,
      debugShowCheckedModeBanner: old.debugShowCheckedModeBanner,
      shortcuts: old.shortcuts,
      actions: old.actions,
      restorationScopeId: old.restorationScopeId,
      scrollBehavior: old.scrollBehavior,
    );
    return cupertinoApp;
  }
}
