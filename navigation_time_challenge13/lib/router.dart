import 'package:go_router/go_router.dart';
import 'package:navigation_time_challenge12/screens/home_screen.dart';
import 'package:navigation_time_challenge12/screens/main_navigation_screen.dart';
import 'package:navigation_time_challenge12/screens/privacy_setting_screen.dart';
import 'package:navigation_time_challenge12/screens/user_settings_screen.dart';

final router = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      path: HomeScreen.routeUrl,
      name: HomeScreen.routeName,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: MainNavigationScreen.routeUrl,
      name: MainNavigationScreen.routeName,
      builder: (context, state) {
        var tab = state.params["tab"]!;
        return MainNavigationScreen(tab: tab);
      },
    ),
    GoRoute(
      path: UserSettingsScreen.routeUrl,
      name: UserSettingsScreen.routeName,
      builder: (context, state) => UserSettingsScreen(),
      routes: [
        GoRoute(
          path: PrivacySettingScreen.routeUrl,
          name: PrivacySettingScreen.routeName,
          builder: (context, state) => PrivacySettingScreen(),
        ),
      ],
    ),
  ],
);
