import 'package:challenge_assign11/constants/gaps.dart';
import 'package:challenge_assign11/constants/sizes.dart';
import 'package:challenge_assign11/widgets/select_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WantToTwitterDetailScreen extends StatefulWidget {
  const WantToTwitterDetailScreen({super.key, required this.selectedInterests});

  final List<String> selectedInterests;

  @override
  State<WantToTwitterDetailScreen> createState() => _WantToTwitterDetailScreenState();
}

class _WantToTwitterDetailScreenState extends State<WantToTwitterDetailScreen> {
  // 세부 항목 Map
  final Map<String, List<String>> _interestsDetailMap = {
    "Music": ["Pop", "Rock", "Hip hop", "R&B & soul", "Classical", "Country", "Jazz", "EDM", "K-pop", "Metal"],
    "Entertainment": ["Movies", "TV shows", "Anime", "Netflix Originals", "Documentaries", "Marvel Universe", "DC Universe", "Fantasy"],
    "Sports": ["Soccer", "Basketball", "Baseball", "Tennis", "eSports", "Olympic Games"],
    "News & Politics": ["International News", "National News", "Local News", "Political Commentary"],
    "Gaming": ["PC Gaming", "Console Gaming", "Mobile Gaming"],
    "Lifestyle": ["Travel", "Food & Cooking", "Fashion", "Health & Fitness", "Technology"],
    "Science & Nature": ["Space & Astronomy", "Environmental Issues", "Wildlife", "Science News"],
  };

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
              "Interests are used to personalize your experience and will be visible on your profile",
              style: TextStyle(fontSize: Sizes.size20, color: Colors.black54),
            ),
            Gaps.v32,
            Divider(
              height: Sizes.size1,
            ),
            Gaps.v32,
            Expanded(
              flex: 1,
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 먼저 앞 화면에서 선택된 항목 표시
                      for (var selItem in widget.selectedInterests)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.v20,
                            Text(selItem, style: TextStyle(fontSize: Sizes.size24, fontWeight: FontWeight.w900)),
                            Gaps.v20,
                            // 세부 선택 목록 표시
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: 700,
                                child: Wrap(
                                  verticalDirection: VerticalDirection.down,
                                  runSpacing: Sizes.size12,
                                  spacing: Sizes.size12,
                                  direction: Axis.horizontal,
                                  children: [
                                    for (var detailItem in _interestsDetailMap[selItem]!) SelectButton(detailItem: detailItem),
                                  ],
                                ),
                              ),
                            ),
                            Gaps.v20,
                            Divider(height: Sizes.size1),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
          child: CupertinoButton.filled(
            disabledColor: Colors.grey.shade400,
            onPressed: () {},
            child: Text("Next", style: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
