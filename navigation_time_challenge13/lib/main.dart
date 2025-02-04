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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}
