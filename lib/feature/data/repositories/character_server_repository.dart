import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_rickmorty_application/core/dartz_as.dart';
import 'package:flutter_rickmorty_application/core/failures/conection_failure.dart';
import 'package:flutter_rickmorty_application/core/failures/failure.dart';
import 'package:flutter_rickmorty_application/core/failures/server_not_responding_failure.dart';
import 'package:flutter_rickmorty_application/feature/data/models/character_model.dart';
import 'package:flutter_rickmorty_application/feature/data/models/info_model.dart';
import 'package:flutter_rickmorty_application/feature/domain/entities/character.dart';
import 'package:flutter_rickmorty_application/feature/domain/entities/info.dart';
import 'package:flutter_rickmorty_application/feature/domain/repositories/character_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CharacterServerRepository extends CharacterRepository {
  static const characterUrl = 'https://rickandmortyapi.com/api/character';
  static const okCode = 200;
  static const info = 'info';
  static const characters = 'results';
  static const searchHistory = 'searchHistory';

  final http.Client client;
  final SharedPreferences preferences;

  const CharacterServerRepository._(
      {required this.client, required this.preferences});

  static Future<CharacterServerRepository> withClient({
    required http.Client client,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    return CharacterServerRepository._(
      client: client,
      preferences: preferences,
    );
  }

  @override
  Future<Either<Failure, Info>> fetchInfo() {
    return _fetchInfo(characterUrl);
  }

  @override
  Future<Either<Failure, List<Character>>> fetchCharacters(int page) {
    return _fetchCharacters('$characterUrl/?page=$page');
  }

  @override
  Future<List<String>> getSearchHistory() async {
    return preferences.getStringList(searchHistory) ?? <String>[];
  }

  @override
  Future<Either<Failure, List<Character>>> fetchSpecificCharacters(
      String name, int page) {
    return _fetchCharacters('$characterUrl/?page=$page&name=$name');
  }

  @override
  Future<Either<Failure, Info>> fetchSpecificInfo(String name) {
    updateSearchHistory(name);
    return _fetchInfo('$characterUrl/?name=$name');
  }

  @override
  Future<void> updateSearchHistory(String query) async {
    final List<String> history =
        preferences.get(searchHistory) as List<String>? ?? <String>[];
    final historySet = history.toSet();
    historySet.add(query);
    preferences.setStringList(searchHistory, historySet.toList());
  }

  Future<Either<Failure, http.Response>> _getServerAnswer(String url) async {
    final result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      final response = await client
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
      if (response.statusCode == okCode) {
        return Right(response);
      }
      return Left(
        ServerNotRespondingFauilure(
            message: 'response code: ${response.statusCode}'),
      );
    }
    return Left(
      ConectionFailure(message: 'no internet connection'),
    );
  }

  Future<Either<Failure, InfoModel>> _fetchInfo(String url) async {
    final answer = await _getServerAnswer(url);
    if (answer.isLeft()) return Left(answer.asLeft());
    final response = answer.asRight();
    final decoded = json.decode(response.body);
    return Right(InfoModel.fromJson(decoded[info]));
  }

  Future<Either<Failure, List<CharacterModel>>> _fetchCharacters(
      String url) async {
    final answer = await _getServerAnswer(url);
    if (answer.isLeft()) return Left(answer.asLeft());
    final response = answer.asRight();
    final decoded = json.decode(response.body);
    return Right(
      (decoded[characters] as List)
          .map((character) => CharacterModel.fromJson(character))
          .toList(),
    );
  }
}
