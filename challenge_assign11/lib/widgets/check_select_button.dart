import 'package:challenge_assign11/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckSelectButton extends StatefulWidget {
  const CheckSelectButton({super.key, required this.dispText, required this.onTap});

  final String dispText;
  final Function(String dispText, bool selectState) onTap;

  @override
  State<CheckSelectButton> createState() => _CheckSelectButtonState();
}

class _CheckSelectButtonState extends State<CheckSelectButton> {
  bool _isSelected = false;

  void onTap() {
    _isSelected = !_isSelected;

    setState(() {
      // 부모 위젯으로 상태 변경 함수 호출
      widget.onTap(widget.dispText, _isSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Sizes.size10),
        decoration: BoxDecoration(
          color: _isSelected ? Color(0xFF4A98E9) : Colors.transparent,
          borderRadius: BorderRadius.circular(Sizes.size16),
          border: Border.all(color: Colors.black26),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    widget.dispText,
                    style: TextStyle(
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.bold,
                      color: _isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: _isSelected,
                  child: FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: Sizes.size20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
