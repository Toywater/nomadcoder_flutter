import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/activity_model.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';
import 'dart:math' as math;

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.postInfo,
    this.activityInfo,
    this.isSimpleView = false,
  });

  final PostModel? postInfo;
  final ActivityModel? activityInfo;
  final bool isSimpleView;

  // 아바타 URL 리턴
  String getAvatarUrl() {
    if (postInfo != null) {
      return postInfo!.avatarUrl;
    } else if (activityInfo != null) {
      return activityInfo!.avatarUrl;
    } else {
      return "";
    }
  }

  // 하단 아이콘 색색
  Color getSubIconColor() {
    Color retColor = Colors.black;

    if (activityInfo != null) {
      switch (activityInfo!.activityMode) {
        case ActivityMode.replies:
          retColor = Colors.lightBlueAccent;
          break;
        case ActivityMode.mentions:
          retColor = Colors.green;
          break;
        case ActivityMode.verified:
          retColor = Colors.pink;
          break;
        case ActivityMode.following:
          retColor = Colors.deepPurple;
          break;
        case ActivityMode.none:
          retColor = Colors.transparent;
          break;
      }
    }

    return retColor;
  }

  // 하단 아이콘 종류
  FaIcon? getSubIcon() {
    FaIcon? retIcon = FaIcon(FontAwesomeIcons.threads, color: Colors.white, size: Sizes.size12);

    if (activityInfo != null) {
      switch (activityInfo!.activityMode) {
        case ActivityMode.replies:
          retIcon = FaIcon(FontAwesomeIcons.reply, color: Colors.white, size: Sizes.size12);
          break;
        case ActivityMode.mentions:
          retIcon = FaIcon(FontAwesomeIcons.threads, color: Colors.white, size: Sizes.size12);
          break;
        case ActivityMode.verified:
          retIcon = FaIcon(FontAwesomeIcons.solidHeart, color: Colors.white, size: Sizes.size12);
          break;
        case ActivityMode.following:
          retIcon = FaIcon(FontAwesomeIcons.solidUser, color: Colors.white, size: Sizes.size12);
          break;
        case ActivityMode.none:
          retIcon = null;
          break;
      }
    }

    return retIcon;
  }

  @override
  Widget build(BuildContext context) {
    AssertionError(postInfo == null && activityInfo == null);

    return SizedBox(
      width: Sizes.size56,
      height: Sizes.size48,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: CircleAvatar(
              radius: isSimpleView ? Sizes.size14 : Sizes.size24,
              backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),
              backgroundImage: NetworkImage(getAvatarUrl()),
            ),
          ),
          if (isSimpleView == false)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                width: 22,
                height: 22,
                padding: EdgeInsets.all(Sizes.size2),
                decoration: BoxDecoration(
                  color: getSubIconColor(),
                  borderRadius: BorderRadius.circular(Sizes.size10),
                  border: Border.all(color: Colors.white, width: Sizes.size2),
                ),
                child: getSubIcon(),
              ),
            )
        ],
      ),
    );
  }
}
