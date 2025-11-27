import 'package:flutter/material.dart';
import 'package:tapak_jejak/models/membership.dart';
import 'package:tapak_jejak/models/quest.dart';
import 'package:tapak_jejak/services/notification_service.dart';
import 'package:tapak_jejak/services/quest_service.dart';
import 'package:tapak_jejak/widgets/mountain_climber_game.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});

  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  late Membership membership;
  late List<Map<String, dynamic>> levels;
  late List<Quest> dailyQuests;
  late List<Quest> weeklyQuests;
  late List<Quest> achievements;
  late UserActivity userActivity;

  final NotificationService _notificationService = NotificationService();
  final QuestService _questService = QuestService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    levels = Membership.getMembershipLevels();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      // Load real data from QuestService
      membership = await _questService.getCurrentMembership();
      dailyQuests = await _questService.getDailyQuestsWithProgress();
      weeklyQuests = await _questService.getWeeklyQuestsWithProgress();
      achievements = await _questService.getAchievementsWithProgress();
      userActivity = await _questService.getUserActivity();

      setState(() => _isLoading = false);
    } catch (e) {
      print('Error loading data: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _refreshData() async {
    await _loadData();
    _notificationService.showSuccess(context, 'Data berhasil diperbarui!');
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Status Membership')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.green.shade600,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Memuat data membership...'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.shade400,
                Colors.green.shade300,
                Colors.green.shade200,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: [
                Image.asset('assets/LOGO.png', height: 40, width: 40),
                const SizedBox(width: 8),
                Text(
                  'Status Membership',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white, size: 28),
                onPressed: _refreshData,
                tooltip: 'Refresh Data',
              ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      // Add notification functionality
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade50,
              Colors.green.shade50,
              Colors.purple.shade50,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mountain Climber Game
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.terrain,
                              color: Colors.green.shade700,
                              size: 28,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Perjalanan Pendakianmu',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        MountainClimberGame(
                          currentPoints: membership.points,
                          currentLevel: membership.level,
                          onCheckpointReached: (level) {
                            _notificationService.showSuccess(
                              context,
                              'Selamat! Kamu mencapai level $level!',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Current Membership Status
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.amber.shade200, Colors.amber.shade400],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              size: 60,
                              color: Colors.amber.shade700,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Member ${membership.level.toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Bergabung sejak: ${membership.joinDate.day}/${membership.joinDate.month}/${membership.joinDate.year}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Points and Progress
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Poin Anda',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${membership.points} Poin',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              '${membership.pointsToNextLevel} poin lagi ke Platinum',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value:
                              membership.points /
                              (membership.points +
                                  membership.pointsToNextLevel),
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.amber.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Benefits
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Keuntungan Anda',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...membership.benefits.map(
                          (benefit) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green.shade600,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    benefit,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Daily Quests
                _buildQuestSection(
                  'Misi Harian',
                  Icons.today,
                  dailyQuests,
                  Colors.blue,
                ),
                const SizedBox(height: 20),

                // Weekly Quests
                _buildQuestSection(
                  'Misi Mingguan',
                  Icons.calendar_today,
                  weeklyQuests,
                  Colors.orange,
                ),
                const SizedBox(height: 20),

                // Achievements
                _buildQuestSection(
                  'Pencapaian',
                  Icons.emoji_events,
                  achievements,
                  Colors.purple,
                ),
                const SizedBox(height: 20),

                // How to Earn Points
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: Colors.amber.shade700,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Cara Mendapat Poin',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildPointEarningItem(
                          Icons.shopping_bag,
                          'Sewa Alat',
                          '+50 poin per rental',
                          Colors.blue,
                          context,
                        ),
                        _buildPointEarningItem(
                          Icons.shopping_cart,
                          'Beli Produk',
                          '+100 poin per pembelian',
                          Colors.green,
                          context,
                        ),
                        _buildPointEarningItem(
                          Icons.rate_review,
                          'Tulis Review',
                          '+20 poin per review',
                          Colors.orange,
                          context,
                        ),
                        _buildPointEarningItem(
                          Icons.terrain,
                          'Selesaikan Perjalanan',
                          '+150 poin per trip',
                          Colors.red,
                          context,
                        ),
                        _buildPointEarningItem(
                          Icons.search,
                          'Lihat Produk',
                          '+5 poin per produk',
                          Colors.purple,
                          context,
                        ),
                        _buildPointEarningItem(
                          Icons.menu_book,
                          'Baca Tutorial',
                          '+30 poin per tutorial',
                          Colors.teal,
                          context,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Membership Levels
                const Text(
                  'Tingkatan Membership',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...levels.map(
                  (level) => Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: level['color'],
                        child: Text(
                          level['level'][0],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        level['level'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: membership.level == level['level']
                              ? Colors.amber.shade700
                              : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '${level['minPoints']} - ${level['maxPoints']} poin',
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: membership.level == level['level']
                          ? Icon(Icons.star, color: Colors.amber.shade600)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Info Footer
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      '💡 Mulai aktivitas sekarang untuk naik level!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestSection(
    String title,
    IconData icon,
    List<Quest> quests,
    Color color,
  ) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...quests.map((quest) => _buildQuestItem(quest)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestItem(Quest quest) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: quest.isCompleted ? Colors.green.shade50 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: quest.isCompleted
              ? Colors.green.shade300
              : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                quest.icon,
                color: quest.isCompleted
                    ? Colors.green.shade600
                    : Colors.grey.shade600,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  quest.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    decoration: quest.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.stars, color: Colors.amber.shade700, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '+${quest.pointsReward}',
                      style: TextStyle(
                        color: Colors.amber.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            quest.description,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: quest.progressPercentage,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    quest.isCompleted ? Colors.green : Colors.blue.shade600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${quest.currentProgress}/${quest.targetProgress}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPointEarningItem(
    IconData icon,
    String title,
    String points,
    Color color,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // Navigasi ke halaman sesuai opsi
          if (title == 'Sewa Alat') {
            Navigator.pushNamed(context, '/rental');
          } else if (title == 'Beli Produk') {
            Navigator.pushNamed(context, '/produk');
          } else if (title == 'Tulis Review') {
            Navigator.pushNamed(context, '/review');
          } else if (title == 'Selesaikan Perjalanan') {
            Navigator.pushNamed(context, '/trip');
          }
        },
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    points,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
