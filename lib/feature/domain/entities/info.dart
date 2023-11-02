// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Info extends Equatable {
  final int count;
  final int pages;

  Info({
    required this.count,
    required this.pages,
  });

  @override
  List<Object?> get props => [count, pages];
}
