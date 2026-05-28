import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/theme/preview.dart';
import 'package:unitask/ui/common/subject_label.dart';

@AppThemePreview(group: 'Card', name: 'TaskCard', brightness: .light)
Widget preview() {
  var checked = false;

  return StatefulBuilder(
    builder: (context, setState) => TaskCard(
      onSelected: () {},
      onChecked: (value) {
        setState(() => checked = value ?? false);
      },
      checked: checked,
      title: 'Unitask 끝내기',
      date: DateTime.now().copyWith(month: 6, day: 4),
      category: const SubjectLabel(text: 'Flutter'),
    ),
  );
}

class TaskCard extends StatelessWidget {
  final bool checked;
  final String title;
  final DateTime date;
  final Widget category;
  final VoidCallback? onSelected;
  final ValueChanged<bool?>? onChecked;

  const TaskCard({
    super.key,
    required this.checked,
    required this.title,
    required this.date,
    required this.category,
    this.onSelected,
    this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    final dDay = date.difference(DateTime.now()).inDays;

    final dDayColor = switch (dDay) {
      <= 3 => Colors.red, // 3일 남음
      <= 7 => Colors.orange, // 7일 남음
      _ => Colors.black, // 기본
    };

    return Card(
      child: Container(
        height: 120,
        padding: const .symmetric(vertical: 6, horizontal: 12),
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: 5,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                category,
                Checkbox(
                  onChanged: onChecked,
                  value: checked,
                  visualDensity: .compact,
                  activeColor: Colors.blue,
                  fillColor: .resolveWith(
                    (states) => states.contains(WidgetState.selected)
                        ? Colors.blue
                        : const Color(0xFFF3F4F6),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: .circular(5),
                    side: const BorderSide(color: Colors.transparent),
                  ),
                  side: const BorderSide(color: Colors.transparent),
                  materialTapTargetSize: .shrinkWrap,
                ),
              ],
            ),
            Text(
              title,
              maxLines: 1,
              overflow: .ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: .bold),
            ),
            // 기한 표시
            Row(
              spacing: 5,
              children: [
                Icon(LucideIcons.calendarRange, size: 12, color: dDayColor),
                Text(
                  DateFormat('yyyy.MM.dd').format(date),
                  style: TextStyle(fontSize: 12, color: dDayColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
