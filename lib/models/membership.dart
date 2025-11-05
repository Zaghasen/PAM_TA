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

  // Mock data for demonstration
  static Membership getMockMembership() {
    return Membership(
      level: 'Gold',
      points: 1250,
      pointsToNextLevel: 500, // To Platinum
      joinDate: DateTime(2023, 5, 15),
      benefits: [
        'Diskon 15% untuk semua penyewaan',
        'Akses prioritas ke alat baru',
        'Gratis pengiriman untuk pesanan di atas Rp 500.000',
        'Undangan eksklusif ke event outdoor',
        'Support 24/7 via chat',
      ],
    );
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
