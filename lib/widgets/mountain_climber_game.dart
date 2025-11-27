import 'package:flutter/material.dart';
import 'dart:math' as math;

// Mountain checkpoint data class
class MountainCheckpoint {
  final String name;
  final String level;
  final double height; // 0.0 (top) to 1.0 (bottom)
  final int requiredPoints;
  final Color color;
  final IconData icon;

  MountainCheckpoint({
    required this.name,
    required this.level,
    required this.height,
    required this.requiredPoints,
    required this.color,
    required this.icon,
  });
}

class MountainClimberGame extends StatefulWidget {
  final int currentPoints;
  final String currentLevel;
  final Function(String)? onCheckpointReached;

  const MountainClimberGame({
    super.key,
    required this.currentPoints,
    required this.currentLevel,
    this.onCheckpointReached,
  });

  @override
  State<MountainClimberGame> createState() => _MountainClimberGameState();
}

class _MountainClimberGameState extends State<MountainClimberGame>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<MountainCheckpoint> checkpoints = [
    MountainCheckpoint(
      name: 'Base Camp',
      level: 'Bronze',
      height: 0.85,
      requiredPoints: 0,
      color: const Color(0xFFCD7F32),
      icon: Icons.home,
    ),
    MountainCheckpoint(
      name: 'Camp 1',
      level: 'Silver',
      height: 0.60,
      requiredPoints: 501,
      color: const Color(0xFFC0C0C0),
      icon: Icons.flag,
    ),
    MountainCheckpoint(
      name: 'Camp 2',
      level: 'Gold',
      height: 0.35,
      requiredPoints: 1001,
      color: const Color(0xFFFFD700),
      icon: Icons.star,
    ),
    MountainCheckpoint(
      name: 'Summit',
      level: 'Platinum',
      height: 0.10,
      requiredPoints: 1501,
      color: const Color(0xFFE5E4E2),
      icon: Icons.emoji_events,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _getClimberPosition() {
    double maxPoints = 1501;
    double progress = (widget.currentPoints / maxPoints).clamp(0.0, 1.0);
    // Invert: 1.0 = bottom (0%), 0.0 = top (100%)
    return 0.85 - (progress * 0.75);
  }

  MountainCheckpoint _getCurrentCheckpoint() {
    for (int i = checkpoints.length - 1; i >= 0; i--) {
      if (widget.currentPoints >= checkpoints[i].requiredPoints) {
        return checkpoints[i];
      }
    }
    return checkpoints[0];
  }

  @override
  Widget build(BuildContext context) {
    double climberPosition = _getClimberPosition();
    MountainCheckpoint currentCheckpoint = _getCurrentCheckpoint();

    return Container(
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade200,
            Colors.blue.shade50,
            Colors.green.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Mountain Background
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 400),
            painter: MountainPainter(),
          ),

          // Checkpoints
          ...checkpoints.map((checkpoint) => _buildCheckpoint(checkpoint)),

          // Climber Avatar with Animation
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                left: 50 + (math.sin(_animation.value * math.pi * 2) * 10),
                top: climberPosition * 400,
                child: TweenAnimationBuilder(
                  duration: const Duration(seconds: 1),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Transform.scale(
                      scale: 0.8 + (value * 0.2),
                      child: child,
                    );
                  },
                  child: _buildClimberAvatar(currentCheckpoint.color),
                ),
              );
            },
          ),

          // Progress Info Card
          Positioned(
            top: 20,
            right: 20,
            child: _buildProgressCard(currentCheckpoint),
          ),

          // Next Milestone Card
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: _buildNextMilestoneCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckpoint(MountainCheckpoint checkpoint) {
    bool isReached = widget.currentPoints >= checkpoint.requiredPoints;
    bool isCurrent = checkpoint.level == widget.currentLevel;

    return Positioned(
      right: 50,
      top: checkpoint.height * 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isReached
                      ? checkpoint.color.withOpacity(0.9)
                      : Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(checkpoint.icon, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      checkpoint.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isReached ? checkpoint.color : Colors.grey,
                  border: Border.all(
                    color: isCurrent ? Colors.yellow : Colors.white,
                    width: isCurrent ? 3 : 2,
                  ),
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                            color: Colors.yellow.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClimberAvatar(Color levelColor) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: levelColor.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 3,
          ),
        ],
        border: Border.all(color: levelColor, width: 3),
      ),
      child: Icon(Icons.person, color: levelColor, size: 35),
    );
  }

  Widget _buildProgressCard(MountainCheckpoint currentCheckpoint) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                currentCheckpoint.icon,
                color: currentCheckpoint.color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                currentCheckpoint.level,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: currentCheckpoint.color,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.currentPoints} poin',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildNextMilestoneCard() {
    MountainCheckpoint? nextCheckpoint;
    for (var checkpoint in checkpoints) {
      if (widget.currentPoints < checkpoint.requiredPoints) {
        nextCheckpoint = checkpoint;
        break;
      }
    }

    if (nextCheckpoint == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade300, Colors.amber.shade500],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.emoji_events, color: Colors.white, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '🎉 Selamat! Kamu sudah mencapai puncak!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
    }

    int pointsNeeded = nextCheckpoint.requiredPoints - widget.currentPoints;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(nextCheckpoint.icon, color: nextCheckpoint.color, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Target: ${nextCheckpoint.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: nextCheckpoint.color,
                  ),
                ),
                Text(
                  '$pointsNeeded poin lagi',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_upward, color: nextCheckpoint.color),
        ],
      ),
    );
  }
}

class MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Mountain paths
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.grey.shade400,
          Colors.grey.shade300,
          Colors.green.shade200,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();

    // Main mountain
    path.moveTo(0, size.height);
    path.lineTo(size.width * 0.3, size.height * 0.4);
    path.lineTo(size.width * 0.5, size.height * 0.1);
    path.lineTo(size.width * 0.7, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Snow cap
    final snowPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final snowPath = Path();
    snowPath.moveTo(size.width * 0.4, size.height * 0.2);
    snowPath.lineTo(size.width * 0.5, size.height * 0.1);
    snowPath.lineTo(size.width * 0.6, size.height * 0.25);
    snowPath.close();

    canvas.drawPath(snowPath, snowPaint);

    // Climbing path (dotted line)
    final pathPaint = Paint()
      ..color = Colors.brown.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final climbPath = Path();
    climbPath.moveTo(size.width * 0.15, size.height * 0.9);
    climbPath.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7,
      size.width * 0.2,
      size.height * 0.6,
    );
    climbPath.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.45,
      size.width * 0.25,
      size.height * 0.35,
    );
    climbPath.quadraticBezierTo(
      size.width * 0.35,
      size.height * 0.25,
      size.width * 0.45,
      size.height * 0.15,
    );

    // Draw dotted line
    _drawDashedPath(canvas, climbPath, pathPaint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 5.0;
    double distance = 0.0;

    for (var pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final segment = pathMetric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
