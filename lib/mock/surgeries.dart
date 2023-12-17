import 'dart:math';

import 'package:cognitive_load_guidance/models/clincian.dart';
import 'package:cognitive_load_guidance/models/cognitive_entry.dart';
import 'package:cognitive_load_guidance/models/phase.dart';
import 'package:cognitive_load_guidance/models/surgery.dart';

class Mock {
  static final SurgeryData mock1 = SurgeryData(
    type: SurgeryType.avr,
    notes: [
      const Marker(
          notes: 'Surgery team seemed a bit stressed.',
          type: NoteType.observation,
          timestamp: 5 * 60),
      const Marker(
          notes: 'Anesthesia team had to repeat instructions.',
          type: NoteType.mistake,
          timestamp: 8 * 60)
    ],
    interval: 60,
    dateTime: DateTime.now(),
    patient: const Patient(name: 'Mary Smith', gender: 'Female', age: 47),
    teams: [
      const ClincianTeam(name: 'Surgery', clinicians: [
        Clinician(id: 0, name: 'Dr. Dewey', title: 'Doctor', team: 'Surgery')
      ]),
      const ClincianTeam(name: 'Anesthesia', clinicians: [
        Clinician(
            id: 0, name: 'Dr. Peterson', title: 'Doctor', team: 'Anesthesia')
      ]),
      const ClincianTeam(name: 'Nursing', clinicians: [
        Clinician(id: 0, name: 'Mrs. Joans', title: 'Doctor', team: 'Nursing')
      ]),
      const ClincianTeam(name: 'Perfusion', clinicians: [
        Clinician(id: 0, name: 'Mr. Lin', title: 'Doctor', team: 'Perfusion')
      ])
    ],
    phases: SurgicalPhaseKey.values
        .map((e) => SurgicalPhase(
            key: e,
            range: Range(
                ((0.1 + Random().nextDouble() * 0.3) * 10).round() / 10,
                ((0.6 + Random().nextDouble() * 0.4) * 10).round() / 10),
            entries: List.generate(
                10,
                (index) => CongitiveEntry(
                      rmssd: (Random().nextDouble() * 10).round() / 10,
                      snsindex: (Random().nextDouble() * 10).round() / 10,
                      pnsindex: (Random().nextDouble() * 10).round() / 10,
                      lfhfratio: (Random().nextDouble() * 10).round() / 10,
                      meanrr: (Random().nextDouble() * 10).round() / 10,
                    ))))
        .toList(),
  );
  static final List<SurgeryData> values = [
    mock1,
  ];
}
