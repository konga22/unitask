import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:unitask/app/extensions/sized_box_extension.dart';
import 'package:unitask/app/extensions/snackbar_extension.dart';
import 'package:unitask/app/router/app_page.dart';
import 'package:unitask/ui/common/label_text_field.dart';
import 'package:unitask/ui/common/text_divider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                const LabelTextField(
                  label: '이메일',
                  hintText: 'example@university.deu',
                  icon: LucideIcons.mail,
                ),

                20.heightBox,

                // 비밀번호 입력창
                const LabelTextField(
                  label: '비밀번호',
                  hintText: '000000',
                  icon: LucideIcons.lockKeyhole,
                  enableObscure: true,
                ),

                // 패스워드 찾기 버튼
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      context.showSnackbar('곧 기능을 출시합니다!');
                    },
                    child: const Text('비밀번호를 잊으셨나요?'),
                  ),
                ),

                20.heightBox,

                // 로그인 버튼
                SizedBox(
                  width: .infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      '로그인',
                      style: TextStyle(fontSize: 18, fontWeight: .bold),
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
