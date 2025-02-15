import 'package:flutter/material.dart';
import 'package:navigation_time_challenge12/constants/gaps.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).canvasColor, // Colors.white,
      child: Column(
        children: [
          Gaps.v10,
          TabBar(
            // dividerColor: Colors.transparent,
            // indicatorColor: Colors.black,
            // indicator: ,
            labelPadding: EdgeInsets.only(bottom: Sizes.size10),
            indicatorSize: TabBarIndicatorSize.tab,
            // labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: Sizes.size20, fontWeight: FontWeight.bold),
            // unselectedLabelColor: Colors.grey,
            tabs: [
              Text("Threads"),
              Text("Replies"),
            ],
          ),
          // Gaps.v10,
          // Divider(
          //   height: Sizes.size1,
          //   // color: Colors.grey.shade300,
          // ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
