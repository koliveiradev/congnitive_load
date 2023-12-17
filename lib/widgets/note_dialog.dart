import 'package:cognitive_load_guidance/models/surgery.dart';
import 'package:flutter/material.dart';

class NoteDialog extends StatefulWidget {
  const NoteDialog({super.key});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  NoteType type = NoteType.observation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      content: SizedBox(
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Note',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(
              height: 16,
            ),
            SegmentedButton<NoteType>(
              // ToggleButtons above allows multiple or no selection.
              // Set `multiSelectionEnabled` and `emptySelectionAllowed` to true
              // to match the behavior of ToggleButtons.
              multiSelectionEnabled: false,

              emptySelectionAllowed: true,
              // Hide the selected icon to match the behavior of ToggleButtons.
              showSelectedIcon: false,
              // SegmentedButton uses a Set<T> to track its selection state.
              selected: {type},
              // This callback updates the set of selected segment values.
              onSelectionChanged: (Set<NoteType> newSelection) {
                setState(() {
                  type = newSelection.first;
                });
              },
              // SegmentedButton uses a List<ButtonSegment<T>> to build its children
              // instead of a List<Widget> like ToggleButtons.
              segments: NoteType.values
                  .map<ButtonSegment<NoteType>>((NoteType shirt) {
                return ButtonSegment<NoteType>(
                    value: shirt, label: Text(shirt.title));
              }).toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            const TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 5,
              decoration: InputDecoration(
                hintText: 'Notes...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NoteEditDialog extends StatefulWidget {
  const NoteEditDialog({super.key, required this.marker});
  final Marker marker;

  @override
  State<NoteEditDialog> createState() => _NoteEditDialogState();
}

class _NoteEditDialogState extends State<NoteEditDialog> {
  late NoteType type;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    type = widget.marker.type;
    controller = TextEditingController(text: widget.marker.notes);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      content: SizedBox(
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'View Note',
                  style: theme.textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            SegmentedButton<NoteType>(
              // ToggleButtons above allows multiple or no selection.
              // Set `multiSelectionEnabled` and `emptySelectionAllowed` to true
              // to match the behavior of ToggleButtons.
              multiSelectionEnabled: false,

              emptySelectionAllowed: true,
              // Hide the selected icon to match the behavior of ToggleButtons.
              showSelectedIcon: false,
              // SegmentedButton uses a Set<T> to track its selection state.
              selected: {type},
              // This callback updates the set of selected segment values.
              onSelectionChanged: (Set<NoteType> newSelection) {
                setState(() {
                  type = newSelection.first;
                });
              },
              // SegmentedButton uses a List<ButtonSegment<T>> to build its children
              // instead of a List<Widget> like ToggleButtons.
              segments: NoteType.values
                  .map<ButtonSegment<NoteType>>((NoteType shirt) {
                return ButtonSegment<NoteType>(
                    value: shirt, label: Text(shirt.title));
              }).toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 5,
              decoration: const InputDecoration(
                hintText: 'Notes...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
