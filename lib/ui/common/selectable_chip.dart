import 'package:flutter/material.dart';
import 'package:unitask/app/theme/preview.dart';

@AppThemePreview(group: 'Buttons', name: 'SelectableChip')
Widget preview() => Scaffold(
  body: const Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      SelectableChip(name: '전체', selected: true),
      SelectableChip(name: '진행중'),
      SelectableChip(name: '완료'),
    ],
  ),
);

class SelectableChip extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback? onTap;

  const SelectableChip({
    super.key,
    required this.name,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const .symmetric(vertical: 5, horizontal: 14),
        decoration: BoxDecoration(
          color:
              selected //
              ? Colors.blue
              : Colors.grey.shade300,
          borderRadius: .circular(50),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: selected ? .bold : null,
            color: selected ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}
