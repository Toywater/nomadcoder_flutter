import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({super.key, required this.postInfo});

  final PostModel postInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Sizes.size20,
      children: [
        FaIcon(FontAwesomeIcons.heart),
        FaIcon(FontAwesomeIcons.comment),
        FaIcon(FontAwesomeIcons.share),
        FaIcon(FontAwesomeIcons.paperPlane),
      ],
    );
  }
}
