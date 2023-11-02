typedef JsonType = Map<String, dynamic>;

abstract class Model<T> {
  JsonType toJson();
}
