import 'package:flutter/material.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/core/utils/text_field_outline_border.dart';

class PreferensesTextField extends StatelessWidget {
  const PreferensesTextField({
    super.key,
    required this.name,
  });

  final String name;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: CommonTextStyles().body.copyWith(color: const Color.fromRGBO(107, 110, 117, 1)),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Не выбран',
              suffixIcon: GestureDetector(
                  onTap: () {}, child: const Icon(Icons.keyboard_arrow_down, color: Color.fromRGBO(107, 110, 117, 1))),
              hintStyle: CommonTextStyles().body.copyWith(color: const Color.fromRGBO(211, 213, 218, 1)),
              border: TextFieldOutlineBorder(
                scheme: theme.colorScheme,
              ),
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
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
