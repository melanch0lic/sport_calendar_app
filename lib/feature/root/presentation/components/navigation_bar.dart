import 'package:flutter/material.dart';

import '../../../../core/resources/assets.gen.dart';
import '../../../../core/utils/extension/extensions.dart';
import '../bottom_navigation_scope.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: context.theme.commonColors.neutralgrey10.withOpacity(.2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      height: 80 + bottomPadding,
      child: Column(
        children: [
          const Divider(
            color: Color.fromRGBO(236, 239, 243, 1),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Material(
              color: Colors.white,
              child: SizedBox(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavBarItem(
                      onTap: (index) => BottomNavigationScope.change(context, index),
                      index: 0,
                      currentIndex: currentIndex,
                      asset: Assets.navBar.home,
                    ),
                    _NavBarItem(
                      onTap: (index) => BottomNavigationScope.change(context, index),
                      index: 1,
                      currentIndex: currentIndex,
                      asset: Assets.navBar.calendar,
                    ),
                    _NavBarItem(
                      onTap: (index) => BottomNavigationScope.change(context, index),
                      index: 2,
                      currentIndex: currentIndex,
                      asset: Assets.navBar.profile,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.index,
    required this.currentIndex,
    required this.onTap,
    required this.asset,
  });

  final int index;
  final int currentIndex;
  final SvgGenImage asset;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;
    return InkWell(
      onTap: () => onTap(index),
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: Ink(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? colors.indigo.withOpacity(0.1) : colors.neutralgrey3,
        ),
        padding: const EdgeInsets.all(15),
        child: asset.svg(
          width: 24,
          colorFilter: ColorFilter.mode(
            isSelected ? colors.indigo : colors.darkGrey30,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
