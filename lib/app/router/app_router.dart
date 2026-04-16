import 'package:go_router/go_router.dart';
import 'package:unitask/app/router/app_page.dart';
import 'package:unitask/ui/pages/login/login_page.dart';

final appRouter = GoRouter(
  initialLocation: AppPage.login.path,
  routes: [
    GoRoute(
      name: AppPage.login.name,
      path: AppPage.login.path,
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
