import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rickmorty_application/core/dartz_as.dart';
import 'package:flutter_rickmorty_application/core/failures/conection_failure.dart';
import 'package:flutter_rickmorty_application/core/failures/failure.dart';
import 'package:flutter_rickmorty_application/core/failures/server_not_responding_failure.dart';
import 'package:flutter_rickmorty_application/feature/domain/entities/info.dart';
import 'package:flutter_rickmorty_application/feature/domain/repositories/character_repository.dart';
import 'package:flutter_rickmorty_application/feature/presentation/bloc/list_bloc/list_events.dart'
    as list_events;
import 'package:flutter_rickmorty_application/feature/presentation/bloc/list_bloc/list_states.dart'
    as list_states;

class ListBloc extends Bloc<list_events.Event, list_states.State> {
  final CharacterRepository repository;

  ListBloc({required this.repository}) : super(const list_states.Loading()) {
    on<list_events.TryFetchAllInfo>(_onTryingAllInfoFetch);
    on<list_events.TryFetchSpecificInfo>(_onTryingSpecificInfoFetch);
  }

  Future<void> _onTryingInfoFetch(
      Future<Either<Failure, Info>> Function() fetchInfoFromRepository,
      Emitter<list_states.State> emit) async {
    emit(const list_states.Loading());
    final result = await fetchInfoFromRepository();
    if (result.isLeft()) {
      final failure = result.asLeft();
      switch (failure.runtimeType) {
        case ConectionFailure:
          emit(list_states.InternetFailure(message: failure.message));
        case ServerNotRespondingFauilure:
          emit(list_states.ServerFailure(message: failure.message));
      }
    } else {
      emit(list_states.Loaded(info: result.asRight()));
    }
  }

  void _onTryingAllInfoFetch(list_events.TryFetchAllInfo event,
      Emitter<list_states.State> emit) async {
    await _onTryingInfoFetch(() => repository.fetchInfo(), emit);
  }

  void _onTryingSpecificInfoFetch(list_events.TryFetchSpecificInfo event,
      Emitter<list_states.State> emit) async {
    await _onTryingInfoFetch(
        () => repository.fetchSpecificInfo(event.name), emit);
  }
}
