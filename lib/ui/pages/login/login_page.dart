import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/router/app_page.dart';
import 'package:unitask/core/extensions/build_context_extension.dart';
import 'package:unitask/core/extensions/models/result.dart';
import 'package:unitask/core/extensions/sized_box_extension.dart';
import 'package:unitask/features/auth/auth_provider.dart';
import 'package:unitask/ui/common/label_text_field.dart';
import 'package:unitask/ui/common/text_divider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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

    final result = await ref.read(authProvider.notifier).login(
          email: email,
          password: password,
        );

    switch (result) {
      case Success():
        if (mounted) context.goNamed(AppPage.home.name);
      case Failure(:final exception):
        if (mounted) {
          context.showSnackbar(exception.toString(), isError: true);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).isLoading;

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
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : _onLogin,
                    icon: isLoading
                        ? const SizedBox.square(
                            dimension: 14,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : null,
                    label: const Text(
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
