import 'dart:math';

import 'package:cognitive_load_guidance/models/clincian.dart';
import 'package:cognitive_load_guidance/models/phase.dart';
import 'package:cognitive_load_guidance/models/surgery.dart';
import 'package:cognitive_load_guidance/util/duration.dart';
import 'package:cognitive_load_guidance/widgets/cognitive_chart.dart';
import 'package:cognitive_load_guidance/widgets/navigation_rail.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CongnitivePage extends StatefulWidget {
  const CongnitivePage({super.key, required this.data});
  final SurgeryData data;
  @override
  State<CongnitivePage> createState() => _CongnitivePageState();
}

class _CongnitivePageState extends State<CongnitivePage> {
  final ScrollController controller = ScrollController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).primaryColor;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 241, 249),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.close, color: primary),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 24,
              ),
              Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.grey.shade100)],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        DropdownMenu<SurgeryTeam>(
                          initialSelection: SurgeryTeam.surgery,
                          requestFocusOnTap: true,
                          width: 200,
                          label: const Text('Team'),
                          onSelected: (SurgeryTeam? color) {},
                          dropdownMenuEntries: SurgeryTeam.values
                              .map<DropdownMenuEntry<SurgeryTeam>>(
                                  (SurgeryTeam color) {
                            return DropdownMenuEntry<SurgeryTeam>(
                              value: color,
                              label: color.title,
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        DropdownMenu<int>(
                          initialSelection: -1,
                          requestFocusOnTap: true,
                          width: 200,
                          label: const Text('Person'),
                          onSelected: (int? color) {},
                          dropdownMenuEntries: [
                            const DropdownMenuEntry<int>(
                              value: -1,
                              label: 'Entrie Team',
                            ),
                            ...widget.data.clinicians
                                .map<DropdownMenuEntry<int>>((Clinician color) {
                              return DropdownMenuEntry<int>(
                                value: color.id,
                                label: color.name,
                              );
                            })
                          ],
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Surgery Type',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.grey.shade700)),
                            const SizedBox(height: 8),
                            Text(widget.data.type.abbreviation,
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Time Taken',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.grey.shade700)),
                            const SizedBox(height: 8),
                            Text(formatDuration(widget.data.duration),
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(child: CongnitiveChart(data: widget.data)),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ));
  }
}
