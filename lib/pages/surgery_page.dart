import 'package:cognitive_load_guidance/models/surgery.dart';
import 'package:cognitive_load_guidance/pages/cognitive_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SurgeriesPage extends StatelessWidget {
  SurgeriesPage({super.key});
  final List<SurgeryData> surgeries = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 243, 250),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 8,
                        offset: const Offset(0, 2))
                  ]),
              child: DataTable(
                showCheckboxColumn: false,
                columns: <DataColumn>[
                  const DataColumn(
                    label: Expanded(
                      child: Text(
                        'Surgery Type',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  DataColumn(
                    onSort: (int columnIndex, bool ascending) {},
                    label: const Expanded(
                      child: Text(
                        'Duration',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: Expanded(
                      child: Text(
                        'Date',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: Expanded(
                      child: Text(
                        'Time',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: Expanded(
                      child: Text(
                        'Overall Score',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
                rows: surgeries.map((s) {
                  return DataRow(
                    onSelectChanged: (bool? selected) {
                      if (selected != null && selected) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CongnitivePage(data: s)));
                      }
                    },
                    cells: <DataCell>[
                      DataCell(Text(s.type.name.toUpperCase())),
                      DataCell(Text(
                          '${s.duration.inHours} Hrs ${s.duration.inMinutes - s.duration.inHours * 60} Min')),
                      DataCell(
                          Text(DateFormat('MM/dd/yyyy').format(s.dateTime))),
                      DataCell(Text(
                          '${DateFormat('hh:mm a').format(s.dateTime)}-${DateFormat('hh:mm a').format(s.endTime)}')),
                      const DataCell(Text('Expected')),
                    ],
                  );
                }).toList(),
              ),
            )
          ],
        ));
  }
}
