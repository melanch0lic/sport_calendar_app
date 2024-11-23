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
        boxShadow: [
          BoxShadow(
            color: context.theme.commonColors.neutralgrey10.withOpacity(.2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      height: 56 + 20 + bottomPadding,
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.commonColors.white,
        ),
        padding: EdgeInsets.only(bottom: bottomPadding),
        margin: const EdgeInsets.only(top: 20),
        child: Material(
          color: context.theme.commonColors.white,
          child: SizedBox(
            height: 64,
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
                  asset: Assets.navBar.search,
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
    final colors = context.theme.commonColors;
    final isSelected = index == currentIndex;
    return InkWell(
      onTap: () => onTap(index),
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: Ink(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? colors.indigo.withOpacity(0.1) : colors.neutralgrey3,
        ),
        padding: const EdgeInsets.all(12),
        child: asset.svg(
          colorFilter: ColorFilter.mode(
            isSelected ? colors.indigo : colors.darkGrey30,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
