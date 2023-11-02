import 'package:flutter_rickmorty_application/feature/domain/entities/info.dart';

sealed class State {
  const State();
}

final class Loading extends State {
  const Loading();
}

final class InternetFailure extends State {
  final String message;

  const InternetFailure({required this.message});
}

final class ServerFailure extends State {
  final String message;

  const ServerFailure({required this.message});
}

final class Loaded extends State {
  final Info info;

  const Loaded({required this.info});
}
