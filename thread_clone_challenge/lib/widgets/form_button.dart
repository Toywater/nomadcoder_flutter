import 'package:flutter/material.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.isDisabled,
    required this.displayText,
  });

  final bool isDisabled;
  final String displayText;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(vertical: Sizes.size12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size5),
          color: isDisabled ? Colors.grey.shade200 : Theme.of(context).primaryColor,
        ),
        duration: Duration(milliseconds: 300),
        alignment: Alignment.center,
        child: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 300),
          style: TextStyle(
            color: isDisabled ? Colors.grey.shade400 : Colors.white,
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
          ),
          child: Text(
            displayText,
          ),
        ),
      ),
    );
  }
}
