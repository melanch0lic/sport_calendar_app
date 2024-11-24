import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';

class ProfileDropdown extends StatelessWidget {
  const ProfileDropdown({
    super.key,
    required this.name,
  });

  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: CommonTextStyles().title2.copyWith(fontSize: 20),
          ),
          GestureDetector(
            child: SvgPicture.asset('assets/icons/down_arrow.svg'),
          )
        ],
      ),
    );
  }
}
