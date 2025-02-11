import 'dart:core';

enum ActivityMode { none, replies, mentions, verified, following }

class ActivityModel {
  ActivityModel({
    this.avatarUrl = "",
    this.userName = "",
    this.activeStr = "",
    this.dispStr = "",
    DateTime? postTime,
    this.activityMode = ActivityMode.none,
  }) : postTime = postTime ?? DateTime.now();

  final String avatarUrl;
  final String userName;
  final String activeStr;
  final String dispStr;
  final DateTime postTime;
  final ActivityMode activityMode;
}
