import 'dart:core';

class PostModel {
  PostModel({
    this.avatarUrl = "",
    this.userName = "",
    this.postStr = "",
    this.replies = 0,
    this.likes = 0,
    this.followers = 0,
    this.postChecked = false,
    this.postImagesUrl,
    DateTime? postTime,
    this.tagPostInfo,
    this.replyPostInfo,
    this.visibleEllipse = true,
    this.visiblePostTime = true,
  }) : postTime = postTime ?? DateTime.now();

  final String avatarUrl; // = "";
  final String userName; // = "";
  final String postStr; // = "";
  final int replies; // = 0;
  final int likes; // = 0;
  final int followers; // = 0;
  final bool postChecked; // = false;
  final DateTime postTime; // = DateTime.now();
  final List<String>? postImagesUrl; // = [];
  final PostModel? tagPostInfo; //;
  final PostModel? replyPostInfo; //;
  final bool visiblePostTime;
  final bool visibleEllipse;
}
