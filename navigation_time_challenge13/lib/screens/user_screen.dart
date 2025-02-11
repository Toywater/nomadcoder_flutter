import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';
import 'package:navigation_time_challenge12/screens/user_settings_screen.dart';
import 'package:navigation_time_challenge12/widgets/persistent_tabbar.dart';
import 'package:navigation_time_challenge12/widgets/post_view.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final List<PostModel> _threads = [];
  final List<PostModel> _replies = [];

  // #region [ TEST DATA ]
  void createTestData() {
    // sample
    _threads.add(
      PostModel(
        avatarUrl: "https://i.pravatar.cc/150?img=1",
        userName: "jane_mobbin",
        postStr: "Give @john_mobbin a follow if you want to see more travel content!",
        replies: 0,
        likes: 0,
        postChecked: false,
        postTime: DateTime.now().add(Duration(hours: -5, minutes: -5)),
      ),
    );

    _threads.add(
      PostModel(
        avatarUrl: "https://i.pravatar.cc/150?img=1",
        userName: "jane_mobbin",
        postStr: "Tea. Spillage.",
        replies: 0,
        likes: 0,
        postChecked: false,
        postTime: DateTime.now().add(Duration(hours: -1, minutes: -5)),
        tagPostInfo: PostModel(
          avatarUrl: "https://i.pravatar.cc/150?img=2",
          userName: "iwetmyyplants",
          postChecked: true,
          postStr: "I'm just going to say what we are all thinking and knowing is about to go downity down: There is about to be some piping hot tea spillage on here daily that people will be...",
          postImagesUrl: [
            "assets/images/post2_4.jpg",
          ],
          visibleEllipse: false,
          visiblePostTime: false,
        ),
      ),
    );

    // Replies data
    _replies.add(
      PostModel(
        avatarUrl: "https://i.pravatar.cc/150?img=2",
        userName: "john_mobbin",
        postStr: "Always a dream to see the Medina in Morocco!",
        replies: 0,
        likes: 0,
        postChecked: false,
        postTime: DateTime.now().add(Duration(hours: -5, minutes: -5)),
        tagPostInfo: PostModel(
          avatarUrl: "https://i.pravatar.cc/150?img=3",
          userName: "earthpix",
          postChecked: true,
          postStr: "What is one place you're absolutely traveling to by next year?",
          visibleEllipse: false,
          visiblePostTime: false,
          replies: 256,
        ),
        replyPostInfo: PostModel(
          avatarUrl: "https://i.pravatar.cc/150?img=1",
          userName: "jane_mobbin",
          postStr: "See you there!",
          replies: 0,
          likes: 0,
          postChecked: false,
          postTime: DateTime.now().add(Duration(hours: -5, minutes: -5)),
        ),
      ),
    );
  }

  @override
  void initState() {
    createTestData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                actions: [
                  IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.instagram)),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserSettingsScreen()));
                      },
                      icon: FaIcon(FontAwesomeIcons.gear)),
                ],
                centerTitle: false,
                title: IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.globe)),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.size14, vertical: Sizes.size14),
                  child: Column(
                    spacing: Sizes.size14,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                          "Jane",
                          style: TextStyle(fontSize: Sizes.size28, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          spacing: Sizes.size10,
                          children: [
                            Text(
                              "jane_mobbin",
                              style: TextStyle(fontSize: Sizes.size20, color: Colors.black),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: Sizes.size14, vertical: Sizes.size6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Sizes.size20),
                                ),
                                color: Colors.grey.shade200,
                              ),
                              child: Text(
                                "threads.net",
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                            )
                          ],
                        ),
                        trailing: CircleAvatar(
                          radius: Sizes.size56,
                          backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=1"),
                        ),
                      ),
                      Text("Plant enthusiast!", style: TextStyle(fontSize: Sizes.size20)),
                      Text("2 followers", style: TextStyle(fontSize: Sizes.size20, color: Colors.grey.shade500)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        spacing: Sizes.size10,
                        children: [
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Sizes.size10),
                                  border: Border.all(color: Colors.grey.shade300, width: Sizes.size1),
                                ),
                                child: TextButton(onPressed: () {}, child: Text("Edit profile"))),
                          ),
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Sizes.size10),
                                  border: Border.all(color: Colors.grey.shade300, width: Sizes.size1),
                                ),
                                child: TextButton(onPressed: () {}, child: Text("Share profile"))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(delegate: PersistentTabBar(), pinned: true)
            ];
          },
          body: TabBarView(
            children: [
              // Threads page view
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: Sizes.size16, vertical: Sizes.size24),
                itemCount: _threads.length,
                separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300, height: Sizes.size24, thickness: Sizes.size1),
                itemBuilder: (context, index) {
                  return PostView(
                    postInfo: _threads[index],
                    ellipseTap: (p0) {},
                  );
                },
              ),
              // Replies page view
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: Sizes.size16, vertical: Sizes.size24),
                itemCount: _replies.length,
                separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300, height: Sizes.size24, thickness: Sizes.size1),
                itemBuilder: (context, index) {
                  return PostView(
                    postInfo: _replies[index],
                    ellipseTap: (p0) {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
