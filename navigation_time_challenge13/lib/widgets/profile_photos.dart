import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navigation_time_challenge12/constants/gaps.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';

class ProfilePhotos extends StatelessWidget {
  const ProfilePhotos({super.key, required this.postInfo});

  final PostModel postInfo;

  // 이미지 정보를 가져온다.
  Future<Image?> _getImage(String imageUrl) async {
    Image? retImage;

    // asset 에 있는지 조사
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final assets = assetManifest.listAssets();

    // 처음에 asset 에서 가지고 오고
    if (assets.contains(imageUrl)) {
      retImage = Image.asset(imageUrl, fit: BoxFit.cover);
    }
    // 그 다음 file
    else if (File(imageUrl).existsSync()) {
      retImage = Image.file(File(imageUrl), fit: BoxFit.cover);
    }
    // 그 다음 network 에서 가지고 온다.
    else {
      retImage = Image.network(imageUrl, fit: BoxFit.cover);
    }

    return retImage;
  }

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
            // child: Image.asset(postInfo.postImagesUrl![imgIdx], fit: BoxFit.cover),
            child: FutureBuilder(
              future: _getImage(postInfo.postImagesUrl![imgIdx]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return SizedBox();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
