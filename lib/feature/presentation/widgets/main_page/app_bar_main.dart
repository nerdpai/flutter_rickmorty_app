import 'package:flutter/material.dart';
import 'package:flutter_rickmorty_application/feature/presentation/widgets/theme.dart';

class AppBarMain extends AppBar {
  AppBarMain({super.key})
      : super(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: MyTheme.secondaryTextColor,
                ),
              ),
            ),
          ],
          title: const Text(
            'Characters',
            style: TextStyle(
              color: MyTheme.primaryTextColor,
            ),
          ),
          centerTitle: true,
        );
}
