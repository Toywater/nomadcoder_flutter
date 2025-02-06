import 'package:flutter/material.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';
import 'package:navigation_time_challenge12/widgets/ellipse_menus.dart';
import 'package:navigation_time_challenge12/widgets/profile_avatar.dart';
import 'package:navigation_time_challenge12/widgets/profile_buttons.dart';
import 'package:navigation_time_challenge12/widgets/profile_name.dart';
import 'package:navigation_time_challenge12/widgets/profile_photos.dart';
import 'package:navigation_time_challenge12/widgets/profile_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final List<PostModel> _postList = [];
  // #region [ TEST DATA ]
  void createTestData() {
    // sample
    PostModel tmpPost = PostModel();
    tmpPost.avatarImage = NetworkImage("https://avatars.githubusercontent.com/u/114986775?v=4");
    tmpPost.userName = "똘배";
    tmpPost.postStr = "안성맞춤 비행 클럽. 2025년 새해 모임을 가졌습니다.";
    tmpPost.replies = 153;
    tmpPost.likes = 3523;
    tmpPost.postChecked = true;
    tmpPost.postTime = DateTime.now().add(Duration(hours: -12, minutes: -5));
    tmpPost.postImagesUrl = [
      "assets/images/post1_2.jpg",
      "assets/images/post1_3.jpg",
      "assets/images/post1_4.jpg",
      "assets/images/post1_1.jpg",
    ];

    _postList.add(tmpPost);

    // sample
    tmpPost = PostModel();
    tmpPost.avatarImage = NetworkImage("https://avatars.githubusercontent.com/u/114986775?v=4");
    tmpPost.userName = "shityoushouldcareabout";
    tmpPost.postStr = "my phone feels like a vibrator with all these notifications rn";
    tmpPost.replies = 64;
    tmpPost.likes = 631;
    tmpPost.postChecked = true;
    tmpPost.postTime = DateTime.now().add(Duration(days: -1, hours: -12, minutes: -5));

    _postList.add(tmpPost);

    // sample
    tmpPost = PostModel();
    tmpPost.avatarImage = NetworkImage("https://avatars.githubusercontent.com/u/114986775?v=4");
    tmpPost.userName = "똘배";
    tmpPost.postStr = "RC 트라이얼 및 등산 다녀왔는데 날씨 정말 정말 정말 춥네요.";
    tmpPost.replies = 4;
    tmpPost.likes = 555;
    tmpPost.postChecked = true;
    tmpPost.postTime = DateTime.now().add(Duration(days: -2, hours: -3, minutes: -0));
    tmpPost.postImagesUrl = [
      "assets/images/post2_2.jpg",
      "assets/images/post2_5.jpg",
      "assets/images/post2_7.jpg",
    ];

    _postList.add(tmpPost);

    // sample
    tmpPost = PostModel();
    tmpPost.avatarImage = NetworkImage("https://avatars.githubusercontent.com/u/114986775?v=4");
    tmpPost.userName = "똘배";
    tmpPost.postStr = "늦은 가을의 캠핑과 새로운 어항 세팅";
    tmpPost.replies = 5;
    tmpPost.likes = 77;
    tmpPost.postChecked = true;
    tmpPost.postTime = DateTime.now().add(Duration(days: -16, hours: -1, minutes: -0));
    tmpPost.postImagesUrl = [
      "assets/images/post2_4.jpg",
      "assets/images/post2_6.jpg",
    ];

    _postList.add(tmpPost);
  }
  // #endregion [ TEST DATA ]

  // #region [ Member variables ]
  late final AnimationController _animationController;
  late final Animation<Offset> _activityPanelAnimation;
  late final Animation<Color?> _barrierAnimation;
  bool _visibleBarrier = false;
  // #endregion [ Member variables ]

  // #region [ Member methods ]
  // Ellipse 클릭 이벤트
  void ellipseClick(PostModel postInfo) {
    _changePanelState();
  }

  void _changePanelState() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
      _visibleBarrier = false;
      setState(() {});
    } else {
      _animationController.forward();
      _visibleBarrier = true;
      setState(() {});
    }
  }
  // #endregion [ Member methods ]

  @override
  void initState() {
    super.initState();

    createTestData();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _activityPanelAnimation = Tween(begin: Offset(0, 1), end: Offset.zero).animate(_animationController);
    _barrierAnimation = ColorTween(begin: Colors.transparent, end: Colors.black38).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size16, vertical: Sizes.size24),
            itemCount: _postList.length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300, height: Sizes.size24, thickness: Sizes.size1),
            itemBuilder: (context, index) {
              return Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Sizes.size10,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // 프로필 아바타
                        ProfileAvatar(postInfo: _postList[index]),
                        // 세로줄
                        VerticalDivider(
                          thickness: Sizes.size1,
                          color: Colors.red,
                          width: Sizes.size20,
                        ),
                        // Replies avatars
                        // Text("TEST"),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: Sizes.size20,
                        children: [
                          ProfileName(
                            postInfo: _postList[index],
                            ellipseClick: () {
                              ellipseClick(_postList[index]);
                            },
                          ),
                          // 포스팅 내용
                          Text(_postList[index].postStr, style: TextStyle(fontSize: Sizes.size16, color: Colors.black)),
                          // 사진
                          if (_postList[index].postImagesUrl.isNotEmpty) ProfilePhotos(postInfo: _postList[index]),
                          // 챗, 공유 등의 아이콘
                          ProfileButtons(postInfo: _postList[index]),
                          // Replies & likes
                          ProfileStates(postInfo: _postList[index]),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          if (_visibleBarrier) AnimatedModalBarrier(color: _barrierAnimation, onDismiss: _changePanelState),
          Align(
            alignment: Alignment.bottomLeft,
            widthFactor: 1,
            child: SlideTransition(
              position: _activityPanelAnimation,
              // Unfollow, hide, report...
              child: EllipseMenus(),
            ),
          )
        ],
      ),
    );
  }
}
