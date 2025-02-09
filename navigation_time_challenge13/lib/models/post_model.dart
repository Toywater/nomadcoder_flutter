import 'dart:core';

class PostModel {
  String avatarUrl = "";
  String userName = "";
  String postStr = "";
  int replies = 0;
  int likes = 0;
  int followers = 0;
  bool postChecked = false;
  DateTime postTime = DateTime.now();
  List<String> postImagesUrl = [];
}
