import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/screens/home_screen.dart';
import 'package:navigation_time_challenge12/widgets/nav_tap.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  // #region [ Member variables ]
  int _currentScreenIndex = 0;
  // #endregion [ Member variables ]

  // #region [ Member methods ]
  void _onTap(int screenIndex) {
    setState(() {
      _currentScreenIndex = screenIndex;
    });
  }

  // #endregion [ Member methods ]
  // #region [ Build method ]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(
            offstage: _currentScreenIndex != 0,
            child: HomeScreen(),
          ),
          Offstage(
            offstage: _currentScreenIndex != 1,
            child: Scaffold(),
          ),
          Offstage(
            offstage: _currentScreenIndex != 2,
            child: Scaffold(),
          ),
          Offstage(
            offstage: _currentScreenIndex != 3,
            child: Scaffold(),
          ),
          Offstage(
            offstage: _currentScreenIndex != 4,
            child: Center(
              child: Scaffold(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTap(
                icon: FontAwesomeIcons.houseChimney,
                isSelected: _currentScreenIndex == 0,
                text: "Home",
                onTap: () => _onTap(0),
              ),
              NavTap(
                onTap: () => _onTap(1),
                icon: FontAwesomeIcons.magnifyingGlass,
                isSelected: _currentScreenIndex == 1,
                text: "Discover",
              ),
              NavTap(
                onTap: () => _onTap(2),
                icon: FontAwesomeIcons.penToSquare,
                isSelected: _currentScreenIndex == 2,
                text: "Write",
              ),
              NavTap(
                onTap: () => _onTap(3),
                icon: FontAwesomeIcons.heart,
                isSelected: _currentScreenIndex == 3,
                text: "Heart",
              ),
              NavTap(
                onTap: () => _onTap(4),
                icon: FontAwesomeIcons.user,
                isSelected: _currentScreenIndex == 4,
                text: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
  // #region [ Build method ]
}
