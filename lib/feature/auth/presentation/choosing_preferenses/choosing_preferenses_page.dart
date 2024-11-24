import 'package:flutter/material.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';
import 'package:sport_calendart_app/feature/auth/presentation/choosing_preferenses/components/category_age.dart';
import 'package:sport_calendart_app/feature/auth/presentation/choosing_preferenses/components/preferenses_text_field.dart';

class ChoosingPreferensesPage extends StatelessWidget {
  const ChoosingPreferensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(alignment: Alignment.topRight, child: Image.asset('assets/images/bubbles.png')),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 120),
                            child: Text(
                              'Выбор предпочтений',
                              textAlign: TextAlign.center,
                              style: CommonTextStyles().largeTitle.copyWith(color: const Color.fromRGBO(29, 31, 36, 1)),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Укажите интересующие вас виды спорта,\nдисциплины, города или регионы проведения\nсостязаний, а также пол и возрастную категорию\nспортсмена, чтобы мы могли рекомендовать\nвам подходящие соревнования.',
                            style: CommonTextStyles().body.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                          ),
                          const SizedBox(height: 36),
                          const PreferensesTextField(name: 'Вид спорта и дисциплины'),
                          const PreferensesTextField(name: 'Место проведения'),
                          const PreferensesTextField(name: 'Пол'),
                          const CategoryAge(),
                          SizedBox(
                            height: 48,
                            child: FilledButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(67, 84, 250, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {},
                              child: Center(
                                child: Text(
                                  'Далее',
                                  style: CommonTextStyles().body.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 48,
                            child: FilledButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(color: Color.fromRGBO(211, 213, 218, 1)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {},
                              child: Center(
                                child: Text(
                                  'Пропустить',
                                  style: CommonTextStyles().body.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromRGBO(29, 31, 36, 1),
                                      ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 36),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
