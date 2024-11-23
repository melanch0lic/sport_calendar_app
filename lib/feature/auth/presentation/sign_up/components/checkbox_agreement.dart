
import 'package:flutter/material.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';

class CheckboxAgreement extends StatefulWidget {
  const CheckboxAgreement({super.key});

  @override
  State<CheckboxAgreement> createState() => _CheckboxAgreementState();
}

bool isChecked = false;

class _CheckboxAgreementState extends State<CheckboxAgreement> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.translate(
          offset: const Offset(0, 3),
          child: SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              activeColor: const Color.fromRGBO(67, 84, 250, 1),
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // Rounded corners
              ),
              side: WidgetStateBorderSide.resolveWith(
                (states) => BorderSide(
                  color: states.contains(WidgetState.selected)
                      ? const Color.fromRGBO(67, 84, 250, 1)
                      : const Color.fromRGBO(211, 213, 218, 1),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Нажимая на “Создать аккаунт”, вы\nпринимаете',
                  style: CommonTextStyles().body.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                ),
                TextSpan(
                  text: ' Пользовательское\nсоглашение',
                  style: CommonTextStyles().body.copyWith(
                        fontSize: 16,
                        color: const Color.fromRGBO(67, 84, 250, 1),
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
