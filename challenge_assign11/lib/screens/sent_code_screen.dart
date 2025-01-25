import 'package:challenge_assign11/constants/gaps.dart';
import 'package:challenge_assign11/constants/sizes.dart';
import 'package:challenge_assign11/models/create_user_model.dart';
import 'package:challenge_assign11/screens/password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SentCodeScreen extends StatefulWidget {
  const SentCodeScreen({super.key, required userInfo}) : _userInfo = userInfo;

  final CreateUserModel _userInfo;

  @override
  State<SentCodeScreen> createState() => _SentCodeScreenState();
}

class _SentCodeScreenState extends State<SentCodeScreen> {
  bool _isOk = false;

  void _onVerifyCompleted(String value) {
    _isOk = true;
    setState(() {});
  }

  void _onVerifyEditing(bool editing) {
    if (editing) _isOk = false;
    setState(() {});
  }

  void onNextTab() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PasswordScreen(userInfo: widget._userInfo),
    ));
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v20,
            Text(
              "We sent you a code",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: Sizes.size32, fontWeight: FontWeight.w900),
            ),
            Gaps.v20,
            Text("Enter it below to verify", style: TextStyle(fontSize: Sizes.size20, color: Colors.black54)),
            Text(widget._userInfo.email, style: TextStyle(fontSize: Sizes.size20, color: Colors.black54)),
            Gaps.v52,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VerificationCode(
                  digitsOnly: true,
                  onCompleted: _onVerifyCompleted,
                  onEditing: _onVerifyEditing,
                  keyboardType: TextInputType.number,
                  underlineWidth: 2,
                  length: 6,
                ),
              ],
            ),
            Gaps.v20,
            Visibility(
              visible: _isOk,
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.solidCircleCheck,
                  size: Sizes.size32,
                  color: Colors.green,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Didn't receive email?",
                    style: TextStyle(fontSize: Sizes.size20, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: Column(
            children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: CupertinoButton.filled(
                  disabledColor: Colors.grey.shade400,
                  onPressed: _isOk ? () => onNextTab() : null,
                  child: Text("Next", style: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
