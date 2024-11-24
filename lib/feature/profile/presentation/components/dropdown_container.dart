import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sport_calendart_app/core/theme/app_theme.dart';

class DropdownContainer extends StatefulWidget {
  const DropdownContainer({
    super.key,
    required this.name,
    required this.content,
  });

  final String name;
  final Widget content;

  @override
  State<DropdownContainer> createState() => _DropdownContainerState();
}

bool isExpanded = false;

class _DropdownContainerState extends State<DropdownContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: CommonTextStyles().title2.copyWith(fontSize: 20),
                ),
                RotatedBox(
                  quarterTurns: isExpanded ? 2 : 0,
                  child: SvgPicture.asset('assets/icons/down_arrow.svg'),
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: widget.content,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
