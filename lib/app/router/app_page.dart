import 'package:flutter/material.dart';
import 'package:unitask/ui/pages/home/home_page.dart';
import 'package:unitask/ui/pages/login/login_page.dart';
import 'package:unitask/ui/pages/signup/signup_page.dart';

enum AppPage { login, signup, home }

extension AppPageExtension on AppPage {
  String get path => '/$name';

  Widget get page => switch (this) {
    .login => const LoginPage(),
    .signup => const SignupPage(),
    .home => const HomePage(),
  };
}
