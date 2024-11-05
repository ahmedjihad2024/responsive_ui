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



