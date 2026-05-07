import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/extensions/snackbar_extension.dart';
import 'package:unitask/services/api_service.dart';
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

  bool _loading = false;

  void _startLoading() => setState(() => _loading = true);
  void _stopLoading() => setState(() => _loading = false);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();

    super.dispose();
  }

  Future<void> _onSignup() async {
    debugPrint('계정 만들기');

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final passwordConfirm = _passwordConfirmController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      context.showSnackbar("정보가 올바르지 않습니다.", isError: true);
      return;
    }

    if (password != passwordConfirm) {
      context.showSnackbar("비밀번호가 일치하지 않습니다.", isError: true);
      return;
    }

    _startLoading();

    final signupResult = await ApiService.signup(
      email: email,
      password: password,
      name: name,
    );

    _stopLoading();

    if (signupResult == null) return;

    if (!signupResult) {
      if (mounted) {
        context.showSnackbar('계정 생성에 실패했습니다.', isError: true);
      }
      return;
    }

    if (mounted) context.pop();
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
        child: SingleChildScrollView(
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
              //계정 만들기 버튼
              SizedBox(
                width: .infinity,
                child: ElevatedButton(
                  onPressed: _onSignup,
                  child: _loading
                      ? const SizedBox.square(
                          dimension: 30,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : const Text(
                          '계정 만들기',
                          style: TextStyle(fontWeight: .bold, fontSize: 20),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
