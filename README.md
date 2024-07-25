# Responsive Ui

## Basic Usage

#### Wrap your app with ResponsiveLayout to manage responsiveness:

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      designWidth: 414,
      designHeight: 896,
      builder: (context, DeviceDetails details) {
        return MaterialApp(
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive UI Example'),
      ),
      body: Center(
        child: Text('Hello, world!'),
      ),
    );
  }
}
```

## Features

### Width Scaling

- **`100.w`**: Scales the number by the device's width scaling factor.
- **`100.wMin`**: The minimum width to scale.

### Height Scaling

- **`100.h`**: Scales the number by the device's height scaling factor.
- **`100.hMin`**: The minimum height to scale.

### Font Scaling

- **`100.spAdapt`**: Scales the number for font size based on a combination of the device's width
  and height scaling factors.
- **`100.spAdaptMin`**: Returns the maximum of the original value and the adapted font size.
- **`100.sp`**: Scales the number for font size based on the average of the device's width and
  height scaling factors.
- **`100.spMin`**: Returns the maximum of the original value and the scaled font size.

### Radius Scaling

- **`100.r`**: Scales the number for radius based on the minimum of the device's width and height
  scaling factors.

### Spacing Utilities

- **`100.verticalSpace`**: Returns a `SizedBox` with height scaled by the height scaling factor.
- **`100.verticalSpaceMax`**: Returns a `SizedBox` with height as the minimum of the original value
  and the scaled height value.
- **`100.verticalSpaceMin`**: Returns a `SizedBox` with height as the maximum of the original value
  and the scaled height value.
- **`100.horizontalSpace`**: Returns a `SizedBox` with width scaled by the width scaling factor.
- **`100.horizontalSpaceMax`**: Returns a `SizedBox` with width as the minimum of the original value
  and the scaled width value.
- **`100.horizontalSpaceMin`**: Returns a `SizedBox` with width as the maximum of the original value
  and the scaled width value.

### Diagonal and Diameter Scaling

- **`100.diagonal`**: Scales the number based on the product of the device's width and height
  scaling factors.
- **`100.diameter`**: Scales the number based on the maximum of the device's width and height
  scaling factors.

### Device-specific Size

- **`double size({Object? mobile, Object? tablet, Object? desktop})`**: Returns a size based on the
  screen. For example, if the width of the screen is more than 1100, it will return the desktop
  size.
- **`double desktopSize(double other, double desktop)`**: Returns a size for desktop and web devices
  when the screen size is that of a desktop. To elaborate, on desktop devices, it will always return
  the desktop size regardless of the screen size. On web devices, it will return the desktop size
  only when the screen size is equivalent to a desktop. The function will return the other size when
  the devices are mobile (phones, tablets) or when running on web devices with screen sizes not
  equivalent to a desktop.
- **`double orienSize(double portrait, double landscape)`**: Returns a size based on the device's
  orientation (portrait or landscape).

### Example

```dart
void main() {
  double responseSize = size(mobile: 10, tablet: 12, desktop: 20);
  // or 
  // size(mobile: (double portrait, double landscape), tablet: (double portrait, double landscape), desktop: (double portrait, double landscape))
  double responseSize = size(mobile: (10, 12), tablet: (10, 14), desktop: (20, 30));

  // you can mix size function with desktopSize 
  // for good working speciality if you will design for windows side with mobile you can try the following
  // EX.
  desktopSize(size(mobile: (10, 12), tablet: (10, 14)), 20);
  // The `size(mobile: (10, 12), tablet: (10, 14))` values will be returned on mobile devices and web devices with screen sizes equivalent to mobile.
  // The value `20` will be returned on desktop devices and web devices with screen sizes equivalent to a desktop.
}
```

# AdaptiveOrientation Class

The `AdaptiveOrientation` class is a Flutter widget that allows you to build different UI layouts
based on the device's orientation (portrait or landscape). It provides a way to adapt your UI to the
screen orientation dynamically, which is especially useful for creating responsive and adaptive
designs.

## Class Definition

### `AdaptiveOrientation<T extends DynamicOrientation>`

This class extends `StatelessWidget` and provides an adaptive layout based on the device's
orientation.

#### Properties

- **`orientation`**: The current orientation of the device (`Orientation.landscape`
  or `Orientation.portrait`).
- **`landscape`**: A function that returns a widget to be displayed in landscape orientation. It
  takes a `BuildContext` and an optional parameter of type `T` (which extends `DynamicOrientation`).
- **`portrait`**: A function that returns a widget to be displayed in portrait orientation. It also
  takes a `BuildContext` and an optional parameter of type `T`.
- **`initWidgets`**: An optional function that initializes and returns a widget of type `T`. This
  function is used to set up any widgets or parameters needed for the layout.

#### Example

Here's how you can use the `AdaptiveOrientation` class to create a responsive login form:

```dart
import 'package:flutter/material.dart';

class DynamicLogin extends DynamicOrientation {
  late Widget emailForm;
  late Widget passwordForm;
  late Widget loginButton;
  late Widget title;
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: AdaptiveOrientation<DynamicLogin>(
        orientation: deviceDetails.orientation,
        initWidgets: (context) {
          DynamicLogin dynamicLogin = DynamicLogin();
          var height = desktopSize(size(mobile: 45.h, tablet: 45.h), 40);
          var width = desktopSize(size(mobile: (310.w, 310.w), tablet: 230.w), 300);
          var fontSize = desktopSize(size(mobile: 22.sp, tablet: 20.sp), 16);
          var horizontalPadding = desktopSize(size(mobile: 10.w, tablet: 10.w), 10);

          // i made a textform for email i just decorated it 
          var emailForm = Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.brown.withOpacity(.5),
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.white, fontSize: fontSize),
              decoration: InputDecoration.collapsed(
                hintText: "Email",
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(.8),
                  fontSize: fontSize,
                ),
              ),
            ),
          );

          var passwordForm = Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.brown.withOpacity(.5),
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.white, fontSize: fontSize),
              decoration: InputDecoration.collapsed(
                hintText: "Password",
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(.8),
                  fontSize: fontSize,
                ),
              ),
            ),
          );

          var loginButton = TextButton(
            onPressed: () {},
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(width, height)),
              backgroundColor: MaterialStateProperty.all(Colors.brown),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: Text(
              "Login",
              style: TextStyle(fontSize: fontSize, color: Colors.white),
            ),
          );

          var title = Text(
            "SHOP HAPPY",
            style: TextStyle(color: Colors.brown, fontSize: 34, fontWeight: FontWeight.bold),
          );

          dynamicLogin.emailForm = emailForm;
          dynamicLogin.passwordForm = passwordForm;
          dynamicLogin.loginButton = loginButton;
          dynamicLogin.title = title;

          return dynamicLogin;
        },
        // in landscape we just will rearrange our widgets as we want in landscape 
        // and in portrait the same thing. 
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
                    widgets.loginButton,
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
                widgets.loginButton,
              ],
            ),
          );
        },
      ),
    ),
  ));
}
```

# AdaptiveDesktop Widget

This widget is designed for creating custom widgets that are specifically intended for display on
Windows platforms. It will not be rendered on mobile or web environments.

```
AdaptiveDesktop(
    other: (context) => MobileView(), // Widget for mobile/web
    desktop: (context) => DesktopView(), // Widget for desktop devices only
);
```

# AdaptiveWidget and AdaptiveWidgetFactory abstract class

### Usage

**First** Creating Platform-Specific Widgets

1. Create platform-specific classes (e.g., WindowAppBar) that implement AdaptiveWidget.
2. Pass the type of data you want to pass.
3. Override the build method to return the appropriate widget for each platform.

```dart
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
```

**Second** The AdaptiveAppBar class acts as a factory to create platform-specific app bars. The
setDeviceType function allows you to configure the factory based on the device type, and the build
function delegates the actual widget creation to the AdaptiveWidgetFactory superclass. This pattern
provides a clean and organized way to manage platform-specific UI components in your Flutter
application.

```dart
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
```
## Using the Navigator
### Example
```
navigator!.push(MaterialPageRoute(builder: (_)=> OtherScreen()));
```




