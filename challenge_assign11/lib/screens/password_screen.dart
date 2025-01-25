import 'package:challenge_assign11/constants/gaps.dart';
import 'package:challenge_assign11/constants/sizes.dart';
import 'package:challenge_assign11/models/create_user_model.dart';
import 'package:challenge_assign11/screens/want_to_twitter_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key, required CreateUserModel userInfo}) : _userInfo = userInfo;

  final CreateUserModel _userInfo;

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isPasswordValid = false;

  void _onObscureTap() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _onPasswordChange(String password) {
    setState(() {
      _isPasswordValid = (password.isNotEmpty && password.length >= 8);
    });
  }

  void onNextTab() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => WantToTwitterScreen(),
    ));
  }

  @override
  void initState() {
    _passwordController.addListener(
      () => setState(() {}),
    );

    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
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
              "You'll need a password",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: Sizes.size32, fontWeight: FontWeight.w900),
            ),
            Gaps.v20,
            Text("Make sure it's 8 characters or more", style: TextStyle(fontSize: Sizes.size20, color: Colors.black54)),
            Gaps.v52,
            TextField(
              autocorrect: false,
              controller: _passwordController,
              obscureText: _isObscure,
              onChanged: _onPasswordChange,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _onObscureTap,
                      child: FaIcon(
                        _isObscure ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                        color: _isObscure ? Colors.grey : Colors.blue,
                      ),
                    ),
                    Gaps.h10,
                    Visibility(
                        visible: _isPasswordValid,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Colors.green,
                        ))
                  ],
                ),
                hintText: 'Password',
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
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
                  onPressed: _isPasswordValid ? onNextTab : null,
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
