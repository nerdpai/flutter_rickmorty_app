sealed class Event {
  final int index;
  const Event(this.index);
}

final class TryFetchCharacter extends Event {
  const TryFetchCharacter(super.index);
}

final class TryFetchSpecificCharacter extends Event {
  final String name;

  const TryFetchSpecificCharacter(super.index, {required this.name});
}
