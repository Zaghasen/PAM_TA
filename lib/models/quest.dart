import 'package:flutter/material.dart';

class Quest {
  final String id;
  final String title;
  final String description;
  final int pointsReward;
  final IconData icon;
  final String type; // 'daily', 'weekly', 'achievement'
  bool isCompleted;
  int currentProgress;
  int targetProgress;

  Quest({
    required this.id,
    required this.title,
    required this.description,
    required this.pointsReward,
    required this.icon,
    required this.type,
    this.isCompleted = false,
    this.currentProgress = 0,
    required this.targetProgress,
  });

  double get progressPercentage =>
      targetProgress > 0 ? currentProgress / targetProgress : 0;

  // Mock daily quests
  static List<Quest> getDailyQuests() {
    return [
      Quest(
        id: 'daily_1',
        title: 'Jelajahi Katalog',
        description: 'Lihat minimal 5 produk hari ini',
        pointsReward: 20,
        icon: Icons.search,
        type: 'daily',
        currentProgress: 0,
        targetProgress: 5,
      ),
      Quest(
        id: 'daily_2',
        title: 'Baca Tutorial',
        description: 'Baca 1 tutorial pendakian',
        pointsReward: 30,
        icon: Icons.menu_book,
        type: 'daily',
        currentProgress: 0,
        targetProgress: 1,
      ),
      Quest(
        id: 'daily_3',
        title: 'Check Cuaca',
        description: 'Cek cuaca untuk perjalanan',
        pointsReward: 15,
        icon: Icons.wb_sunny,
        type: 'daily',
        currentProgress: 0,
        targetProgress: 1,
      ),
    ];
  }

  // Mock weekly quests
  static List<Quest> getWeeklyQuests() {
    return [
      Quest(
        id: 'weekly_1',
        title: 'Rental Pertama',
        description: 'Sewa alat outdoor pertama kamu',
        pointsReward: 100,
        icon: Icons.shopping_bag,
        type: 'weekly',
        currentProgress: 0,
        targetProgress: 1,
      ),
      Quest(
        id: 'weekly_2',
        title: 'Shopping Spree',
        description: 'Beli 3 produk dalam seminggu',
        pointsReward: 150,
        icon: Icons.shopping_cart,
        type: 'weekly',
        currentProgress: 0,
        targetProgress: 3,
      ),
      Quest(
        id: 'weekly_3',
        title: 'Explorer',
        description: 'Tambahkan 5 gunung ke wishlist',
        pointsReward: 50,
        icon: Icons.terrain,
        type: 'weekly',
        currentProgress: 0,
        targetProgress: 5,
      ),
    ];
  }

  // Mock achievements
  static List<Quest> getAchievements() {
    return [
      Quest(
        id: 'achievement_1',
        title: 'Pendaki Pemula',
        description: 'Selesaikan perjalanan pertama',
        pointsReward: 200,
        icon: Icons.military_tech,
        type: 'achievement',
        currentProgress: 0,
        targetProgress: 1,
      ),
      Quest(
        id: 'achievement_2',
        title: 'Reviewer Aktif',
        description: 'Tulis 5 review produk',
        pointsReward: 100,
        icon: Icons.rate_review,
        type: 'achievement',
        currentProgress: 0,
        targetProgress: 5,
      ),
      Quest(
        id: 'achievement_3',
        title: 'Loyal Customer',
        description: 'Belanja selama 3 bulan berturut-turut',
        pointsReward: 300,
        icon: Icons.loyalty,
        type: 'achievement',
        currentProgress: 0,
        targetProgress: 3,
      ),
      Quest(
        id: 'achievement_4',
        title: 'Master Climber',
        description: 'Capai level Platinum',
        pointsReward: 500,
        icon: Icons.emoji_events,
        type: 'achievement',
        currentProgress: 0,
        targetProgress: 1,
      ),
    ];
  }
}

// Activity tracking for point calculation
class UserActivity {
  final String userId;
  int totalRentals;
  int totalPurchases;
  int totalReviews;
  int totalTrips;
  int productsViewed;
  int tutorialsRead;
  int weatherChecks;

  UserActivity({
    required this.userId,
    this.totalRentals = 0,
    this.totalPurchases = 0,
    this.totalReviews = 0,
    this.totalTrips = 0,
    this.productsViewed = 0,
    this.tutorialsRead = 0,
    this.weatherChecks = 0,
  });

  // Calculate total points from activities
  int calculateTotalPoints() {
    return (totalRentals * 50) +
        (totalPurchases * 100) +
        (totalReviews * 20) +
        (totalTrips * 150) +
        (productsViewed * 5) +
        (tutorialsRead * 30) +
        (weatherChecks * 15);
  }

  // Mock user activity for demo
  static UserActivity getMockActivity() {
    return UserActivity(
      userId: 'user_001',
      totalRentals: 0,
      totalPurchases: 0,
      totalReviews: 0,
      totalTrips: 0,
      productsViewed: 0,
      tutorialsRead: 0,
      weatherChecks: 0,
    );
  }
}
