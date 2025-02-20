import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';

class PrivacySettingScreen extends StatefulWidget {
  const PrivacySettingScreen({super.key});

  static String routeUrl = "privacySet";
  static String routeName = "privacySet";

  @override
  State<PrivacySettingScreen> createState() => _PrivacySettingScreenState();
}

class _PrivacySettingScreenState extends State<PrivacySettingScreen> {
  bool _privateProfileValue = false;

  void _onPrivateProfileChange(bool? changeValue) {
    if (changeValue == null) return;

    setState(() {
      _privateProfileValue = changeValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: FaIcon(FontAwesomeIcons.lock),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Private profile"),
            trailing: Switch.adaptive(
              value: _privateProfileValue,
              onChanged: _onPrivateProfileChange,
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.threads),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Mentions"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: Sizes.size10,
              children: [
                Text("Everyone", style: TextStyle(fontSize: Sizes.size16, color: Colors.grey.shade500)),
                FaIcon(FontAwesomeIcons.chevronRight, color: Colors.grey.shade500),
              ],
            ),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.bellSlash),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Muted"),
            trailing: FaIcon(FontAwesomeIcons.chevronRight, color: Colors.grey.shade500),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.eyeSlash),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Hidden Words"),
            trailing: FaIcon(FontAwesomeIcons.chevronRight, color: Colors.grey.shade500),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.users),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Profiles you follow"),
            trailing: FaIcon(FontAwesomeIcons.chevronRight, color: Colors.grey.shade500),
          ),
          Divider(thickness: Sizes.size1, color: Colors.grey.shade300),
          ListTile(
            titleTextStyle: TextStyle(fontSize: Sizes.size20, color: isDarkMode ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
            titleAlignment: ListTileTitleAlignment.top,
            title: Text("Other privacy settings"),
            trailing: FaIcon(FontAwesomeIcons.arrowUpRightFromSquare, color: Colors.grey.shade500),
            subtitleTextStyle: TextStyle(color: Colors.grey.shade500, fontSize: Sizes.size20),
            subtitle: Text("Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram."),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.circleXmark),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Blocked profiles"),
            trailing: FaIcon(FontAwesomeIcons.arrowUpRightFromSquare, color: Colors.grey.shade500),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.heartCircleXmark),
            titleTextStyle: TextStyle(
              fontSize: Sizes.size20,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            titleAlignment: ListTileTitleAlignment.center,
            title: Text("Hide likes"),
            trailing: FaIcon(FontAwesomeIcons.arrowUpRightFromSquare, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
