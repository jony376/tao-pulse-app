import 'subnet_filter.dart';

class Subnet {
  const Subnet({
    required this.netuid,
    required this.name,
    required this.description,
    required this.alphaToken,
    this.category,
    this.filterTags = const [],
    this.watching = false,
  });

  final int netuid;
  final String name;
  final String description;
  final String alphaToken;
  final String? category;
  final List<SubnetFilterType> filterTags;
  final bool watching;
}
