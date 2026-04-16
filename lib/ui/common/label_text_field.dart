import 'package:flutter/material.dart';

class LabelTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final IconData? icon;

  const LabelTextField({
    super.key,
    required this.label,
    this.hintText,
    this.icon,
  });

class _LabelTextFieldState extends State<LabelTextField>
  late final bool _obscureText = widget.enableObscure;

  void _switchObscure(){
    setState((){
      obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        Text(label, style: TextStyle(fontWeight: .bold)),
        TextField(
          obscureText: _obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(Widget.icon),
            suffixIcon: widget.enableObscure
            ? InkWell(
                onTap: _switchObscure,
                child: Icon(
                  _obscureText
                    ? LucideIcons.eyeClosed
                    : LucideIcons.eye,
                ),
               ),
                : null,
              hintText: widget.hintText,
          ),
        ),
      ],
    );
  }
}
