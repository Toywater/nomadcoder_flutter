import 'package:challenge_assign11/constants/sizes.dart';
import 'package:flutter/material.dart';

class SelectButton extends StatefulWidget {
  const SelectButton({
    super.key,
    required this.detailItem,
  });

  final String detailItem;

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  bool _isSelected = false;

  void onSelectTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelectTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size20, vertical: Sizes.size10),
        decoration: BoxDecoration(
          color: _isSelected ? Color(0xFF4A98E9) : Colors.transparent,
          border: Border.all(width: 1, color: _isSelected ? Colors.transparent : Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(Sizes.size20)),
        ),
        child: Text(
          widget.detailItem,
          style: TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
            color: _isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
      // child: Text("TEST"),
    );
  }
}
