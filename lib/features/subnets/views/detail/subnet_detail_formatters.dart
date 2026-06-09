String? formatPriceTao(double? value) {
  if (value == null) {
    return null;
  }
  return '${value.toStringAsFixed(3)} T';
}

String? formatPercent(double? value) {
  if (value == null) {
    return null;
  }
  return '${value.toStringAsFixed(1)}%';
}

String? formatPercentPrecise(double? value) {
  if (value == null) {
    return null;
  }
  return '${value.toStringAsFixed(2)}%';
}

String? formatPercentWhole(double? value) {
  if (value == null) {
    return null;
  }
  return '${value.toStringAsFixed(0)}%';
}

String? formatTaoCompact(double? value) {
  if (value == null) {
    return null;
  }
  return '${_formatCompactNumber(value)} T';
}

String? formatTaoSuffix(double? value) {
  if (value == null) {
    return null;
  }
  return '${_formatCompactNumber(value)} T';
}

String? formatUsdCompact(double? value) {
  if (value == null) {
    return null;
  }
  return '\$${_formatCompactNumber(value)}';
}

String? formatUsdRegular(double? value) {
  if (value == null) {
    return null;
  }
  if (value.abs() >= 1000) {
    return '\$${value.toStringAsFixed(0)}';
  }
  return '\$${value.toStringAsFixed(2)}';
}

String? formatEstimatedValidator(double? epochTau, double? jValue) {
  if (epochTau == null || jValue == null) {
    return null;
  }
  return 'epoch≈ ${epochTau.toStringAsFixed(3)} τ / J ${jValue.toStringAsFixed(2)}';
}

String? formatValidatorTake(double? value) {
  if (value == null) {
    return null;
  }
  return '${value.toStringAsFixed(0)}% take';
}

String formatIntegerCompact(int? value) {
  if (value == null) {
    return '--';
  }
  return value.toString();
}

String? formatAlphaPerDay(double? value, {String symbol = 'alpha'}) {
  if (value == null) {
    return null;
  }
  return '~${value.toStringAsFixed(1)} $symbol / day';
}

String _formatCompactNumber(double value) {
  final absolute = value.abs();
  if (absolute >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(absolute >= 10000000 ? 0 : 1)}M';
  }
  if (absolute >= 1000) {
    return '${(value / 1000).toStringAsFixed(absolute >= 10000 ? 0 : 1)}k';
  }
  if (value % 1 == 0) {
    return value.toStringAsFixed(0);
  }
  return value.toStringAsFixed(1);
}
