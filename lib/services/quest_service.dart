import 'package:hive/hive.dart';
import 'package:tapak_jejak/models/quest.dart';
import 'package:tapak_jejak/models/membership.dart';

class QuestService {
  static const String userActivityBoxName = 'user_activity';
  static const String questProgressBoxName = 'quest_progress';

  // Singleton pattern
  static final QuestService _instance = QuestService._internal();
  factory QuestService() => _instance;
  QuestService._internal();

  // Get user activity
  Future<UserActivity> getUserActivity() async {
    final box = await Hive.openBox(userActivityBoxName);

    return UserActivity(
      userId: 'user_001',
      totalRentals: box.get('totalRentals', defaultValue: 0),
      totalPurchases: box.get('totalPurchases', defaultValue: 0),
      totalReviews: box.get('totalReviews', defaultValue: 0),
      totalTrips: box.get('totalTrips', defaultValue: 0),
      productsViewed: box.get('productsViewed', defaultValue: 0),
      tutorialsRead: box.get('tutorialsRead', defaultValue: 0),
      weatherChecks: box.get('weatherChecks', defaultValue: 0),
    );
  }

  // Update activity counters
  Future<void> trackRental() async {
    final box = await Hive.openBox(userActivityBoxName);
    int current = box.get('totalRentals', defaultValue: 0);
    await box.put('totalRentals', current + 1);
    await _updateQuestProgress();
  }

  Future<void> trackPurchase() async {
    final box = await Hive.openBox(userActivityBoxName);
    int current = box.get('totalPurchases', defaultValue: 0);
    await box.put('totalPurchases', current + 1);
    await _updateQuestProgress();
  }

  Future<void> trackReview() async {
    final box = await Hive.openBox(userActivityBoxName);
    int current = box.get('totalReviews', defaultValue: 0);
    await box.put('totalReviews', current + 1);
    await _updateQuestProgress();
  }

  Future<void> trackTrip() async {
    final box = await Hive.openBox(userActivityBoxName);
    int current = box.get('totalTrips', defaultValue: 0);
    await box.put('totalTrips', current + 1);
    await _updateQuestProgress();
  }

  Future<void> trackProductView() async {
    final box = await Hive.openBox(userActivityBoxName);
    int current = box.get('productsViewed', defaultValue: 0);
    await box.put('productsViewed', current + 1);
    await _updateQuestProgress();
  }

  Future<void> trackTutorialRead() async {
    final box = await Hive.openBox(userActivityBoxName);
    int current = box.get('tutorialsRead', defaultValue: 0);
    await box.put('tutorialsRead', current + 1);
    await _updateQuestProgress();
  }

  Future<void> trackWeatherCheck() async {
    final box = await Hive.openBox(userActivityBoxName);
    int current = box.get('weatherChecks', defaultValue: 0);
    await box.put('weatherChecks', current + 1);
    await _updateQuestProgress();
  }

  Future<void> trackWishlistAdd() async {
    final box = await Hive.openBox(userActivityBoxName);
    int current = box.get('wishlistAdded', defaultValue: 0);
    await box.put('wishlistAdded', current + 1);
    await _updateQuestProgress();
  }

  // Calculate total points from activities
  Future<int> calculateTotalPoints() async {
    final activity = await getUserActivity();
    return activity.calculateTotalPoints();
  }

  // Get current membership level based on points
  Future<Membership> getCurrentMembership() async {
    final totalPoints = await calculateTotalPoints();
    final level = Membership.getLevelByPoints(totalPoints);
    final pointsToNext = Membership.getPointsToNextLevel(totalPoints);
    final benefits = Membership.getBenefitsForLevel(level);

    final box = await Hive.openBox(userActivityBoxName);
    String? joinDateStr = box.get('joinDate');
    DateTime joinDate;

    if (joinDateStr == null) {
      joinDate = DateTime.now();
      await box.put('joinDate', joinDate.toIso8601String());
    } else {
      joinDate = DateTime.parse(joinDateStr);
    }

    return Membership(
      level: level,
      points: totalPoints,
      pointsToNextLevel: pointsToNext,
      joinDate: joinDate,
      benefits: benefits,
    );
  }

  // Get quests with updated progress
  Future<List<Quest>> getDailyQuestsWithProgress() async {
    final box = await Hive.openBox(userActivityBoxName);
    // Track user activity for potential future use
    // ignore: unused_local_variable
    final activity = await getUserActivity();

    // Reset daily quests at midnight
    await _checkAndResetDailyQuests();

    List<Quest> quests = Quest.getDailyQuests();

    // Update quest 1: Jelajahi Katalog (5 produk)
    int productsViewedToday = box.get('productsViewedToday', defaultValue: 0);
    quests[0].currentProgress = productsViewedToday;
    quests[0].isCompleted = productsViewedToday >= 5;

    // Update quest 2: Baca Tutorial (1 tutorial)
    int tutorialsReadToday = box.get('tutorialsReadToday', defaultValue: 0);
    quests[1].currentProgress = tutorialsReadToday;
    quests[1].isCompleted = tutorialsReadToday >= 1;

    // Update quest 3: Check Cuaca
    int weatherChecksToday = box.get('weatherChecksToday', defaultValue: 0);
    quests[2].currentProgress = weatherChecksToday;
    quests[2].isCompleted = weatherChecksToday >= 1;

    return quests;
  }

  Future<List<Quest>> getWeeklyQuestsWithProgress() async {
    final activity = await getUserActivity();
    final box = await Hive.openBox(userActivityBoxName);

    List<Quest> quests = Quest.getWeeklyQuests();

    // Update quest 1: Rental Pertama
    quests[0].currentProgress = activity.totalRentals > 0 ? 1 : 0;
    quests[0].isCompleted = activity.totalRentals >= 1;

    // Update quest 2: Shopping Spree (3 produk)
    int purchasesThisWeek = box.get('purchasesThisWeek', defaultValue: 0);
    quests[1].currentProgress = purchasesThisWeek;
    quests[1].isCompleted = purchasesThisWeek >= 3;

    // Update quest 3: Explorer (5 wishlist)
    int wishlistAdded = box.get('wishlistAdded', defaultValue: 0);
    quests[2].currentProgress = wishlistAdded;
    quests[2].isCompleted = wishlistAdded >= 5;

    return quests;
  }

  Future<List<Quest>> getAchievementsWithProgress() async {
    final activity = await getUserActivity();
    List<Quest> achievements = Quest.getAchievements();

    // Update achievement 1: Pendaki Pemula
    achievements[0].currentProgress = activity.totalTrips;
    achievements[0].isCompleted = activity.totalTrips >= 1;

    // Update achievement 2: Reviewer Aktif
    achievements[1].currentProgress = activity.totalReviews;
    achievements[1].isCompleted = activity.totalReviews >= 5;

    // Update achievement 3: Loyal Customer (simplified - using total purchases)
    achievements[2].currentProgress = activity.totalPurchases;
    achievements[2].isCompleted = activity.totalPurchases >= 10;

    // Update achievement 4: Master Climber
    int totalPoints = await calculateTotalPoints();
    achievements[3].currentProgress = totalPoints >= 1501 ? 1 : 0;
    achievements[3].isCompleted = totalPoints >= 1501;

    return achievements;
  }

  // Update quest progress and award points if completed
  Future<void> _updateQuestProgress() async {
    // This will be called after each activity
    // You can add logic here to check if any quest was just completed
    // and trigger a notification
  }

  // Reset daily quest counters at midnight
  Future<void> _checkAndResetDailyQuests() async {
    final box = await Hive.openBox(userActivityBoxName);
    String? lastResetStr = box.get('lastDailyReset');
    DateTime now = DateTime.now();

    if (lastResetStr != null) {
      DateTime lastReset = DateTime.parse(lastResetStr);
      if (!_isSameDay(lastReset, now)) {
        // Reset daily counters
        await box.put('productsViewedToday', 0);
        await box.put('tutorialsReadToday', 0);
        await box.put('weatherChecksToday', 0);
        await box.put('lastDailyReset', now.toIso8601String());
      }
    } else {
      await box.put('lastDailyReset', now.toIso8601String());
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  // Track daily activities separately
  Future<void> trackProductViewToday() async {
    final box = await Hive.openBox(userActivityBoxName);
    int current = box.get('productsViewedToday', defaultValue: 0);
    await box.put('productsViewedToday', current + 1);
    await trackProductView(); // Also track for total
  }

  Future<void> trackTutorialReadToday() async {
    final box = await Hive.openBox(userActivityBoxName);
    int current = box.get('tutorialsReadToday', defaultValue: 0);
    await box.put('tutorialsReadToday', current + 1);
    await trackTutorialRead(); // Also track for total
  }

  Future<void> trackWeatherCheckToday() async {
    final box = await Hive.openBox(userActivityBoxName);
    int current = box.get('weatherChecksToday', defaultValue: 0);
    await box.put('weatherChecksToday', current + 1);
    await trackWeatherCheck(); // Also track for total
  }

  // Reset all data (for testing)
  Future<void> resetAllData() async {
    final box = await Hive.openBox(userActivityBoxName);
    await box.clear();
  }
}
