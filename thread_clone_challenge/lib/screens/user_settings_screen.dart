import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/repos/auth_repo.dart';
import 'package:navigation_time_challenge12/screens/privacy_setting_screen.dart';
import 'package:navigation_time_challenge12/view_models/user_config_vm.dart';

class UserSettingsScreen extends ConsumerWidget {
  const UserSettingsScreen({super.key});

  static String routeUrl = "/userSet";
  static String routeName = "userSet";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final isDarkMode = ref.read(userConfigProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: Sizes.size20,
        ),
        centerTitle: true,
        title: Text("Settings"),
        elevation: 1,
        backgroundColor: isDarkMode ? Colors.black38 : Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: FaIcon(FontAwesomeIcons.circleHalfStroke),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Dark mode"),
            trailing: Switch.adaptive(
              value: ref.watch(userConfigProvider).isDarkMode,
              onChanged: (value) => ref.read(userConfigProvider.notifier).setIsDarkMode(value),
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.userPlus),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Follow and invite friends"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.bell),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Notifications"),
          ),
          ListTile(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrivacySettingScreen()));
              context.pushNamed(PrivacySettingScreen.routeName);
            },
            leading: FaIcon(FontAwesomeIcons.lock),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Privacy"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.circleUser),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Account"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.lifeRing),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Help"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.circleInfo),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("About"),
          ),
          Divider(thickness: Sizes.size1, color: Colors.grey.shade300),
          ListTile(
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            title: Text("Log out"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog.adaptive(
                    title: Text("Are you sure?"),
                    actions: [
                      TextButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      TextButton(
                        child: Text("Yes"),
                        onPressed: () {
                          ref.read(authRepo).logout();
                          // Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
