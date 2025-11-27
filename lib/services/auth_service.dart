import 'package:hive/hive.dart';
import 'package:tapak_jejak/services/notification_controller.dart';

class AuthService {
  static const String userBoxName = 'userBox';
  static const String sessionBoxName = 'sessionBox';

  Box get _userBox => Hive.box(userBoxName);
  Box get _sessionBox => Hive.box(sessionBoxName);

  Future<void> activateSubscription({
    required int days,
    required int additionalQuota,
    required String packageName,
  }) async {
    final username = _sessionBox.get('loggedInUser');
    if (username == null) return;

    try {
      final user = _userBox.values.firstWhere((u) => u.username == username);
      final until = DateTime.now().add(Duration(days: days));
      user.isSubscribed = true;
      user.subscriptionUntil = until.toIso8601String().split('T').first;
      user.remainingQuota += additionalQuota;
      await user.save();

      await NotificationController.showSuccessNotification(
        'Langganan $packageName Aktif',
        'Paket $packageName berhasil diaktifkan hingga ${user.subscriptionUntil}.',
      );
    } catch (e) {
      // Handle error if user not found or other issues
      print('Error activating subscription: $e');
    }
  }
}
