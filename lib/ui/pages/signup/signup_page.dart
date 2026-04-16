import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/ui/common/label_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = .new();
  final TextEditingController _emailController = .new();
  final TextEditingController _passwordController = .new();
  final TextEditingController _passwordConfirmController = .new();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();

    super.dispose();
  }

  void _onSignup() {
    debugPrint('계정 만들기');

    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final passwordConfirm = _passwordConfirmController.text;

    debugPrint('이름: $name');
    debugPrint('이메일: $email');
    debugPrint('비밀번호: $password');
    debugPrint('비밀번호 확인: $passwordConfirm');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('회원가입', style: TextStyle(fontWeight: .bold)),
      ),
      body: Padding(
        padding: .all(20),
        child: Column(
          spacing: 25,
          children: [
            LabelTextField(
              controller: _nameController,
              label: '이름',
              icon: LucideIcons.userRoundPen,
            ),
            LabelTextField(
              controller: _emailController,
              label: '이메일',
              icon: LucideIcons.mail,
            ),
            LabelTextField(
              controller: _passwordController,
              label: '비밀번호',
              enableObscure: true,
              icon: LucideIcons.lockKeyhole,
            ),
            LabelTextField(
              controller: _passwordConfirmController,
              label: '비밀번호 확인',
              enableObscure: true,
              icon: LucideIcons.lockKeyholeOpen,
            ),
            SizedBox(
              width: .infinity,
              child: ElevatedButton(
                onPressed: _onSignup,
                child: Text(
                  '계정 만들기',
                  style: TextStyle(fontWeight: .bold, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
