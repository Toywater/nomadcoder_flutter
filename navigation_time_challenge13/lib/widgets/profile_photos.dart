import 'package:flutter/material.dart';
import 'package:navigation_time_challenge12/constants/gaps.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';

class ProfilePhotos extends StatelessWidget {
  const ProfilePhotos({super.key, required this.postInfo});

  final PostModel postInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.separated(
        itemCount: postInfo.postImagesUrl != null ? postInfo.postImagesUrl!.length : 0,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => Gaps.h10,
        itemBuilder: (context, imgIdx) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size10),
            ),
            child: Image.asset(postInfo.postImagesUrl![imgIdx], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}
