import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/subnet_filter.dart';
import '../models/subnet_sort_option.dart';
import '../repositories/subnets_repository.dart';
import 'subnets_view_state.dart';

part 'subnets_notifier.g.dart';

@riverpod
class SubnetsNotifier extends _$SubnetsNotifier {
  @override
  Future<SubnetsViewState> build() async {
    return _loadState();
  }

  Future<SubnetsViewState> _loadState() async {
    final repository = ref.read(subnetsRepositoryProvider);
    final filters = await repository.getFilters();
    final subnets = await repository.getSubnets();

    return SubnetsViewState(
      filters: filters,
      selectedFilter: filters.first.type,
      sortOption: SubnetSortOption.subnetNumber,
      subnets: subnets,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadState);
  }

  void selectFilter(SubnetFilterType filter) {
    final current = state.value;
    if (current == null || current.selectedFilter == filter) {
      return;
    }
    state = AsyncData(current.copyWith(selectedFilter: filter));
  }

  void setSortOption(SubnetSortOption sortOption) {
    final current = state.value;
    if (current == null || current.sortOption == sortOption) {
      return;
    }
    state = AsyncData(current.copyWith(sortOption: sortOption));
  }
}
