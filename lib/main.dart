import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:listmaker/bloc/calculator/calculator_bloc.dart';
// import 'package:listmaker/page/home.dart';
import 'package:listmaker/providers/app_color_scheme.dart';
import 'package:listmaker/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:listmaker/page/calculator_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:listmaker/page/home.dart';

// void main() => runApp(AppState());

// class AppState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<CalculatorBloc>(create: (_) => CalculatorBloc()),
//       ],
//       child: MyApp(),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [ChangeNotifierProvider(create: (context) => ThemeProvider())],
//       child: Consumer(
//         builder: (_, ThemeProvider themeProvider, __) {
//           final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
//           // final isDarkNotifier = ValueNotifier<bool>(isDarkMode);

//           return AppColorScheme(
//             brightness: isDarkMode ? Brightness.dark : Brightness.light,
//             // brightness:
//             //     WidgetsBinding.instance.platformDispatcher.platformBrightness,
//             platform: defaultTargetPlatform,
//             child: MaterialApp(
//               debugShowCheckedModeBanner: false,
//               title: 'Material App',
//               // home: Home(isDark: isDarkNotifier),
//               home: CalculatorScreen(),
//               theme: ThemeData.dark().copyWith(
//                 scaffoldBackgroundColor: Colors.black,
//               ),
//               themeMode: themeProvider.themeMode,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

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
