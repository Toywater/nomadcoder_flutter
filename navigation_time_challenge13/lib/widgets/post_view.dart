import 'package:flutter/material.dart';
import 'package:navigation_time_challenge12/constants/gaps.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';
import 'package:navigation_time_challenge12/widgets/profile_avatar.dart';
import 'package:navigation_time_challenge12/widgets/profile_buttons.dart';
import 'package:navigation_time_challenge12/widgets/profile_name.dart';
import 'package:navigation_time_challenge12/widgets/profile_photos.dart';
import 'package:navigation_time_challenge12/widgets/profile_states.dart';

class PostView extends StatelessWidget {
  const PostView({
    super.key,
    this.ellipseTap,
    required this.postInfo,
  });

  final PostModel postInfo;
  final Function(PostModel)? ellipseTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  ProfileAvatar(postInfo: postInfo),
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
                    // 메인 포스팅
                    ProfileName(
                        postInfo: postInfo,
                        ellipseClick: () {
                          ellipseTap?.call(postInfo);
                        }),
                    // 포스팅 내용
                    Text(
                      postInfo.postStr,
                      style: Theme.of(context).textTheme.bodyLarge,
                      // style: TextStyle(fontSize: Sizes.size16, color: Colors.black),
                    ),

                    // #region [ Tag post ]
                    // 태그 된 포스트는 간단하게 표시
                    if (postInfo.tagPostInfo != null)
                      Container(
                        padding: EdgeInsets.all(Sizes.size10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size10),
                          color: Colors.transparent,
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: Sizes.size10,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ProfileAvatar(postInfo: postInfo.tagPostInfo, isSimpleView: true),
                                Expanded(
                                  child: ProfileName(postInfo: postInfo.tagPostInfo!, ellipseClick: () {}),
                                ),
                              ],
                            ),
                            Text(postInfo.tagPostInfo!.postStr, style: TextStyle(fontSize: Sizes.size16)),
                            // 사진
                            if (postInfo.tagPostInfo!.postImagesUrl != null) ProfilePhotos(postInfo: postInfo.tagPostInfo!),
                            // 챗, 공유 등의 아이콘
                          ],
                        ),
                      ),
                    // #endregion // #region [ Tag post ]

                    // 사진
                    if (postInfo.postImagesUrl != null) ProfilePhotos(postInfo: postInfo),
                    // 챗, 공유 등의 아이콘
                    ProfileButtons(postInfo: postInfo),
                    // Replies & likes
                    if (postInfo.replies > 0 || postInfo.likes > 0) ProfileStates(postInfo: postInfo),
                  ],
                ),
              ),
            ],
          ),
          Gaps.v10,
          // #region [ Reply post ]
          if (postInfo.replyPostInfo != null)
            SizedBox(
              child: PostView(postInfo: postInfo.replyPostInfo!),
            ),

          // #endregion [ Reply post ]
        ],
      ),
    );
  }
}
