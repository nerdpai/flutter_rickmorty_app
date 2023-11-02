// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_rickmorty_application/feature/presentation/widgets/character_card/character_card.dart';
import 'package:flutter_rickmorty_application/feature/presentation/widgets/theme.dart';

class CharacterCardLoading extends StatefulWidget {
  const CharacterCardLoading({super.key});

  @override
  State<CharacterCardLoading> createState() => _CharacterCardLoadingState();
}

class _CharacterCardLoadingState extends State<CharacterCardLoading>
    with TickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: CharacterCard.cardWidth,
      height: CharacterCard.cardHeight,
      child: Card(
        child: Opacity(
          opacity: controller.value,
          child: const Row(
            children: [
              _CharacterImagePlaceholder(),
              SizedBox(
                width: 8,
              ),
              _CharacterDetailPlaceholder(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CharacterImagePlaceholder extends StatelessWidget {
  const _CharacterImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        color: MyTheme.thirdyTextColor,
      ),
    );
  }
}

class _CharacterDetailPlaceholder extends StatelessWidget {
  const _CharacterDetailPlaceholder({super.key});

  static const fatter = 30.0;
  static const slimmer = 20.0;
  static const slim = 15.0;

  static const Size mainSize = Size(200, fatter);
  static const Size infoSize = Size(120, slimmer);
  static const Size anotationSize = Size(180, slim);

  static const _TextDetailStyle mainStyle = _TextDetailStyle(
    color: MyTheme.secondaryTextColor,
    size: mainSize,
  );

  static const _TextDetailStyle infoStyle = _TextDetailStyle(
    color: MyTheme.secondaryTextColor,
    size: infoSize,
  );

  static const _TextDetailStyle anotationStyle = _TextDetailStyle(
    color: MyTheme.thirdyTextColor,
    size: anotationSize,
  );

  @override
  Widget build(BuildContext context) {
    return const FittedBox(
      fit: BoxFit.fitHeight,
      child: Column(
        children: [
          _TextDetail(
            first: mainStyle,
            second: infoStyle,
          ),
          SizedBox(
            height: 16,
          ),
          _TextDetail(
            first: anotationStyle,
            second: infoStyle,
          ),
          SizedBox(
            height: 16,
          ),
          _TextDetail(
            first: anotationStyle,
            second: infoStyle,
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

class _TextDetail extends StatelessWidget {
  const _TextDetail({
    super.key,
    required this.first,
    required this.second,
  });

  final _TextDetailStyle first;
  final _TextDetailStyle second;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SingleText(
          color: first.color,
          size: first.size,
        ),
        const SizedBox(
          height: 8,
        ),
        _SingleText(
          color: second.color,
          size: second.size,
        ),
      ],
    );
  }
}

class _SingleText extends StatelessWidget {
  const _SingleText({super.key, required this.color, required this.size});

  static final radius = BorderRadius.circular(500);

  final Color color;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: Container(
        height: size.height,
        width: size.width,
        color: color,
      ),
    );
  }
}

class _TextDetailStyle {
  final Color color;
  final Size size;

  const _TextDetailStyle({required this.color, required this.size});
}
