import '../models/subnet_filter.dart';
import '../models/subnet_info.dart';
import '../models/subnet_sort_option.dart';

class SubnetsViewState {
  const SubnetsViewState({
    required this.filters,
    required this.selectedFilter,
    required this.sortOption,
    required this.subnets,
  });

  final List<SubnetFilter> filters;
  final SubnetFilterType selectedFilter;
  final SubnetSortOption sortOption;
  final List<SubnetInfo> subnets;

  List<SubnetInfo> get visibleSubnets {
    final filtered = subnets.where((subnet) {
      final matchesFilter =
          selectedFilter == SubnetFilterType.all ||
          subnet.subnet.filterTags.contains(selectedFilter);
      if (!matchesFilter) {
        return false;
      }
      return true;
    });

    final items = filtered.toList();
    switch (sortOption) {
      case SubnetSortOption.subnetNumber:
        items.sort((a, b) => a.subnet.netuid.compareTo(b.subnet.netuid));
        return items;
      case SubnetSortOption.marketCap:
        items.sort(
          (a, b) =>
              (b.market.marketCap ?? 0).compareTo(a.market.marketCap ?? 0),
        );
        return items;
      case SubnetSortOption.alphaPrice:
        items.sort(
          (a, b) => (b.market.price ?? 0).compareTo(a.market.price ?? 0),
        );
        return items;
      case SubnetSortOption.volume24h:
        items.sort(
          (a, b) =>
              (b.market.volume24h ?? 0).compareTo(a.market.volume24h ?? 0),
        );
        return items;
      case SubnetSortOption.emission:
        items.sort(
          (a, b) => (b.market.emission ?? 0).compareTo(a.market.emission ?? 0),
        );
        return items;
    }
  }

  SubnetsViewState copyWith({
    List<SubnetFilter>? filters,
    SubnetFilterType? selectedFilter,
    SubnetSortOption? sortOption,
    List<SubnetInfo>? subnets,
  }) {
    return SubnetsViewState(
      filters: filters ?? this.filters,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      sortOption: sortOption ?? this.sortOption,
      subnets: subnets ?? this.subnets,
    );
  }
}
