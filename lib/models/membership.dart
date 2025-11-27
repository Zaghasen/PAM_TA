import 'package:flutter/material.dart';

class Membership {
  String level;
  int points;
  int pointsToNextLevel;
  DateTime joinDate;
  List<String> benefits;

  Membership({
    required this.level,
    required this.points,
    required this.pointsToNextLevel,
    required this.joinDate,
    required this.benefits,
  });

  // Mock data for demonstration - New user starts from Bronze with 0 points
  static Membership getMockMembership() {
    return Membership(
      level: 'Bronze',
      points: 0,
      pointsToNextLevel: 500, // To Silver
      joinDate: DateTime.now(),
      benefits: [
        'Diskon 5% untuk penyewaan',
        'Akses ke tutorial dasar',
        'Akses ke komunitas pendaki',
      ],
    );
  }

  // Calculate level based on points
  static String getLevelByPoints(int points) {
    if (points >= 1501) return 'Platinum';
    if (points >= 1001) return 'Gold';
    if (points >= 501) return 'Silver';
    return 'Bronze';
  }

  // Calculate points to next level
  static int getPointsToNextLevel(int currentPoints) {
    if (currentPoints >= 1501) return 0; // Max level
    if (currentPoints >= 1001) return 1501 - currentPoints;
    if (currentPoints >= 501) return 1001 - currentPoints;
    return 501 - currentPoints;
  }

  // Get benefits for current level
  static List<String> getBenefitsForLevel(String level) {
    switch (level) {
      case 'Bronze':
        return [
          'Diskon 5% untuk penyewaan',
          'Akses ke tutorial dasar',
          'Akses ke komunitas pendaki',
        ];
      case 'Silver':
        return [
          'Diskon 10% untuk penyewaan',
          'Akses prioritas ke alat populer',
          'Gratis pengiriman untuk pesanan di atas Rp 250.000',
          'Akses ke tutorial advanced',
        ];
      case 'Gold':
        return [
          'Diskon 15% untuk semua penyewaan',
          'Akses prioritas ke alat baru',
          'Gratis pengiriman untuk pesanan di atas Rp 500.000',
          'Undangan eksklusif ke event outdoor',
          'Badge Gold di profil',
        ];
      case 'Platinum':
        return [
          'Diskon 20% untuk semua penyewaan',
          'Akses VIP ke semua alat',
          'Gratis pengiriman tanpa batas',
          'Undangan eksklusif ke event premium',
          'Support 24/7 via chat dan telepon',
          'Bonus poin tambahan untuk setiap pembelian',
          'Badge Platinum eksklusif',
        ];
      default:
        return [];
    }
  }

  static List<Map<String, dynamic>> getMembershipLevels() {
    return [
      {
        'level': 'Bronze',
        'minPoints': 0,
        'maxPoints': 500,
        'color': const Color(0xFFCD7F32),
        'benefits': ['Diskon 5% untuk penyewaan', 'Akses ke tutorial dasar'],
      },
      {
        'level': 'Silver',
        'minPoints': 501,
        'maxPoints': 1000,
        'color': const Color(0xFFC0C0C0),
        'benefits': [
          'Diskon 10% untuk penyewaan',
          'Akses prioritas ke alat populer',
          'Gratis pengiriman untuk pesanan di atas Rp 250.000',
        ],
      },
      {
        'level': 'Gold',
        'minPoints': 1001,
        'maxPoints': 1500,
        'color': const Color(0xFFFFD700),
        'benefits': [
          'Diskon 15% untuk semua penyewaan',
          'Akses prioritas ke alat baru',
          'Gratis pengiriman untuk pesanan di atas Rp 500.000',
          'Undangan eksklusif ke event outdoor',
        ],
      },
      {
        'level': 'Platinum',
        'minPoints': 1501,
        'maxPoints': 9999,
        'color': const Color(0xFFE5E4E2),
        'benefits': [
          'Diskon 20% untuk semua penyewaan',
          'Akses VIP ke semua alat',
          'Gratis pengiriman tanpa batas',
          'Undangan eksklusif ke event premium',
          'Support 24/7 via chat dan telepon',
          'Bonus poin tambahan untuk setiap pembelian',
        ],
      },
    ];
  }
}
