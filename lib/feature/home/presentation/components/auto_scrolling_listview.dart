import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sport_calendart_app/feature/home/bloc_event/event_bloc.dart';
import 'package:sport_calendart_app/feature/home/presentation/components/upcoming_competitons_card.dart';

enum AutoScrollDirection { forward, backward }

class AutoScrollingListView extends StatefulWidget {
  const AutoScrollingListView({super.key});

  @override
  State<AutoScrollingListView> createState() => _AutoScrollingListViewState();
}

class _AutoScrollingListViewState extends State<AutoScrollingListView> {
  final PageController _pageController = PageController(viewportFraction: 0.8, initialPage: 1);

  late AutoScrollDirection _autoScrollDirection;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _autoScrollDirection = AutoScrollDirection.forward;
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_pageController.hasClients) {
        final minScrollExtent = _pageController.position.minScrollExtent;
        final maxScrollExtent = _pageController.position.maxScrollExtent;
        final currentScrollPosition = _pageController.offset;

        if (currentScrollPosition <= minScrollExtent) {
          _autoScrollDirection = AutoScrollDirection.forward;
          _pageController.animateToPage(
            _pageController.page!.toInt() + 1,
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeInOut,
          );
        } else if (currentScrollPosition >= maxScrollExtent) {
          _autoScrollDirection = AutoScrollDirection.backward;
          _pageController.animateToPage(
            _pageController.page!.toInt() - 1,
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.animateToPage(
            _pageController.page!.toInt() + (_autoScrollDirection == AutoScrollDirection.forward ? 1 : -1),
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
    _pageController.dispose();
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
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16).copyWith(bottom: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                    );
                  },
                ));
          } else if (state is EventLoaded) {
            return PageView.builder(
              controller: _pageController,
              itemCount: state.events.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: MediaQuery.of(context).size.width * 0.85,
                  child:
                      UpcomingCompetitonsCard(key: ValueKey(state.events[index].eventId), event: state.events[index]),
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
