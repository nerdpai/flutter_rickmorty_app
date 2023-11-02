import 'package:flutter_rickmorty_application/feature/data/models/model.dart';
import 'package:flutter_rickmorty_application/feature/domain/entities/info.dart';

class InfoModel extends Info implements Model<InfoModel> {
  InfoModel._({
    required super.count,
    required super.pages,
  });

  factory InfoModel.fromJson(JsonType json) {
    return InfoModel._(
      count: json['count'],
      pages: json['pages'],
    );
  }

  @override
  JsonType toJson() {
    return {
      'count': count,
      'pages': pages,
    };
  }
}
