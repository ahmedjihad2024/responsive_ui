part of '../responsive_ui.dart';

abstract class AdaptiveWidget<Type> {
  Widget build(BuildContext context, {Type? data});
}

abstract class AdaptiveWidgetFactory<Type> implements AdaptiveWidget<Type> {
  late AdaptiveWidget<Type> _adaptiveWidget;

  set setAdaptiveWidget(AdaptiveWidget<Type> adaptiveWidget) =>
      _adaptiveWidget = adaptiveWidget;

  Widget build(BuildContext context, {Type? data}) =>
      _adaptiveWidget.build(context, data: data);
}

/// when i want to specific a widget for the windows only
/// it will just show on windows
class AdaptiveDesktop extends StatelessWidget {
  final Widget Function(BuildContext) other, desktop;

  const AdaptiveDesktop(
      {super.key, required this.other, required this.desktop});

  @override
  Widget build(BuildContext context) => TargetPlatform.values
          .sublist(3, 6)
          .contains(Theme.of(scaffoldMessengerKey.currentContext!).platform)
      ? desktop(context)
      : other(context);
}

/*
* Example
*/

// class WindowAppBar implements AdaptiveWidget<BuildContext>{
//   @override
//   Widget build(BuildContext context, {BuildContext? data}) {
//     return AppBar(
//       title: Text("Windows"),
//     );
//   }
// }
//
// class MobileAppBar implements AdaptiveWidget<BuildContext>{
//   @override
//   Widget build(BuildContext context, {BuildContext? data}) {
//     return AppBar(
//       title: Text("Mobile"),
//     );
//   }
// }
//
// class TableAppBar implements AdaptiveWidget<BuildContext>{
//   @override
//   Widget build(BuildContext context, {BuildContext? data}) {
//     return AppBar(
//       title: Text("Tablet"),
//     );
//   }
// }
//
// class AdaptiveAppBar extends AdaptiveWidgetFactory<BuildContext>{
//
//   AdaptiveWidgetFactory setDeviceType(DEVICE_TYPE deviceType){
//     switch(deviceType){
//       case DEVICE_TYPE.MOBILE:
//         setAdaptiveWidget = MobileAppBar();
//         break;
//       case DEVICE_TYPE.DESKTOP:
//         setAdaptiveWidget = WindowAppBar();
//         break;
//       case DEVICE_TYPE.TABLET:
//         setAdaptiveWidget = TableAppBar();
//         break;
//       default: break;
//     }
//     return this;
//   }
//   @override
//   Widget build(BuildContext context, {BuildContext? data}) => super.build(context, data: data);
// }
