import 'dart:math';

import 'package:cognitive_load_guidance/models/clincian.dart';
import 'package:cognitive_load_guidance/models/phase.dart';
import 'package:cognitive_load_guidance/models/surgery.dart';
import 'package:cognitive_load_guidance/pages/people_page.dart';
import 'package:cognitive_load_guidance/pages/surgery_page.dart';
import 'package:cognitive_load_guidance/pages/team_page.dart';
import 'package:cognitive_load_guidance/widgets/navigation_rail.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods like buildOverscrollIndicator and buildScrollbar
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class _MainAppState extends State<MainApp> {
  final ScrollController controller = ScrollController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 129, 112, 237),
        ),
      ),
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: AppNavigationRail(
        items: [
          NavigationRailItem(
              icon: Icons.medication_liquid,
              label: 'Surgeries',
              builder: (context) {
                return SurgeriesPage();
              }),
          NavigationRailItem(
              icon: Icons.person_outlined,
              label: 'People Stats',
              builder: (context) {
                return const PeoplePage();
              }),
          NavigationRailItem(
              icon: Icons.people_outline,
              label: 'Team Stats',
              builder: (context) {
                return const TeamPage();
              }),
        ],
      ),
    );
  }
}
