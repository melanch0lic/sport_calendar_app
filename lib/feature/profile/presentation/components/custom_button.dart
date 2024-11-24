import 'package:flutter/material.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.name,
    required this.textColor,
    this.colorBorder,
    required this.backColor,
  });

  final String name;
  final Color textColor;
  final Color? colorBorder;
  final Color backColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: FilledButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backColor,
          side: BorderSide(color: colorBorder ?? Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Center(
          child: Text(
            name,
            style: CommonTextStyles().body.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
          ),
        ),
      ),
    );
  }
}
