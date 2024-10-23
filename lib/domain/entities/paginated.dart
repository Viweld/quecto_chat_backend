final class Paginated<T> {
  Paginated({
    required this.result,
    required this.limit,
    required this.offset,
  });

  final Iterable<T> result;
  final int? limit;
  final int? offset;
}
