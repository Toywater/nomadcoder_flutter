import 'package:challenge_assign11/constants/gaps.dart';
import 'package:challenge_assign11/constants/sizes.dart';
import 'package:challenge_assign11/screens/create_account_screen.dart';
import 'package:challenge_assign11/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void onCreateAccountTap() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAccountScreen()));
  }

  void onLoginTap() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: SafeArea(
          child: Column(
            children: [
              Gaps.v24,
              FaIcon(FontAwesomeIcons.twitter, color: Colors.blue, size: Sizes.size52),
              SizedBox(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "See what's happening in the world right now.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Sizes.size32, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              Gaps.v28,
              GestureDetector(
                onTap: onCreateAccountTap,
                child: Container(
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.symmetric(horizontal: Sizes.size72, vertical: Sizes.size16),
                  child: Text(
                    "Create account",
                    style: TextStyle(fontSize: Sizes.size24, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
          child: Row(
            children: [
              Text("Have an account already?", style: TextStyle(fontSize: Sizes.size20)),
              Gaps.h10,
              GestureDetector(onTap: onLoginTap, child: Text("Log in", style: TextStyle(fontSize: Sizes.size20, color: Colors.blue))),
            ],
          ),
        ),
      ),
    );
  }
}
