import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/theme/preview.dart';

@AppThemePreview(group: 'Card', name: 'DetailCard')
Widget preview() => DetailCard(
  subject: 'Flutter',
  title: 'Unitask 끝내기',
  date: DateTime.now().copyWith(month: 6, day: 4),
);

class DetailCard extends StatelessWidget {
  final String subject;
  final String title;
  final DateTime date;

  const DetailCard({
    super.key,
    required this.subject,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(24),
      decoration: BoxDecoration(
        borderRadius: .circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF3B82F6)],
          begin: .bottomLeft,
          end: .topRight,
        ),
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: .start,
        children: [
          // 과목
          _badge(text: subject),
          // 타이틀
          Text(
            title,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: .bold,
              fontSize: 20,
            ),
            overflow: .ellipsis,
          ),
          // 기한
          SizedBox(
            width: .infinity,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                // 날짜
                _badge(
                  isWide: true,
                  text: DateFormat('yyyy.MM.dd').format(date),
                  icon: LucideIcons.calendarRange,
                  borderRadius: .circular(50),
                ),
                // D-DAY
                _badge(
                  isWide: true,
                  text: 'D-${date.difference(DateTime.now()).inDays}',
                  isPrimary: true,
                  borderRadius: .circular(50),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _badge({
    required String text,
    IconData? icon,
    bool isPrimary = false,
    bool isWide = false,
    BorderRadiusGeometry? borderRadius,
  }) {
    return Container(
      padding: .symmetric(horizontal: isWide ? 20 : 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? .circular(10),
        color: Colors.white.withValues(alpha: isPrimary ? 1 : .2),
      ),
      child: Row(
        spacing: 5,
        mainAxisSize: .min,
        children: [
          if (icon != null) Icon(icon, color: Colors.white, size: 14),
          Text(
            text,
            style: TextStyle(
              color: isPrimary ? Colors.blueAccent : Colors.white,
              fontWeight: .w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
