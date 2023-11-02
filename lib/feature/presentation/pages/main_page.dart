import 'package:flutter/material.dart';
import 'package:flutter_rickmorty_application/feature/presentation/widgets/main_page/app_bar_main.dart';
import 'package:flutter_rickmorty_application/feature/presentation/widgets/main_page/body_main.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(),
      body: const BodyMain(),
    );
  }
}
