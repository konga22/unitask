import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didpop, result) {
        result;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('내 과제'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(LucideIcons.bell),
            ),
          ],
        ),
        body: const SafeArea(child: Placeholder()),
      ),
    );
  }
}
