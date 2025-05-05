import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class AppColorScheme extends InheritedWidget {
  const AppColorScheme({
    super.key,
    required super.child,
    required this.brightness,
    required this.platform,
  });

  final Brightness brightness;
  final TargetPlatform platform;

  static AppColorScheme of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<AppColorScheme>();
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    final platform = Theme.of(context).platform;
    return inherited ??
        AppColorScheme(
          brightness: brightness,
          platform: platform,
          child: const SizedBox.shrink(),
        );
  }

  Color get card {
    return brightness == Brightness.dark ? Colors.black12 : Colors.white;
  }

  Color get textdark {
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  @override
  bool updateShouldNotify(covariant AppColorScheme oldWidget) {
    return brightness != oldWidget.brightness || platform != oldWidget.platform;
  }
}
