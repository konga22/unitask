import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/theme/preview.dart';

@AppThemePreview(group: 'Buttons', name: 'HighlightButton')
Widget preview() {
  return const HighlightButton(
    leading: Icon(
      LucideIcons.plus,
      size: 14,
    ),
    child: Text('새 과제 추가'),
  );
}

class HighlightButton extends StatelessWidget {
  final Color color;
  final double spacing;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;

  const HighlightButton({
    super.key,
    this.color = Colors.blue,
    this.spacing = 10.0,
    required this.child,
    this.leading,
    this.trailing,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const .symmetric(
          vertical: 5,
          horizontal: 14,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: .circular(10),
          color: color.withValues(alpha: 0.3),
        ),
        alignment: .center,
        child: Row(
          spacing: spacing,
          mainAxisSize: .min,
          children: [
            if (leading != null && leading is Icon)
              () {
                final leadingIcon = leading as Icon;
                return Icon(
                  leadingIcon.icon,
                  color: leadingIcon.color ?? color,
                  size: leadingIcon.size,
                );
              }()
            else
              ?leading,
            DefaultTextStyle(
              style: TextStyle(
                fontWeight: .bold,
                color: color,
              ),
              child: child,
            ),
            if (trailing != null && trailing is Icon)
              () {
                final trailingIcon = trailing as Icon;
                return Icon(
                  trailingIcon.icon,
                  color: trailingIcon.color ?? color,
                  size: trailingIcon.size,
                );
              }()
            else
              ?trailing,
          ],
        ),
      ),
    );
  }
}
