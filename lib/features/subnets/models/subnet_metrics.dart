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

class SubnetStakers {
  const SubnetStakers({
    this.validatorSlotsFilled,
    this.validatorSlotsTotal,
    this.registrationLabel,
    this.stakerApyPercent,
    this.estimatedValidatorEpochTau,
    this.estimatedValidatorJ,
    this.topValidators = const [],
  });

  final int? validatorSlotsFilled;
  final int? validatorSlotsTotal;
  final String? registrationLabel;
  final double? stakerApyPercent;
  final double? estimatedValidatorEpochTau;
  final double? estimatedValidatorJ;
  final List<SubnetTopValidator> topValidators;
}

class SubnetTopValidator {
  const SubnetTopValidator({
    required this.rank,
    required this.name,
    this.takePercent,
    this.stakeTao,
  });

  final int rank;
  final String name;
  final double? takePercent;
  final double? stakeTao;
}

class SubnetMiners {
  const SubnetMiners({
    this.activeMiners,
    this.totalMinerSlots,
    this.registrationLabel,
    this.competitionLabel,
    this.estimatedDailyEarnAlpha,
    this.hardwareNeeded,
  });

  final int? activeMiners;
  final int? totalMinerSlots;
  final String? registrationLabel;
  final String? competitionLabel;
  final double? estimatedDailyEarnAlpha;
  final String? hardwareNeeded;
}

class SubnetFeed {
  const SubnetFeed({this.recentSignals = const []});

  final List<SubnetSignal> recentSignals;
}

class SubnetSignal {
  const SubnetSignal({
    required this.message,
    required this.timeAgo,
    required this.dotColor,
  });

  final String message;
  final String timeAgo;
  final String dotColor;
}
