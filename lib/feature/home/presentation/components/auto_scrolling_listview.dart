import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sport_calendart_app/feature/home/bloc_event/event_bloc.dart';
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

        final nextIndex = ((currentScrollPosition + cardWidth / 2) ~/ (cardWidth + cardSpacing)) + 1;

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
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventLoading) {
            return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16).copyWith(bottom: 20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                          ),
                        ));
                  },
                ));
          } else if (state is EventLoaded) {
            return ListView.separated(
              controller: _scrollController,
              itemCount: state.events.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: UpcomingCompetitonsCard(event: state.events[index]),
                );
              },
            );
          } else if (state is EventError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
