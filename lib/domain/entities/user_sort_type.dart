/// Sorting types for users.
enum UserSortType {
  /// Sort by user's name in alphabetical order (A -> Z).
  fullNameAsc,

  /// Sort by user's name in reverse alphabetical order (Z -> A).
  fullNameDesc,

  /// Sort by creation date in ascending order (older records first).
  createdAtAsc,

  /// Sort by creation date in descending order (newer records first).
  createdAtDesc,
}
