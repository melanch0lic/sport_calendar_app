import 'package:flutter/material.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/core/utils/text_field_outline_border.dart';

class CategoryAge extends StatelessWidget {
  const CategoryAge({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Возрастная категория',
          style: CommonTextStyles().body.copyWith(color: const Color.fromRGBO(107, 110, 117, 1)),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: 'От',
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
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextField(
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: 'До',
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
            ),
          ],
        ),
        const SizedBox(height: 36),
      ],
    );
  }
}
