import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:navigation_time_challenge12/router.dart';
import 'package:navigation_time_challenge12/view_models/user_config_vm.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserConfigVM(preferences),
    ),
  ], child: const NavigationTime()));
}

class NavigationTime extends StatefulWidget {
  const NavigationTime({super.key});

  @override
  State<NavigationTime> createState() => _NavigationTimeState();
}

class _NavigationTimeState extends State<NavigationTime> {
  @override
  void initState() {
    super.initState();

    // // 값 변경 리스너
    // context.read<UserConfigVM>().addListener(
    //   () {
    //     setState(() {});
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'NavigationTime',
      // is Dark mode
      themeMode: context.watch<UserConfigVM>().isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      // home: const MainNavigationScreen(),
    );
  }
}
