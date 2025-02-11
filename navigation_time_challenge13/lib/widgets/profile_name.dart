import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';

class ProfileName extends StatelessWidget {
  const ProfileName({super.key, required this.postInfo, required this.ellipseClick});

  final PostModel postInfo;
  final Function ellipseClick;

  @override
  Widget build(BuildContext context) {
    // 포스팅 시간 차 구하기
    var difTime = DateTime.now().difference(postInfo.postTime);

    String postTime = "";
    if (difTime.inDays > 0) postTime = "${difTime.inDays}d";
    if (postTime.isEmpty && difTime.inHours > 0) postTime = "$postTime${difTime.inHours}h";
    if (postTime.isEmpty && difTime.inMinutes > 0) postTime = "$postTime${difTime.inMinutes}m";

    return Row(
      spacing: Sizes.size10,
      children: [
        // 이름
        Text(
          postInfo.userName,
          style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600),
        ),
        // 포스팅 체크표시
        if (postInfo.postChecked)
          FaIcon(
            FontAwesomeIcons.solidCircleCheck,
            color: Color(0xFF4293EF),
            size: Sizes.size16,
          ),
        Spacer(),
        // 포스팅 시간에서 현재 시간을 뺀다.
        if (postInfo.visiblePostTime) Text(postTime, style: TextStyle(fontSize: Sizes.size16, color: Colors.grey)),
        if (postInfo.visibleEllipse) IconButton(onPressed: () => ellipseClick(), icon: FaIcon(FontAwesomeIcons.ellipsis)),
      ],
    );
  }
}
