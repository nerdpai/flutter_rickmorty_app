import 'package:dartz/dartz.dart';
import 'package:flutter_rickmorty_application/core/failures/failure.dart';
import 'package:flutter_rickmorty_application/feature/domain/entities/character.dart';
import 'package:flutter_rickmorty_application/feature/domain/entities/info.dart';
import 'package:meta/meta.dart';

abstract class CharacterRepository {
  const CharacterRepository();

  Future<Either<Failure, Info>> fetchInfo();
  Future<Either<Failure, List<Character>>> fetchCharacters(int page);

  Future<Either<Failure, Info>> fetchSpecificInfo(String name);
  Future<Either<Failure, List<Character>>> fetchSpecificCharacters(
      String name, int page);

  Future<List<String>> getSearchHistory();

  @protected
  Future<void> updateSearchHistory(String query);
}
