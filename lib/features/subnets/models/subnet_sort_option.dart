enum SubnetSortOption {
  subnetNumber,
  marketCap,
  alphaPrice,
  volume24h,
  emission,
}

extension SubnetSortOptionLabel on SubnetSortOption {
  String get label {
    return switch (this) {
      SubnetSortOption.subnetNumber => 'Subnet Number',
      SubnetSortOption.marketCap => 'Market Cap',
      SubnetSortOption.alphaPrice => 'Alpha Price',
      SubnetSortOption.volume24h => '24H Volume',
      SubnetSortOption.emission => 'Emission',
    };
  }
}
