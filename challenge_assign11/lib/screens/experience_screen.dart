import 'dart:ui';

import 'package:challenge_assign11/constants/gaps.dart';
import 'package:challenge_assign11/constants/sizes.dart';
import 'package:challenge_assign11/models/create_user_model.dart';
import 'package:challenge_assign11/screens/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExperienceScreen extends StatefulWidget {
  final CreateUserModel _userInfo;
  const ExperienceScreen({super.key, required CreateUserModel userInfo}) : _userInfo = userInfo;

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: FaIcon(FontAwesomeIcons.twitter, color: Colors.blue, size: Sizes.size36),
        backgroundColor: Colors.transparent,
      ),
      body: Scrollbar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size44),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Gaps.v24,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Customize your experience",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: Sizes.size32, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  Gaps.v28,
                  Text(
                    "Track where you see Twitter content across the web",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: Sizes.size24, fontWeight: FontWeight.w800),
                  ),
                  Gaps.v10,
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, or phone number.",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 20,
                          style: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      CupertinoSwitch(
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = !_isChecked;
                            });
                          })
                    ],
                  ),
                  Gaps.v32,
                  Text.rich(
                    textAlign: TextAlign.start,
                    TextSpan(
                      children: [
                        TextSpan(text: "By signing up, you agree to our ", style: TextStyle(fontSize: Sizes.size20)),
                        TextSpan(text: "Terms,", style: TextStyle(fontSize: Sizes.size20, color: Colors.blue)),
                        TextSpan(text: "Privacy Policy", style: TextStyle(fontSize: Sizes.size20, color: Colors.blue)),
                        TextSpan(text: ", and ", style: TextStyle(fontSize: Sizes.size20)),
                        TextSpan(text: "Cookie Use.", style: TextStyle(fontSize: Sizes.size20, color: Colors.blue)),
                        TextSpan(
                            text: "Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy.",
                            style: TextStyle(fontSize: Sizes.size20)),
                        TextSpan(text: "Learn more", style: TextStyle(fontSize: Sizes.size20, color: Colors.blue)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: FractionallySizedBox(
            widthFactor: 1,
            child: CupertinoButton.filled(
              disabledColor: Colors.grey.shade400,
              onPressed: _isChecked
                  ? () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen(userInfo: widget._userInfo)));
                    }
                  : null,
              child: Text("Next", style: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}
