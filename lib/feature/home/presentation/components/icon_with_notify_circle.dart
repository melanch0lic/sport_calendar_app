import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconWithNotifyCircle extends StatelessWidget {
  const IconWithNotifyCircle({
    super.key,
    required this.icon,
  });

  final String icon;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          icon,
        ),
        Positioned(
          top: -7,
          right: -3,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
