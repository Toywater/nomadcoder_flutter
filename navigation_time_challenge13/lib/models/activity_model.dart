import 'dart:core';

enum ActivityMode { replies, mentions, verified, following }

class ActivityModel {
  String avatarUrl = "";
  String userName = "";
  String activeStr = "";
  String dispStr = "";
  DateTime postTime = DateTime.now();
  ActivityMode activityMode = ActivityMode.replies;
}
