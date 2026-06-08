class SubnetMarket {
  const SubnetMarket({
    this.price,
    this.priceTrend,
    this.marketCap,
    this.volume24h,
    this.emission,
    this.taoLocked,
    this.emissionsPerHour,
    this.liquidity,
    this.healthScore,
    this.marketCapUsd,
    this.alphaUsdPrice,
    this.priceHistory = const [],
  });

  final double? price;
  final double? priceTrend;
  final double? marketCap;
  final double? volume24h;
  final double? emission;
  final double? taoLocked;
  final double? emissionsPerHour;
  final double? liquidity;
  final int? healthScore;
  final double? marketCapUsd;
  final double? alphaUsdPrice;
  final List<double> priceHistory;
}

class SubnetNetwork {
  const SubnetNetwork({
    this.networkShareRank,
    this.tvl,
    this.ownerCut,
    this.registrationStatus,
    this.validatorCount,
    this.validatorLimit,
    this.minerCount,
  });

  final int? networkShareRank;
  final double? tvl;
  final double? ownerCut;
  final String? registrationStatus;
  final int? validatorCount;
  final int? validatorLimit;
  final int? minerCount;
}
