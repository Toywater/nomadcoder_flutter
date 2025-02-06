import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time_challenge12/constants/gaps.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';
import 'package:navigation_time_challenge12/widgets/profile_avatar.dart';

class NewThread extends StatefulWidget {
  const NewThread({super.key});

  @override
  State<NewThread> createState() => _NewThreadState();
}

class _NewThreadState extends State<NewThread> {
  final PostModel _postInfo = PostModel();
  final TextEditingController _textEditingController = TextEditingController();
  String _threadText = "";

  void CreatePostInfo() {
    _postInfo.avatarImage = NetworkImage("https://avatars.githubusercontent.com/u/114986775?v=4");
    _postInfo.userName = "똘배";
  }

  @override
  void initState() {
    CreatePostInfo();

    super.initState();

    _textEditingController.addListener(() {
      setState(() {
        _threadText = _textEditingController.text;
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: EdgeInsets.symmetric(horizontal: Sizes.size18, vertical: Sizes.size14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.size20), topRight: Radius.circular(Sizes.size20)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Expanded(
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Sizes.size10,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // 프로필 아바타
                      ProfileAvatar(postInfo: _postInfo),
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
                      spacing: Sizes.size10,
                      children: [
                        Text(_postInfo.userName, style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600)),
                        TextField(
                          controller: _textEditingController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: "Start a thread",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                        FaIcon(
                          FontAwesomeIcons.paperclip,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Anyone can reply", style: TextStyle(fontSize: Sizes.size16, color: Colors.grey)),
                  Text(
                    "Post",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: _threadText.isEmpty ? Colors.grey : Colors.lightBlue,
                      fontWeight: _threadText.isEmpty ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gaps.v20,
            ],
          ),
        ),
      ),
    );
  }
}
