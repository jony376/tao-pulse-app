class FeedItem {
  const FeedItem({
    required this.id,
    required this.category,
    required this.title,
    required this.summary,
    required this.insight,
    required this.timeAgo,
    required this.impact,
    required this.tags,
  });

  final String id;
  final String category;
  final String title;
  final String summary;
  final String insight;
  final String timeAgo;
  final String impact;
  final List<String> tags;
}
