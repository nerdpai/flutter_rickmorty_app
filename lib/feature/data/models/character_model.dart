import 'package:flutter_rickmorty_application/feature/data/models/model.dart';
import 'package:flutter_rickmorty_application/feature/domain/entities/character.dart';

class CharacterModel extends Character implements Model<CharacterModel> {
  CharacterModel._({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.origin,
    required super.location,
    required super.image,
  });

  static Status _toStatus(dynamic object) {
    return Status.values.where((element) => element.name == object).first;
  }

  static Gender _toGender(dynamic object) {
    return Gender.values.where((element) => element.name == object).first;
  }

  factory CharacterModel.fromJson(JsonType json) {
    return CharacterModel._(
      id: json['id'],
      name: json['name'],
      status: CharacterModel._toStatus(json['status']),
      species: json['species'],
      type: json['type'],
      gender: CharacterModel._toGender(json['gender']),
      origin: LocationModel.fromJson(json),
      location: LocationModel.fromJson(json),
      image: json['image'],
    );
  }

  @override
  JsonType toJson() {
    return {
      'id': id,
      'name': name,
      'status': status.name,
      'species': species,
      'type': type,
      'gender': gender.name,
      'origin': origin,
      'location': location,
      'image': image,
    };
  }
}

class LocationModel extends Location implements Model<LocationModel> {
  LocationModel._({
    required super.name,
    required super.url,
  });

  factory LocationModel.fromJson(JsonType json) {
    return LocationModel._(
      name: json['name'],
      url: json['url'],
    );
  }

  @override
  JsonType toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
