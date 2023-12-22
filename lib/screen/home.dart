import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widget/home_sections.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController pageController = PageController();
  bool isScrolling = false;
  bool isTouching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.link),
        actions: const [
          TextButton(onPressed: null, child: Text("Home")),
          TextButton(onPressed: null, child: Text("About")),
          TextButton(onPressed: null, child: Text("Portfolio")),
          TextButton(onPressed: null, child: Text("Workshop")),
          TextButton(onPressed: null, child: Text("Contact")),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            if (!isTouching) {
              isTouching = true;
              !isScrolling ? _onScroll(details.delta.dy * -1) : null;
            }
          },
          onPanEnd: (_) => isTouching = false,
          onPanCancel: () => isTouching = false,
          child: Listener(
            onPointerSignal: (pointerSignal) {
              if (pointerSignal is PointerScrollEvent) {
                !isScrolling ? _onScroll(pointerSignal.scrollDelta.dy) : null;
              }
            },
            child: PageView(
              controller: pageController,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              pageSnapping: true,
              children: const [
                TopSection(),
                AboutSection(),
                PortfolioSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onScroll(double offset) {
    isScrolling = true;
    if (offset > 0) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    isScrolling = false;
  }
}
