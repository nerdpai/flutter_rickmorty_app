// ignore_for_file: constant_identifier_names, unnecessary_this, prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Character extends Equatable {
  final int id;
  final String name;
  final Status status;
  final String species;
  final String type;
  final Gender gender;
  final Location origin;
  final Location location;
  final String image;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
      ];
}

@immutable
class Location extends Equatable {
  final String name;
  final String url;

  Location({
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [
        name,
        url,
      ];
}

enum Status {
  Alive,
  Dead,
  unknown;

  @override
  String toString() => this.name;
}

enum Gender {
  Female,
  Male,
  Genderless,
  unknown;

  @override
  String toString() => this.name;
}
