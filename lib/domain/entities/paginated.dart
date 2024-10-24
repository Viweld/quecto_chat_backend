final class Paginated<T> {
  const Paginated({
    required this.result,
    required this.limit,
    required this.offset,
  });

  /// A list of items that represent the result of the query.
  final Iterable<T> result;

  /// The maximum number of items returned in the current query.
  final int? limit;

  /// The offset from where the query started fetching results.
  final int? offset;
}
