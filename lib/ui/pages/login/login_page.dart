import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/extensions/sized_box_extension.dart';
import 'package:unitask/app/extensions/snackbar_extension.dart';
import 'package:unitask/app/router/app_page.dart';
import 'package:unitask/services/api_service.dart';
import 'package:unitask/ui/common/label_text_field.dart';
import 'package:unitask/ui/common/text_divider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final TextEditingController _pwController = .new();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final email = _emailController.text.trim();
    final password = _pwController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      return context.showSnackbar('이메일 또는 비밀번호를 입력해주세요', isError: true);
    }
    final response = await ApiService.login(
      email: email,
      password: password,
    );

    if (response == null) {
      if (mounted) {
        context.showSnackbar(
          '로그인을 실패했습니다',
          isError: true,
        );
      }
      return;
    }

    debugPrint('$response');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: .min,
              children: [
                const Icon(LucideIcons.graduationCap),
                const Text(
                  'UniTask',
                  style: TextStyle(fontWeight: .bold, fontSize: 28),
                ),

                const Text('과제 관리를 스마트하게'),

                50.heightBox,

                // 이메일 입력창
                LabelTextField(
                  controller: _emailController,
                  label: '이메일',
                  hintText: 'example@university.edu',
                  icon: LucideIcons.mail,
                ),

                20.heightBox,

                // 비밀번호 입력창
                LabelTextField(
                  controller: _pwController,
                  label: '비밀번호',
                  hintText: '000000',
                  icon: LucideIcons.lockKeyhole,
                  enableObscure: true,
                ),

                // 패스워드 찾기 버튼
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('비밀번호를 잊으셨나요?'),
                  ),
                ),

                20.heightBox,

                // 로그인 버튼
                SizedBox(
                  width: .infinity,
                  child: ElevatedButton(
                    onPressed: _onLogin,
                    child: const Text(
                      '로그인',
                      style: TextStyle(fontSize: 20, fontWeight: .bold),
                    ),
                  ),
                ),

                20.heightBox,

                const TextDivider(text: '또는'),

                20.heightBox,

                // 회원가입 안내
                Row(
                  mainAxisSize: .min,
                  children: [
                    const Text('계정이 없으신가요?'),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(AppPage.signup.name);
                      },
                      child: const Text('회원가입'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
