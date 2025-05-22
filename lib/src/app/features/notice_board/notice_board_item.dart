class NoticeBoardItem {
  final String profilePicUrl;
  final String name;
  final String flatNumber;
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime date;
  bool isLiked;
  bool isRead;

  NoticeBoardItem({
    required this.profilePicUrl,
    required this.name,
    required this.flatNumber,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.date,
    this.isLiked = false,
    this.isRead = false,
  });
}
