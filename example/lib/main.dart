
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        designWidth: 793,
        designHeight: 960,
        builder: (context, DeviceDetails details) {
          return MaterialApp(
            home: MyHomePage(),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AdaptiveAppBar()
      //     .setDeviceType(deviceDetails.deviceType)
      //     .build(context) as AppBar,
      body: AdaptiveOrientation<DynamicLogin>(
        orientation: deviceDetails.orientation,
        initWidgets: (context) {
          DynamicLogin dynamicLogin = DynamicLogin();
          var height = desktopSize(size(mobile: 45.h, tablet: 45.h), 40);
          var width = desktopSize(size(mobile: (310.w, 310.w), tablet: 230.w), 300);
          var fontSize = desktopSize(size(mobile: 22.sp, tablet: 20.sp), 16);
          var horizontalPadding = desktopSize(size(mobile: 10.w, tablet: 10.w,), 10);

          var emailForm = Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown.withOpacity(.5)),
            child: TextFormField(
              style: TextStyle(color: Colors.white, fontSize:fontSize),
              decoration: InputDecoration.collapsed(
                  hintText: "Email",
                  hintStyle: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontSize:fontSize)),
            ),
          );

          var passwordForm = Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.brown.withOpacity(.5)),
            child: TextFormField(
              style: TextStyle(color: Colors.white, fontSize:fontSize),
              decoration: InputDecoration.collapsed(
                  hintText: "Password",
                  hintStyle: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontSize:fontSize)),
            ),
          );

          var loginButton = TextButton(
              onPressed: () {},
              style: ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(
                      width,
                      height)),
                backgroundColor: const WidgetStatePropertyAll(Colors.brown),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ))
              ),
              child: Text(
                "Login",
                style: TextStyle(fontSize:fontSize, color: Colors.white),
              ));

          var title = Text("SHOP HAPPY", style: TextStyle(color: Colors.brown, fontSize: 34, fontWeight: FontWeight.bold),);

          dynamicLogin.emailForm = emailForm;
          dynamicLogin.passwordForm = passwordForm;
          dynamicLogin.loginButton = loginButton;
          dynamicLogin.title = title;

          return dynamicLogin;
        },
        landscape: (context, DynamicLogin? widgets) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widgets!.title,
                40.horizontalSpaceMax,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widgets.emailForm,
                    10.verticalSpaceMax,
                    widgets.passwordForm,
                    15.verticalSpaceMax,
                    widgets.loginButton
                  ],
                ),
              ],
            ),
          );
        },
        portrait: (context, DynamicLogin? widgets) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widgets!.title,
                40.verticalSpaceMax,
                widgets.emailForm,
                10.verticalSpaceMax,
                widgets.passwordForm,
                15.verticalSpaceMax,
                widgets.loginButton
              ],
            ),
          );
        },
      ),
    );
  }
}

// ---------

class DynamicLogin implements DynamicOrientation {
  late Widget passwordForm, emailForm, loginButton, title;
}

// ---------

class WindowAppBar implements AdaptiveWidget<BuildContext> {
  @override
  Widget build(BuildContext context, {BuildContext? data}) {
    return AppBar(
      title: Text("Windows"),
    );
  }
}

class MobileAppBar implements AdaptiveWidget<BuildContext> {
  @override
  Widget build(BuildContext context, {BuildContext? data}) {
    return AppBar(
      title: Text("Mobile"),
    );
  }
}

class TableAppBar implements AdaptiveWidget<BuildContext> {
  @override
  Widget build(BuildContext context, {BuildContext? data}) {
    return AppBar(
      title: Text("Tablet"),
    );
  }
}

class AdaptiveAppBar extends AdaptiveWidgetFactory<BuildContext> {
  AdaptiveWidgetFactory setDeviceType(DEVICE_SIZE_TYPE deviceType) {
    switch (deviceType) {
      case DEVICE_SIZE_TYPE.MOBILE:
        setAdaptiveWidget = MobileAppBar();
        break;
      case DEVICE_SIZE_TYPE.DESKTOP:
        setAdaptiveWidget = WindowAppBar();
        break;
      case DEVICE_SIZE_TYPE.TABLET:
        setAdaptiveWidget = TableAppBar();
        break;
      default:
        break;
    }
    return this;
  }

  @override
  Widget build(BuildContext context, {BuildContext? data}) =>
      super.build(context, data: data);
}
