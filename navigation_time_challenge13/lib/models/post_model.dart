import 'dart:core';
import 'package:flutter/material.dart';

class PostModel {
  ImageProvider? avatarImage;
  String userName = "";
  String postStr = "";
  int replies = 0;
  int likes = 0;
  bool postChecked = false;
  DateTime postTime = DateTime.now();
  List<String> postImagesUrl = [];
}
