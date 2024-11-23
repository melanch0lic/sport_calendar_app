part of 'app_theme.dart';

class CommonTextStyles {
  final largeTitle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    //height: 32 / 26,
  );
  final smallTitle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  final buttonText = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(29, 31, 36, 1),
  );
  final title2 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(29, 31, 36, 1),
  );

  final cardTitle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  final cardBody = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  final cardName = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  final headline1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: _commonColors.darkGrey100,
    height: 32 / 24,
    fontFamily: _typography.tbcxBoldFont,
  );

  final headline2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: _commonColors.darkGrey100,
    height: 28 / 18,
    fontFamily: _typography.tbcxBoldFont,
  );

  final headline3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: _commonColors.darkGrey100,
    height: 24 / 16,
    fontFamily: _typography.tbcxBoldFont,
  );

  final title1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: _commonColors.darkGrey100,
    height: 28 / 20,
    fontFamily: _typography.tbcxMediumFont,
  );

  final title3 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: _commonColors.darkGrey100,
    height: 21 / 15,
    fontFamily: _typography.tbcxMediumFont,
  );

  final body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: _commonColors.darkGrey100,
  );

  final body1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: _commonColors.darkGrey100,
    height: 20 / 14,
    fontFamily: _typography.tbcxRegularFont,
  );

  final body2 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: _commonColors.darkGrey100,
    height: 16 / 12,
    fontFamily: _typography.tbcxRegularFont,
  );

  final label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: _commonColors.darkGrey100,
    height: 20 / 14,
    fontFamily: _typography.tbcxMediumFont,
  );

  final rangeTextFieldLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: _commonColors.darkGrey30,
    height: 16 / 14,
    fontFamily: _typography.tbcxRegularFont,
  );
}
