import 'package:cognitive_load_guidance/models/cognitive_entry.dart';
import 'package:cognitive_load_guidance/models/surgery.dart';
import 'package:cognitive_load_guidance/util/duration.dart';
import 'package:flutter/material.dart';

class CongnitiveChart extends StatefulWidget {
  const CongnitiveChart({super.key, required this.data});
  final SurgeryData data;

  @override
  State<CongnitiveChart> createState() => _CongnitiveChartState();
}

class _CongnitiveChartState extends State<CongnitiveChart> {
  double percent = 0;
  double start = 0;
  late double maxWidth;
  CongnitiveLoad load = CongnitiveLoad.lfhfratio;
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        double delta = controller.offset - start;
        start = controller.offset;

        percent -= delta / maxWidth;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).primaryColor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 620,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey.shade100)],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Notes',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.grey.shade700)),
              const SizedBox(height: 8),
              ...widget.data.notes
                  .map((e) => Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(formatDuration(Duration(seconds: e.timestamp)),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.grey.shade700)),
                            const SizedBox(height: 8),
                            Text(e.notes,
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 8,
                        offset: const Offset(0, 2))
                  ],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: SegmentedButton<CongnitiveLoad>(
                  // ToggleButtons above allows multiple or no selection.
                  // Set `multiSelectionEnabled` and `emptySelectionAllowed` to true
                  // to match the behavior of ToggleButtons.
                  multiSelectionEnabled: false,

                  emptySelectionAllowed: true,
                  // Hide the selected icon to match the behavior of ToggleButtons.
                  showSelectedIcon: false,
                  // SegmentedButton uses a Set<T> to track its selection state.
                  selected: {load},
                  // This callback updates the set of selected segment values.
                  onSelectionChanged: (Set<CongnitiveLoad> newSelection) {
                    setState(() {
                      load = newSelection.first;
                    });
                  },
                  // SegmentedButton uses a List<ButtonSegment<T>> to build its children
                  // instead of a List<Widget> like ToggleButtons.
                  segments: CongnitiveLoad.values
                      .map<ButtonSegment<CongnitiveLoad>>(
                          (CongnitiveLoad shirt) {
                    return ButtonSegment<CongnitiveLoad>(
                        value: shirt, label: Text(shirt.title));
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: Container(
                  height: 620,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 8,
                          offset: const Offset(0, 2))
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2))
                              ],
                              borderRadius: BorderRadius.circular(8)),
                          width: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                color: Colors.white,
                                height: 60,
                                width: 60,
                                child: const Center(
                                    child: Text(
                                  'CL',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.black),
                                )),
                              ),
                              Divider(
                                color: Colors.grey.shade400,
                                height: 1,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ...List.generate(
                                5,
                                (index) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text('${(5 - index) * 20}%',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              color: Colors.grey.shade700,
                                            )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        VerticalDivider(
                          width: 1,
                          color: Colors.grey.shade500,
                        ),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              maxWidth = constraints.maxWidth;
                              return Stack(
                                children: [
                                  ListView.separated(
                                    controller: controller,
                                    physics: const ClampingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.data.phases.length,
                                    separatorBuilder: (context, index) =>
                                        VerticalDivider(
                                      color: Colors.grey.shade500,
                                      width: 1,
                                    ),
                                    itemBuilder: (context, index) {
                                      final phase = widget.data.phases[index];

                                      final startInterval = widget.data.phases
                                          .sublist(0, index)
                                          .fold(
                                              0,
                                              (previousValue, element) =>
                                                  previousValue +
                                                  element.entries.length *
                                                      widget.data.interval);

                                      final List<Marker> notes = widget
                                          .data.notes
                                          .where((e) {
                                            final int endInterval =
                                                startInterval +
                                                    phase.entries.length *
                                                        widget.data.interval;

                                            return e.timestamp >=
                                                    startInterval &&
                                                e.timestamp < endInterval;
                                          })
                                          .map((e) => Marker(
                                                type: e.type,
                                                timestamp:
                                                    e.timestamp - startInterval,
                                                notes: e.notes,
                                              ))
                                          .toList();
                                      return SurgicalPhaseSection(
                                        load: load,
                                        startInterval: startInterval,
                                        notes: notes,
                                        interval: widget.data.interval,
                                        phase: phase,
                                        order: index + 1,
                                      );
                                    },
                                  ),
                                  Positioned(
                                    left: percent * constraints.maxWidth,
                                    top: 0,
                                    bottom: 0,
                                    right: 0,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        GestureDetector(
                                          onHorizontalDragUpdate: (details) {
                                            setState(() {
                                              percent = (percent +
                                                      details.delta.dx /
                                                          constraints.maxWidth)
                                                  .clamp(0.0, 1.0);
                                            });
                                          },
                                          child: VerticalDivider(
                                            thickness: 5,
                                            color: Colors.blueGrey.shade600,
                                            width: 5,
                                          ),
                                        ),
                                        Expanded(
                                            child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: IgnorePointer(
                                                child: Container(
                                                  height: double.maxFinite,
                                                  color: Colors.white60,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class SurgicalPhaseSection extends StatelessWidget {
  const SurgicalPhaseSection(
      {super.key,
      required this.phase,
      required this.order,
      required this.notes,
      required this.startInterval,
      required this.load,
      required this.interval});
  final SurgicalPhase phase;
  final int interval;
  final List<Marker> notes;
  final int order;
  final int startInterval;
  final CongnitiveLoad load;
  @override
  Widget build(BuildContext context) {
    const double width = 80;
    const double height = 500;
    return SizedBox(
      width: width * phase.entries.length + 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '$order. ${phase.key.name.capitalize()}',
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 1,
          ),
          Container(
            decoration: const BoxDecoration(),
            height: height + 20,
            child: Stack(
              children: [
                Row(
                  children: List.generate(
                    phase.entries.length,
                    (index) {
                      final entry = phase.entries[index];
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: entry.getValue(load) * height),
                          decoration: BoxDecoration(
                              color: phase.key.color,
                              boxShadow: [
                                BoxShadow(
                                    color: phase.key.color.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2))
                              ],
                              borderRadius: BorderRadius.circular(0)),
                          height: 20,
                          width: width,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: height * (1 - phase.range.max),
                    bottom: height * phase.range.min,
                    child: Container(
                      color: Colors.white.withOpacity(0.25),
                      width: double.minPositive,
                      height: double.maxFinite,
                    )),
                Positioned(
                    left: 0,
                    right: 0,
                    top: height * (1 - phase.range.max),
                    bottom: height * phase.range.min,
                    child: Container(
                      decoration: BoxDecoration(
                        color: phase.key.color.withOpacity(0.25),
                        border: Border.symmetric(
                            horizontal: BorderSide(
                          color: phase.key.color.withOpacity(0.5),
                          width: 2,
                        )),
                      ),
                      width: double.minPositive,
                      height: double.maxFinite,
                    )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: List.generate(
                phase.entries.length,
                (index) {
                  return SizedBox(
                    height: 20,
                    width: width,
                    child: Center(
                      child: Text(
                        formatDuration(Duration(
                            seconds: (startInterval + index * interval))),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.black45,
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
