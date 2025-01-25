import 'package:challenge_assign11/constants/gaps.dart';
import 'package:challenge_assign11/constants/sizes.dart';
import 'package:challenge_assign11/screens/want_to_twitter_detail_screen.dart';
import 'package:challenge_assign11/widgets/check_select_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WantToTwitterScreen extends StatefulWidget {
  const WantToTwitterScreen({super.key});

  @override
  State<WantToTwitterScreen> createState() => _WantToTwitterScreenScreenState();
}

class _WantToTwitterScreenScreenState extends State<WantToTwitterScreen> {
  final List<String> _interestList = [
    "Music",
    "Entertainment",
    "Sports",
    "News & Politics",
    "Gaming",
    "Lifestyle",
    "Science & Nature",
  ];

  final List<String> _selectedInterest = [];

  void _onInterestTap(String dispText, bool selectState) {
    setState(() {
      // 선택되어 있으면
      if (selectState && _selectedInterest.contains(dispText) == false) {
        _selectedInterest.add(dispText);
      } // 선택되어 있지 않은 경우
      else if (selectState == false && _selectedInterest.contains(dispText)) {
        _selectedInterest.remove(dispText);
      }
    });
  }

  void _onNextTab() {
    Navigator.of(context).push(MaterialPageRoute(
      // 선택된 항목 리스트 전송
      builder: (context) => (WantToTwitterDetailScreen(selectedInterests: _selectedInterest)),
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
              "What do you want to see on Twitter?",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: Sizes.size32, fontWeight: FontWeight.w900),
            ),
            Gaps.v20,
            Text(
              "Select at least 3 interests to personalize your Twitter experienc. They will be visible on your profile",
              style: TextStyle(fontSize: Sizes.size20, color: Colors.black54),
            ),
            Gaps.v32,
            Divider(
              height: Sizes.size1,
            ),
            Gaps.v32,
            Expanded(
              flex: 1,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.8,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                children: [
                  for (var value in _interestList) CheckSelectButton(dispText: value, onTap: _onInterestTap),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Great work or selected count
              Text(
                _selectedInterest.length >= 3 ? "Great work 🎉" : "${_selectedInterest.length} of 3 selected",
                style: TextStyle(fontSize: Sizes.size20, color: Colors.black54),
              ),

              CupertinoButton.filled(
                disabledColor: Colors.grey.shade400,
                onPressed: (_selectedInterest.length >= 3) ? _onNextTab : null,
                child: Text("Next", style: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
