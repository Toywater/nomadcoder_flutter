import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_time_challenge12/repos/auth_repo.dart';
import 'package:navigation_time_challenge12/screens/create_account_screen.dart';
import 'package:navigation_time_challenge12/screens/home_screen.dart';
import 'package:navigation_time_challenge12/screens/login_screen.dart';
import 'package:navigation_time_challenge12/screens/main_navigation_screen.dart';
import 'package:navigation_time_challenge12/screens/privacy_setting_screen.dart';
import 'package:navigation_time_challenge12/screens/user_settings_screen.dart';

final routerProvider = Provider(
  (ref) {
    ref.watch(authStreamRepo);

    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn && state.subloc != CreateAccountScreen.routeUrl && state.subloc != LoginScreen.routeUrl) {
          return LoginScreen.routeUrl;
        }
        return null;
      },
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
          path: LoginScreen.routeUrl,
          name: LoginScreen.routeName,
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: CreateAccountScreen.routeUrl,
          name: CreateAccountScreen.routeName,
          builder: (context, state) => CreateAccountScreen(),
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
  },
);
