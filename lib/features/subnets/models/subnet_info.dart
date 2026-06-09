import 'subnet.dart';
import 'subnet_metrics.dart';

class SubnetInfo {
  const SubnetInfo({
    required this.subnet,
    required this.market,
    required this.network,
    required this.miners,
  });

  final Subnet subnet;
  final SubnetMarket market;
  final SubnetNetwork network;
  final SubnetMiners miners;
}
