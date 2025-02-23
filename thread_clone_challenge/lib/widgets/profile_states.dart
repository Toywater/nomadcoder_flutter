import 'package:flutter/material.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';

class ProfileStates extends StatelessWidget {
  const ProfileStates({super.key, required this.postInfo});

  final PostModel postInfo;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${postInfo.replies} replies · ${postInfo.likes} likes",
      style: TextStyle(fontSize: Sizes.size16, color: Colors.grey),
    );
  }
}
