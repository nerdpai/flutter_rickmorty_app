import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rickmorty_application/core/pair.dart';
import 'package:flutter_rickmorty_application/feature/presentation/bloc/character_bloc/character_bloc.dart';
import 'package:flutter_rickmorty_application/feature/presentation/bloc/character_bloc/character_events.dart';
import 'package:flutter_rickmorty_application/feature/presentation/widgets/character_card/character_card.dart';

class CharactersGrid extends StatefulWidget {
  const CharactersGrid({super.key, required this.countOfElements});
  final int countOfElements;

  static const spacing = 12.0;

  @override
  State<CharactersGrid> createState() => _CharactersGridState();
}

class _CharactersGridState extends State<CharactersGrid> {
  late final List<Pair<CharacterBloc, bool>> blocs;

  @override
  void initState() {
    final repository = context.read<CharacterBloc>().repository;
    blocs = List<Pair<CharacterBloc, bool>>.generate(
      widget.countOfElements ~/ CharacterBloc.charactersInList + 1,
      (index) => Pair<CharacterBloc, bool>(
        first: CharacterBloc(repository: repository),
        second: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    int count = (width + CharactersGrid.spacing * 2.0) ~/
        (CharacterCard.cardWidth + CharactersGrid.spacing * 4);
    if (count == 0) count = 1;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: CharacterCard.cardWidth * count +
              CharactersGrid.spacing * 2.0 * count,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: count,
              mainAxisSpacing: CharactersGrid.spacing,
              crossAxisSpacing: CharactersGrid.spacing,
              childAspectRatio:
                  CharacterCard.cardWidth / CharacterCard.cardHeight),
          itemCount: widget.countOfElements,
          itemBuilder: (context, index) {
            final blocIndex = index ~/ CharacterBloc.charactersInList;
            if (blocs[blocIndex].second == false) {
              blocs[blocIndex].second = true;
              blocs[blocIndex].first.add(TryFetchCharacter(index));
            }
            return CharacterCard(
              bloc: blocs[blocIndex].first,
              index: index % CharacterBloc.charactersInList,
            );
          },
        ),
      ),
    );
  }
}
