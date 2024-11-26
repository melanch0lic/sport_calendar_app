import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';

import '../../../../core/resources/assets.gen.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SvgPicture.asset(Assets.icons.search.path),
          ),
          hintText: 'Поиск',
          hintStyle: CommonTextStyles().body.copyWith(color: const Color.fromRGBO(211, 213, 218, 1)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 1, color: Color.fromRGBO(211, 213, 218, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromRGBO(67, 84, 250, 1),
            ),
          ),
        ),
      ),
    );
  }
}
