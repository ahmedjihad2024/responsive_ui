

part of '../responsive_ui.dart';

abstract class DynamicOrientation{}

class AdaptiveOrientation<T extends DynamicOrientation> extends StatelessWidget{
  final Orientation orientation;
  final Widget Function(BuildContext, T?) landscape, portrait;
  final T? Function(BuildContext)? initWidgets;

  const AdaptiveOrientation({super.key,this.initWidgets ,required this.orientation, required this.landscape, required this.portrait});

  @override
  Widget build(BuildContext context){
    final widgets = initWidgets?.call(context);
    return orientation == Orientation.landscape ? landscape(context, widgets) : portrait(context, widgets);
  }
}





