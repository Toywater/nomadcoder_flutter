import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:navigation_time_challenge12/screens/main_navigation_screen.dart';

void main() {
  runApp(const NavigationTime());
}

class NavigationTime extends StatelessWidget {
  const NavigationTime({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavigationTime',
      themeMode: ThemeMode.system,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      home: const MainNavigationScreen(),
    );
  }
}
