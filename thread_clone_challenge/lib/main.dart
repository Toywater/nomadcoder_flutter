import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_time_challenge12/firebase_options.dart';
import 'package:navigation_time_challenge12/router.dart';
import 'package:navigation_time_challenge12/view_models/user_config_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final preferences = await SharedPreferences.getInstance();

  // runApp(MultiProvider(providers: [
  //   ChangeNotifierProvider(
  //     create: (context) => UserConfigVM(preferences),
  //   ),
  // ], child: const NavigationTime()));

  runApp(
    ProviderScope(
      overrides: [
        userConfigProvider.overrideWith(
          () => UserConfigVM(preferences),
        ),
      ],
      child: const NavigationTime(),
    ),
  );
}

class NavigationTime extends ConsumerStatefulWidget {
  const NavigationTime({super.key});

  @override
  NavigationTimeState createState() => NavigationTimeState();
}

class NavigationTimeState extends ConsumerState<NavigationTime> {
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
      routerConfig: ref.watch(routerProvider),
      title: 'NavigationTime',
      // is Dark mode
      themeMode: ref.watch(userConfigProvider).isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // themeMode: context.watch<UserConfigVM>().isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
