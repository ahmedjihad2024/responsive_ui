
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_ui/responsive_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello", style: TextStyle(fontSize: 16.sp),),
      )
    );
  }
}
