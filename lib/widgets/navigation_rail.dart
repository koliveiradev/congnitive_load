import 'package:cognitive_load_guidance/models/surgery.dart';
import 'package:flutter/material.dart';

class NavigationRailItem {
  final IconData icon;
  final String label;
  final WidgetBuilder builder;
  const NavigationRailItem(
      {required this.icon, required this.label, required this.builder});
}

class AppNavigationRail extends StatefulWidget {
  const AppNavigationRail({super.key, required this.items});
  final List<NavigationRailItem> items;

  @override
  State<AppNavigationRail> createState() => _AppNavigationRailState();
}

class _AppNavigationRailState extends State<AppNavigationRail> {
  int _selectedIndex = 0;
  int hoveredIndex = -1;
  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).primaryColor;
    return Material(
      child: Row(
        children: [
          Container(
              width: 260,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Surgery Guide',
                    style: TextStyle(
                        color: primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Divider(
                    color: primary,
                    height: 36,
                  ),
                  ...widget.items.map((e) {
                    final int index = widget.items.indexOf(e);
                    final bool isSelected = _selectedIndex == index;
                    final bool isHovered = hoveredIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: MouseRegion(
                        onEnter: (details) => setState(() {
                          hoveredIndex = index;
                        }),
                        onExit: (details) => setState(() {
                          hoveredIndex = -1;
                        }),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          decoration: BoxDecoration(
                              color: isSelected
                                  ? primary
                                  : isHovered
                                      ? primary.withOpacity(0.12)
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  e.icon,
                                  color: isSelected
                                      ? Colors.white
                                      : (isHovered
                                          ? primary
                                          : Colors.blueGrey.shade800),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  e.label,
                                  style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.blueGrey.shade800,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                        ),
                      ),
                    );
                  }),
                ],
              )),
          Expanded(
              child: IndexedStack(
            index: _selectedIndex,
            children: widget.items.map((e) => e.builder(context)).toList(),
          ))
        ],
      ),
    );
  }
}
