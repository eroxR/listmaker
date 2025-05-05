import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:listmaker/page/home.dart';
import 'package:listmaker/providers/app_color_scheme.dart';
import 'package:listmaker/providers/provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ThemeProvider())],
      child: Consumer(
        builder: (_, ThemeProvider themeProvider, __) {
          final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
          final isDarkNotifier = ValueNotifier<bool>(isDarkMode);

          return AppColorScheme(
            brightness: isDarkMode ? Brightness.dark : Brightness.light,
            // brightness:
            //     WidgetsBinding.instance.platformDispatcher.platformBrightness,
            platform: defaultTargetPlatform,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Material App',
              home: Home(isDark: isDarkNotifier),
              themeMode: themeProvider.themeMode,
            ),
          );
        },
      ),
    );
  }
}
