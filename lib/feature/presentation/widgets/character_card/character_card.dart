import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rickmorty_application/feature/presentation/bloc/character_bloc/character_bloc.dart';
import 'package:flutter_rickmorty_application/feature/presentation/bloc/character_bloc/character_states.dart'
    as character_states;
import 'package:flutter_rickmorty_application/feature/presentation/widgets/character_card/character_card_loaded.dart';
import 'package:flutter_rickmorty_application/feature/presentation/widgets/character_card/character_card_loading.dart';

class CharacterCard extends StatefulWidget {
  const CharacterCard({
    super.key,
    required this.index,
    required this.bloc,
  });

  static const cardHeight = 220.0;
  static const cardWidth = 600.0;

  final int index;
  final CharacterBloc bloc;

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  String text(character_states.State state) {
    late String str;
    switch (state) {
      case character_states.Loaded l:
        str = l.characters[widget.index].name;
      default:
        str = 'none';
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, character_states.State>(
      bloc: widget.bloc,
      builder: (context, state) {
        switch (state) {
          case character_states.Loaded loaded:
            return CharacterCardLoaded(
              character: loaded.characters[widget.index],
            );
          default:
            return const CharacterCardLoading();
        }
      },
    );
  }
}
