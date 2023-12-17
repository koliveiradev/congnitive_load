import 'package:cognitive_load_guidance/models/clincian.dart';
import 'package:cognitive_load_guidance/models/cognitive_entry.dart';
import 'package:cognitive_load_guidance/models/phase.dart';
import 'package:flutter/material.dart';

enum SurgeryType {
  avr(title: 'Aortic Valve Replacement'),
  cabg(title: 'Coronary Artery Bypass Graft');

  const SurgeryType({
    required this.title,
  });
  final String title;
  String get abbreviation => name.toUpperCase();
}

enum SurgeryTeam {
  all(title: 'All'),
  surgery(title: 'Surgery'),
  anesthesia(title: 'Anesthesia'),
  nursing(title: 'Nursing'),
  perfusion(title: 'Perfusion');

  const SurgeryTeam({
    required this.title,
  });
  final String title;
}

class SurgeryData {
  final SurgeryType type;
  final List<ClincianTeam> teams;
  final List<SurgicalPhase> phases;
  final int interval;
  final Patient patient;
  final List<Marker> notes;
  final DateTime dateTime;
  const SurgeryData({
    required this.teams,
    required this.type,
    required this.notes,
    required this.patient,
    required this.dateTime,
    required this.phases,
    this.interval = 1,
  });

  Duration get duration {
    return phases.fold(
        const Duration(),
        (previousValue, element) =>
            previousValue +
            Duration(seconds: element.entries.length * interval));
  }

  DateTime get endTime => dateTime.add(duration);

  List<Clinician> get clinicians {
    return teams
        .fold<List<Clinician>>(
            [], (previousValue, element) => previousValue + element.clinicians)
        .toSet()
        .toList();
  }
}

class SurgicalPhase {
  final SurgicalPhaseKey key;
  final List<CongitiveEntry> entries;
  final Range range;
  const SurgicalPhase({
    required this.key,
    required this.entries,
    required this.range,
  });
}

// class ClincianEntry {
//   final List<CongitiveEntry> entries;
//   final int clinicianId;
//   final int teamId;
//   const ClincianEntry(
//       {required this.timestamp,
//       required this.clinicianId,
//       required this.teamId});
// }

class Range {
  final double min;
  final double max;
  const Range(this.min, this.max);
}

class Patient {
  final String name;
  final int age;
  final String gender;
  const Patient({required this.name, required this.gender, required this.age});
}

class ClincianTeam {
  final String name;
  final List<Clinician> clinicians;

  const ClincianTeam({required this.name, required this.clinicians});
  int get teamSize => clinicians.length;
}

enum NoteType {
  observation(
      color: Color(0xFF0D47A1),
      title: 'Observation',
      icon: Icons.remove_red_eye),
  mistake(color: Colors.amber, title: 'Mistake', icon: Icons.error),
  important(color: Colors.red, title: 'Important', icon: Icons.warning);

  const NoteType({
    required this.title,
    required this.color,
    required this.icon,
  });
  final String title;
  final Color color;
  final IconData icon;
}

class Marker {
  final int timestamp;
  final String notes;
  final NoteType type;
  const Marker(
      {required this.notes, required this.timestamp, required this.type});
}
