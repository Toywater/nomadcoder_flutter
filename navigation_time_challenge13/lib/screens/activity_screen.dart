import 'package:flutter/material.dart';
import 'package:navigation_time_challenge12/constants/gaps.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/activity_model.dart';

import 'package:navigation_time_challenge12/widgets/profile_avatar.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> with SingleTickerProviderStateMixin {
  // #region [ Member variables ]
  final List<ActivityModel> _activityList = [];
  final List<ActivityModel> _selectedList = [];
  final List<String> _tabNames = ["All", "Replies", "Mentions", "Verified", "Following"];
  late final TabController _tabController;
  // #endregion [ Member variables ]

  // #region [ Member methods ]
  void createSampleData() {
    _activityList.add(
      ActivityModel(
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        userName: "john_mobbin",
        activeStr: "Mentioned you",
        dispStr: "Here's a thread you should follow if you love botany @jane_mobbin",
        activityMode: ActivityMode.mentions,
        postTime: DateTime.now().add(Duration(hours: -4)),
      ),
    );

    _activityList.add(
      ActivityModel(
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        userName: "john_mobbin",
        activeStr: "Starting out my gardening club with thread.",
        dispStr: "Count me in!",
        activityMode: ActivityMode.replies,
        postTime: DateTime.now().add(Duration(hours: -4)),
      ),
    );

    _activityList.add(
      ActivityModel(
        avatarUrl: 'https://i.pravatar.cc/150?img=2',
        userName: "the.plantdads",
        activeStr: "Followed you",
        dispStr: "",
        activityMode: ActivityMode.following,
        postTime: DateTime.now().add(Duration(hours: -5)),
      ),
    );

    _activityList.add(
      ActivityModel(
        avatarUrl: 'https://i.pravatar.cc/150?img=2',
        userName: "the.plantdads",
        activeStr: "Definitely broken!🐳🐨🧐",
        dispStr: "",
        activityMode: ActivityMode.verified,
        postTime: DateTime.now().add(Duration(hours: -5)),
      ),
    );

    _activityList.add(
      ActivityModel(
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
        userName: "theberryjungle",
        activeStr: "🐳🐨🧐",
        dispStr: "",
        activityMode: ActivityMode.verified,
        postTime: DateTime.now().add(Duration(hours: -5)),
      ),
    );

    _selectedList.addAll(_activityList);
  }
  // #endregion [ Member methods ]

  // #region [ Override methods ]
  @override
  void initState() {
    createSampleData();

    _tabController = TabController(length: _tabNames.length, vsync: this);
    _tabController.addListener(
      () {
        _selectedList.clear();

        switch (_tabController.index) {
          case 1: // Replies
            for (var arg in _activityList) {
              if (arg.activityMode == ActivityMode.replies) _selectedList.add(arg);
            }
            break;
          case 2: // Mentions
            for (var arg in _activityList) {
              if (arg.activityMode == ActivityMode.mentions) _selectedList.add(arg);
            }
            break;
          case 3: // Verified
            for (var arg in _activityList) {
              if (arg.activityMode == ActivityMode.verified) _selectedList.add(arg);
            }
            break;
          case 4: // Following
            for (var arg in _activityList) {
              if (arg.activityMode == ActivityMode.following) _selectedList.add(arg);
            }
            break;
          default: // All
            _selectedList.addAll(_activityList);
            break;
        }

        setState(() {});
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(fontSize: Sizes.size32, fontWeight: FontWeight.bold, color: Colors.black),
        toolbarHeight: 60,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Sizes.size10,
          children: [
            Text("Activity"),
          ],
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            tabAlignment: TabAlignment.start,
            dividerHeight: 0,
            isScrollable: true,
            splashFactory: NoSplash.splashFactory,
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600),
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size10),
              border: Border.all(color: Colors.grey, strokeAlign: Sizes.size1),
              color: Colors.black,
            ),
            tabs: [
              for (var tapName in _tabNames)
                SizedBox(
                  width: Sizes.size96 + Sizes.size20,
                  height: Sizes.size36,
                  child: Tab(text: tapName),
                ),
            ],
          ),
          Gaps.v20,
          // Tile list
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300, height: Sizes.size24, thickness: Sizes.size1),
              itemCount: _selectedList.length,
              itemBuilder: (context, index) {
                // 포스팅 시간 차 구하기
                var difTime = DateTime.now().difference(_selectedList[index].postTime);
                String postTime = "";
                if (difTime.inDays > 0) postTime = "${difTime.inDays}d";
                if (postTime.isEmpty && difTime.inHours > 0) postTime = "$postTime${difTime.inHours}h";
                if (postTime.isEmpty && difTime.inMinutes > 0) postTime = "$postTime${difTime.inMinutes}m";

                return ListTile(
                  titleAlignment: ListTileTitleAlignment.top,
                  // 프로필 아바타
                  leading: ProfileAvatar(activityInfo: _selectedList[index]),
                  title: Row(
                    spacing: Sizes.size10,
                    children: [
                      // 이름
                      Text(
                        _selectedList[index].userName,
                        style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600),
                      ),
                      // 포스팅 시간에서 현재 시간을 뺀다.
                      Text(postTime, style: TextStyle(fontSize: Sizes.size16, color: Colors.grey)),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_selectedList[index].activeStr, style: TextStyle(fontSize: Sizes.size16, color: Colors.grey)),
                      Text(_selectedList[index].dispStr, style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  // Following 인 경우 버튼 활성화
                  trailing: (_selectedList[index].activityMode == ActivityMode.following)
                      ? OutlinedButton(
                          onPressed: null,
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(Sizes.size10)),
                            ),
                          ),
                          child: Text("Following"),
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  // #endregion [ Override methods ]
}
