import '../models/feed_item.dart';
import 'feed_repository.dart';

class MockFeedRepository implements FeedRepository {
  @override
  Future<List<FeedItem>> getFeed() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const [
      FeedItem(
        id: '1',
        category: 'Subnet Activity',
        title: 'Subnet 15 emissions increased by 12%',
        summary:
            'Emissions increased from 41.2 TAO/hr to 46.1 TAO/hr compared to the previous 24h.',
        insight: 'This may increase miner competition inside SN15.',
        timeAgo: '2m ago',
        impact: 'High',
        tags: ['SN15', '+12%', 'Emissions', 'High Impact'],
      ),
      FeedItem(
        id: '2',
        category: 'Stake Movement',
        title: 'Whale staked 28,000 TAO into SN8',
        summary:
            'A new wallet staked 28,000 TAO and delegated to Validator 12 in Subnet 8.',
        insight: 'Large stake inflow may indicate growing confidence in SN8.',
        timeAgo: '7m ago',
        impact: 'High',
        tags: ['SN8', '+28k TAO', 'Validator #12', 'Whale'],
      ),
      FeedItem(
        id: '3',
        category: 'AI Insight',
        title: 'Subnet 19 momentum is increasing',
        summary:
            'Activity, stake inflow, and unique miners on SN19 have grown consistently over the past 7 days.',
        insight: 'SN19 could become a rising subnet to watch.',
        timeAgo: '1h ago',
        impact: 'Medium',
        tags: ['SN19', 'AI Insight', 'Trend'],
      ),
    ];
  }
}
