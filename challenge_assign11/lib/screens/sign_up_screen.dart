import 'package:challenge_assign11/constants/gaps.dart';
import 'package:challenge_assign11/constants/sizes.dart';
import 'package:challenge_assign11/models/create_user_model.dart';
import 'package:challenge_assign11/screens/sent_code_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  final CreateUserModel _userInfo;
  const SignUpScreen({super.key, required CreateUserModel userInfo}) : _userInfo = userInfo;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();

  void onSignUpTab() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SentCodeScreen(userInfo: widget._userInfo),
    ));
  }

  @override
  void initState() {
    _nameController.text = widget._userInfo.name;
    _emailController.text = widget._userInfo.email;
    if (widget._userInfo.birth != null) {
      DateFormat dtForm = DateFormat("yyyy / MM / dd");
      _birthController.text = dtForm.format(widget._userInfo.birth!);
    } else {
      _birthController.text = "";
    }

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthController.dispose();

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
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v20,
                Text(
                  "Create your account",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Sizes.size32, fontWeight: FontWeight.w900),
                ),
                Gaps.v32,
                TextField(
                  controller: _nameController,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: "Name",
                      suffixIcon: FaIcon(
                        FontAwesomeIcons.solidCircleCheck,
                        size: Sizes.size24,
                      ),
                      suffixIconColor: Colors.green),
                ),
                Gaps.v28,
                TextField(
                  controller: _emailController,
                  readOnly: true,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: "Email",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      suffixIcon: FaIcon(
                        FontAwesomeIcons.solidCircleCheck,
                        size: Sizes.size24,
                      ),
                      suffixIconColor: Colors.green),
                ),
                Gaps.v28,
                TextField(
                  controller: _birthController,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: "Date of birth",
                      suffixIcon: FaIcon(
                        FontAwesomeIcons.solidCircleCheck,
                        size: Sizes.size24,
                      ),
                      suffixIconColor: Colors.green),
                ),
                Gaps.v52,
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
                      TextSpan(text: "like keeping your account secure and personalizing our services, including ads.", style: TextStyle(fontSize: Sizes.size20)),
                      TextSpan(text: "Learn more. ", style: TextStyle(fontSize: Sizes.size20, color: Colors.blue)),
                      TextSpan(text: "Others will be able to find you by email or phone number, when provided, unless you choose otherwise", style: TextStyle(fontSize: Sizes.size20)),
                      TextSpan(text: "here.", style: TextStyle(fontSize: Sizes.size20, color: Colors.blue)),
                    ],
                  ),
                ),
              ],
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
              onPressed: () => onSignUpTab(),
              child: Text("Sign up", style: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}
