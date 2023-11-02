import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rickmorty_application/core/dartz_as.dart';
import 'package:flutter_rickmorty_application/core/failures/conection_failure.dart';
import 'package:flutter_rickmorty_application/core/failures/failure.dart';
import 'package:flutter_rickmorty_application/core/failures/server_not_responding_failure.dart';
import 'package:flutter_rickmorty_application/feature/domain/entities/character.dart';
import 'package:flutter_rickmorty_application/feature/domain/repositories/character_repository.dart';
import 'character_events.dart' as character_events;
import 'character_states.dart' as character_states;

class CharacterBloc
    extends Bloc<character_events.Event, character_states.State> {
  final CharacterRepository repository;

  static const charactersInList = 20;

  late int _currentPage;
  late List<Character> _characters;

  CharacterBloc({required this.repository})
      : super(const character_states.Loading()) {
    on<character_events.TryFetchCharacter>(_onTryingFetchCharacter);
    on<character_events.TryFetchSpecificCharacter>(
        _onTryingFetchSpecificCharacter);

    _currentPage = -1;
    _characters = List.empty();
  }

  Future<void> _onTryingFetchAnyCharacter(
      int index,
      Future<Either<Failure, List<Character>>> Function()
          fetchCharactersFromRepository,
      Emitter<character_states.State> emit) async {
    if (_dedicatePage(index) == _currentPage) {
      emit(character_states.Loaded(characters: _characters));
    }

    emit(const character_states.Loading());

    final result = await fetchCharactersFromRepository();

    if (result.isLeft()) {
      final failure = result.asLeft();
      switch (failure.runtimeType) {
        case ConectionFailure:
          emit(character_states.InternetFailure(message: failure.message));
        case ServerNotRespondingFauilure:
          emit(character_states.ServerFailure(message: failure.message));
      }
    } else {
      _currentPage = _dedicatePage(index);
      _characters = result.asRight();
      emit(character_states.Loaded(characters: _characters));
    }
  }

  void _onTryingFetchCharacter(character_events.TryFetchCharacter event,
      Emitter<character_states.State> emit) async {
    await _onTryingFetchAnyCharacter(event.index,
        () => repository.fetchCharacters(_dedicatePage(event.index)), emit);
  }

  void _onTryingFetchSpecificCharacter(
      character_events.TryFetchSpecificCharacter event,
      Emitter<character_states.State> emit) async {
    await _onTryingFetchAnyCharacter(
        event.index,
        () => repository.fetchSpecificCharacters(
            event.name, _dedicatePage(event.index)),
        emit);
  }

  int _dedicatePage(int index) {
    return index ~/ 2;
  }
}
