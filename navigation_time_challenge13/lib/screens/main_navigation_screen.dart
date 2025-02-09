import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/screens/activity_screen.dart';
import 'package:navigation_time_challenge12/screens/home_screen.dart';
import 'package:navigation_time_challenge12/screens/search_screen.dart';
import 'package:navigation_time_challenge12/widgets/nav_tap.dart';
import 'package:navigation_time_challenge12/widgets/new_thread.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> with SingleTickerProviderStateMixin {
  // #region [ Member variables ]
  int _currentScreenIndex = 0;
  late final AnimationController _animationController;
  late final Animation<Offset> _activityPanelAnimation;
  late final Animation<Color?> _barrierAnimation;
  bool _visibleBarrier = false;
  // #endregion [ Member variables ]

  // #region [ Member methods ]
  void _onTap(int screenIndex) {
    // 2번 (New thread)은 슬라이드 화면이므로 화면간 전환은 하지 않음

    if (screenIndex != 2) {
      setState(() {
        _currentScreenIndex = screenIndex;
      });
    } else {
      _changePanelState();
    }
  }

  void _changePanelState() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
      _visibleBarrier = false;
      setState(() {
        FocusScope.of(context).unfocus();
      });
    } else {
      _animationController.forward();
      _visibleBarrier = true;
      // FocusManager.instance.primaryFocus?.focus
      setState(() {});
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _activityPanelAnimation = Tween(begin: Offset(0, 1), end: Offset.zero).animate(_animationController);
    _barrierAnimation = ColorTween(begin: Colors.transparent, end: Colors.black38).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
  // #endregion [ Member methods ]

  // #region [ Build method ]
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Offstage(
                offstage: _currentScreenIndex != 0,
                child: HomeScreen(),
              ),
              Offstage(
                offstage: _currentScreenIndex != 1,
                child: SearchScreen(),
              ),
              Offstage(
                offstage: _currentScreenIndex != 2,
                child: Scaffold(),
              ),
              Offstage(
                offstage: _currentScreenIndex != 3,
                child: ActivityScreen(),
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
                    text: "Activity",
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
        ),
        if (_visibleBarrier) AnimatedModalBarrier(color: _barrierAnimation, onDismiss: _changePanelState),
        Align(
          alignment: Alignment.bottomLeft,
          widthFactor: 1,
          child: SlideTransition(
            position: _activityPanelAnimation,
            // Unfollow, hide, report...
            child: NewThread(),
          ),
        )
      ],
    );
  }
  // #region [ Build method ]
}
