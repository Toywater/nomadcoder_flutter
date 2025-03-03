import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/screens/activity_screen.dart';
import 'package:navigation_time_challenge12/screens/home_screen.dart';
import 'package:navigation_time_challenge12/screens/search_screen.dart';
import 'package:navigation_time_challenge12/screens/user_screen.dart';
import 'package:navigation_time_challenge12/widgets/nav_tap.dart';
import 'package:navigation_time_challenge12/widgets/new_thread.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key, required this.tab});

  static String routeUrl = "/:tab(home|search|activity|profile)";
  static String routeName = "mainNav";
  final String tab;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> with SingleTickerProviderStateMixin {
  // #region [ Member variables ]
  late final AnimationController _animationController;
  late final Animation<Offset> _activityPanelAnimation;
  late final Animation<Color?> _barrierAnimation;
  bool _visibleBarrier = false;
  final List<String> _tabs = [
    "home",
    "search",
    "writeNew",
    "activity",
    "profile",
  ];
  late int _currentScreenIndex = _tabs.indexOf(widget.tab);
  // #endregion [ Member variables ]

  // #region [ Member methods ]
  void _onTap(int screenIndex) {
    // 2번 (New thread)은 슬라이드 화면이므로 화면간 전환은 하지 않음
    if (screenIndex != 2) {
      context.go("/${_tabs[screenIndex]}");
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
          // backgroundColor: Colors.white,
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
                  child: UserScreen(),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavTap(
                    icon: Icons.home_outlined, //FontAwesomeIcons.houseChimney,
                    isSelected: _currentScreenIndex == 0,
                    text: "Home",
                    onTap: () => _onTap(0),
                  ),
                  NavTap(
                    onTap: () => _onTap(1),
                    icon: Icons.search, // FontAwesomeIcons.magnifyingGlass,
                    isSelected: _currentScreenIndex == 1,
                    text: "Discover",
                  ),
                  NavTap(
                    onTap: () => _onTap(2),
                    icon: Icons.edit_note_outlined, //FontAwesomeIcons.penToSquare,
                    isSelected: _currentScreenIndex == 2,
                    text: "Write",
                  ),
                  NavTap(
                    onTap: () => _onTap(3),
                    icon: Icons.favorite_outline, // FontAwesomeIcons.heart,
                    isSelected: _currentScreenIndex == 3,
                    text: "Activity",
                  ),
                  NavTap(
                    onTap: () => _onTap(4),
                    icon: Icons.person_outline, //  FontAwesomeIcons.user,
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
            child: NewThread(
              onCancel: _changePanelState,
            ),
          ),
        )
      ],
    );
  }
  // #region [ Build method ]
}
