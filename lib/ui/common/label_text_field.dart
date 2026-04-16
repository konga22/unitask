import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LabelTextField extends StatefulWidget {
  final bool enableObscure;
  final String label;
  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;

  const LabelTextField({
    super.key,
    this.controller,
    required this.label,
    this.hintText,
    this.icon,
    this.enableObscure = false,
  });

  @override
  State<LabelTextField> createState() => _LabelTextFieldState();
}

class _LabelTextFieldState extends State<LabelTextField> {
  late bool _obscureText = widget.enableObscure;

  void _switchObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        Text(widget.label, style: TextStyle(fontWeight: .bold)),
        TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon),
            suffixIcon: widget.enableObscure
                ? InkWell(
                    onTap: _switchObscure,
                    child: Icon(
                      _obscureText ? LucideIcons.eyeClosed : LucideIcons.eye,
                    ),
                  )
                : null,
            hintText: widget.hintText,
          ),
        ),
      ],
    );
  }
}
