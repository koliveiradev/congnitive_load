import 'package:cognitive_load_guidance/models/surgery.dart';
import 'package:flutter/material.dart';

enum SurgicalPhaseKey {
  preInduction(color: Colors.blue, title: 'Pre-Induction'),
  preIncision(color: Colors.teal, title: 'Pre-Incision'),
  heparinization(color: Colors.green, title: 'Heparinization'),
  initiateCPB(color: Colors.purple, title: 'Initiate CPB'),
  anastomoses(color: Colors.orange, title: 'Anastomoses'),
  weanFromBypass(color: Colors.red, title: 'Wean from Bypass'),
  sternalClosure(color: Colors.pink, title: 'Sternal Closure'),
  postOperative(color: Colors.brown, title: 'Post-Operative');

  const SurgicalPhaseKey({required this.color, required this.title});
  final Color color;
  final String title;
}
