sealed class Event {
  const Event();
}

final class TryFetchAllInfo extends Event {
  const TryFetchAllInfo();
}

final class TryFetchSpecificInfo extends Event {
  final String name;

  const TryFetchSpecificInfo({required this.name});
}
