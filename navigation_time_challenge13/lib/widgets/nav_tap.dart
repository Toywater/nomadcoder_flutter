import 'package:flutter/material.dart';
import 'package:navigation_time_challenge12/constants/gaps.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';

class NavTap extends StatelessWidget {
  const NavTap({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.visibleText = false,
  });

  final IconData icon;
  final String text;
  final bool isSelected;
  final Function onTap;
  final bool visibleText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: Colors.transparent,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 100),
            opacity: isSelected ? 1 : 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: Sizes.size32,
                ),
                if (visibleText) Gaps.v5,
                if (visibleText)
                  Text(
                    text,
                    // style: TextStyle(
                    //   color: isSelected ? Colors.black : Colors.grey.shade600,
                    // ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
