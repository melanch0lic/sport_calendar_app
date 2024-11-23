
import 'package:flutter/material.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';

class RefreshCode extends StatelessWidget {
  const RefreshCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Не пришёл код?',
            style: CommonTextStyles().body.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              ' Отправить еще раз',
              style: CommonTextStyles().body.copyWith(
                  fontSize: 16,
                  color: const Color.fromRGBO(67, 84, 250, 1),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
