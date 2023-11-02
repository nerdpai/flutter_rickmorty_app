import 'package:flutter/material.dart';
import 'package:flutter_rickmorty_application/app.dart';
import 'package:flutter_rickmorty_application/feature/data/repositories/character_server_repository.dart';
import 'package:http/http.dart' as http;

void main() async {
  final repository =
      await CharacterServerRepository.withClient(client: http.Client());
  runApp(
    App(
      repository: repository,
    ),
  );
}
