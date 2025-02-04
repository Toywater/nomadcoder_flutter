import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, required this.postInfo});

  final PostModel postInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.size48,
      height: Sizes.size48,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: CircleAvatar(
              radius: Sizes.size24,
              backgroundColor: Colors.lightBlueAccent,
              backgroundImage: postInfo.avatarImage,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              width: 22,
              height: 22,
              padding: EdgeInsets.all(Sizes.size2),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(Sizes.size10),
                border: Border.all(color: Colors.white, width: Sizes.size2),
              ),
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.white,
                size: Sizes.size12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
