// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_rickmorty_application/feature/domain/entities/character.dart';
import 'package:flutter_rickmorty_application/feature/presentation/widgets/character_card/character_card.dart';
import 'package:flutter_rickmorty_application/feature/presentation/widgets/theme.dart';

class CharacterCardLoaded extends StatelessWidget {
  const CharacterCardLoaded({super.key, required this.character});
  final Character character;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: CharacterCard.cardWidth,
      height: CharacterCard.cardHeight,
      child: Card(
        child: Row(
          children: [
            _CharacterImage(
              url: character.image,
            ),
            const SizedBox(
              width: 24.0,
            ),
            _CharacterDetails(
              character: character,
            ),
          ],
        ),
      ),
    );
  }
}

class _CharacterImage extends StatelessWidget {
  const _CharacterImage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Image(
        image: NetworkImage(url),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

class _CharacterDetails extends StatelessWidget {
  const _CharacterDetails({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CharacterMainInfo(
            character: character,
          ),
          _CharacterOrigin(
            location: character.origin,
          ),
          _CharacterCurrentLocation(
            location: character.location,
          ),
        ],
      ),
    );
  }
}

const _mainSize = 30.0;
const _infoSize = 20.0;
const _anotationSize = 15.0;

class _CharacterMainInfo extends StatelessWidget {
  const _CharacterMainInfo({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          character.name,
          style: const TextStyle(
              color: MyTheme.primaryTextColor,
              fontSize: _mainSize,
              overflow: TextOverflow.ellipsis),
        ),
        Row(
          children: [
            Container(
              height: _anotationSize,
              width: _anotationSize,
              decoration: BoxDecoration(
                color: MyTheme.statusToColor[character.status],
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              '${character.status.name} - ${character.species}',
              style: const TextStyle(
                color: MyTheme.primaryTextColor,
                fontSize: _infoSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

sealed class _CharacterLocation extends StatelessWidget {
  const _CharacterLocation(
      {super.key, required this.location, required this.statusOfLocation});

  final String statusOfLocation;
  final Location location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          statusOfLocation,
          style: const TextStyle(
            color: MyTheme.secondaryTextColor,
            fontSize: _anotationSize,
          ),
        ),
        Text(
          location.name,
          style: const TextStyle(
              color: MyTheme.primaryTextColor,
              fontSize: _infoSize,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

class _CharacterOrigin extends _CharacterLocation {
  const _CharacterOrigin({required super.location, super.key})
      : super(statusOfLocation: 'Origin:');
}

class _CharacterCurrentLocation extends _CharacterLocation {
  const _CharacterCurrentLocation({required super.location, super.key})
      : super(statusOfLocation: 'Last known location:');
}
