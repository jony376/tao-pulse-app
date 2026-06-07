import '../models/subnet_filter.dart';
import '../models/subnet_sort_option.dart';
import '../models/subnet.dart';

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
  final List<Subnet> subnets;

  List<Subnet> get visibleSubnets {
    final filtered = subnets.where((subnet) {
      final matchesFilter =
          selectedFilter == SubnetFilterType.all ||
          subnet.filterTags.contains(selectedFilter);
      if (!matchesFilter) {
        return false;
      }
      return true;
    });

    final items = filtered.toList();
    switch (sortOption) {
      case SubnetSortOption.subnetNumber:
        items.sort((a, b) => a.netuid.compareTo(b.netuid));
        return items;
      case SubnetSortOption.marketCap:
        items.sort((a, b) => (b.marketCap ?? 0).compareTo(a.marketCap ?? 0));
        return items;
      case SubnetSortOption.alphaPrice:
        items.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
        return items;
      case SubnetSortOption.volume24h:
        items.sort((a, b) => (b.volume24h ?? 0).compareTo(a.volume24h ?? 0));
        return items;
      case SubnetSortOption.emission:
        items.sort((a, b) => (b.emission ?? 0).compareTo(a.emission ?? 0));
        return items;
    }
  }

  SubnetsViewState copyWith({
    List<SubnetFilter>? filters,
    SubnetFilterType? selectedFilter,
    SubnetSortOption? sortOption,
    List<Subnet>? subnets,
  }) {
    return SubnetsViewState(
      filters: filters ?? this.filters,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      sortOption: sortOption ?? this.sortOption,
      subnets: subnets ?? this.subnets,
    );
  }
}
