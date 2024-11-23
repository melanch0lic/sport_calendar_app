import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/upcoming_competitons_card.dart';

class AutoScrollingListView extends StatefulWidget {
  const AutoScrollingListView({super.key});

  @override
  State<AutoScrollingListView> createState() => _AutoScrollingListViewState();
}

class _AutoScrollingListViewState extends State<AutoScrollingListView> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      final double cardWidth = MediaQuery.of(context).size.width * 0.85;
      const double cardSpacing = 12;
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final currentScrollPosition = _scrollController.offset;

        // Вычисляем индекс следующей карточки
        final nextIndex = ((currentScrollPosition + cardWidth / 2) ~/ (cardWidth + cardSpacing)) + 1;

        // Если дошли до конца списка, возвращаемся к началу
        if (currentScrollPosition >= maxScrollExtent) {
          _scrollController.jumpTo(0);
        } else {
          final targetOffset =
              nextIndex * (cardWidth + cardSpacing) - (MediaQuery.of(context).size.width / 2 - cardWidth / 2);
          _scrollController.animateTo(
            targetOffset.clamp(0.0, maxScrollExtent), // Учитываем границы
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        controller: _scrollController,
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: const UpcomingCompetitonsCard(),
          );
        },
      ),
    );
  }
}
