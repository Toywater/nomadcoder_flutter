import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time_challenge12/constants/gaps.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';

enum EllipseViewState { selectState, unfollow, mute, hide, report }

class EllipseMenus extends StatefulWidget {
  // 화면이 뜰 때마다 선택 화면으로 전환하기 위함
  EllipseMenus({super.key, EllipseViewState viewState = EllipseViewState.selectState}) : _viewState = viewState;

  // 화면 보여주는 상태
  EllipseViewState _viewState = EllipseViewState.selectState;

  @override
  State<EllipseMenus> createState() => _EllipseMenusState();
}

class _EllipseMenusState extends State<EllipseMenus> {
  void _onTap(EllipseViewState viewState) {
    setState(() {
      widget._viewState = viewState;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget._viewState) {
      case EllipseViewState.unfollow:
      case EllipseViewState.mute:
      case EllipseViewState.hide:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size16, vertical: Sizes.size14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.size20), topRight: Radius.circular(Sizes.size20)),
          ),
          child: Row(
            children: [
              Text("${widget._viewState}"),
            ],
          ),
        );
      case EllipseViewState.report:
        return _reportView();
      default:
        return _selectStateView();
    }
  }

  // 메뉴 뷰
  Widget _selectStateView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.size16, vertical: Sizes.size14),
      decoration: BoxDecoration(
        // color: Colors.white,
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.size20), topRight: Radius.circular(Sizes.size20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Unfollow
          GestureDetector(
            onTap: () => _onTap(EllipseViewState.unfollow),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Sizes.size16, horizontal: Sizes.size20),
              decoration: BoxDecoration(
                // color: Colors.grey.shade100,
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.size24), topRight: Radius.circular(Sizes.size24)),
              ),
              child: Row(children: [Text("Unfollow", style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600))]),
            ),
          ),
          Divider(
            thickness: Sizes.size1,
            height: 0,
          ),
          // Mute
          GestureDetector(
            onTap: () => _onTap(EllipseViewState.mute),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: Sizes.size16, horizontal: Sizes.size20),
                decoration: BoxDecoration(
                  // color: Colors.grey.shade100,
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Sizes.size24), bottomRight: Radius.circular(Sizes.size24)),
                ),
                child: Row(children: [Text("Mute", style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600))])),
          ),
          Gaps.v10,
          // Hide
          GestureDetector(
            onTap: () => _onTap(EllipseViewState.hide),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Sizes.size16, horizontal: Sizes.size20),
              decoration: BoxDecoration(
                // color: Colors.grey.shade100,
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.size24), topRight: Radius.circular(Sizes.size24)),
              ),
              child: Row(children: [Text("Hide", style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600))]),
            ),
          ),
          // Report
          Divider(
            thickness: Sizes.size1,
            height: 0,
          ),
          GestureDetector(
            onTap: () => _onTap(EllipseViewState.report),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: Sizes.size16, horizontal: Sizes.size20),
                decoration: BoxDecoration(
                  // color: Colors.grey.shade100,
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Sizes.size24), bottomRight: Radius.circular(Sizes.size24)),
                ),
                child: Row(children: [Text("Report", style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600))])),
          ),
        ],
      ),
    );
  }

  // Report View
  Widget _reportView() {
    List<String> itemList = [
      "I just don't like it",
      "It's unlawful content under NetzDG",
      "It's spam",
      "hate speech or symbols",
      "Nudity or sexual activity",
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.symmetric(horizontal: Sizes.size18, vertical: Sizes.size14),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.size20), topRight: Radius.circular(Sizes.size20)),
      ),
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: Sizes.size20,
          surfaceTintColor: Colors.transparent,
          // backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: Sizes.size18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
          // titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(fontWeight: FontWeight.bold),
          centerTitle: true,
          title: Text("Report"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Sizes.size6,
            children: [
              Divider(thickness: 1),
              Text("Why are you reporting this thread?", style: TextStyle(fontSize: Sizes.size18, fontWeight: FontWeight.bold)),
              Text(
                softWrap: true,
                "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.",
                style: TextStyle(fontSize: Sizes.size16, color: Colors.grey.shade400),
              ),
              Divider(thickness: 1),
              Expanded(
                child: ListView.separated(
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: Sizes.size40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              itemList[index],
                              style: TextStyle(fontSize: Sizes.size16),
                            ),
                            FaIcon(
                              FontAwesomeIcons.chevronRight,
                              size: Sizes.size16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
