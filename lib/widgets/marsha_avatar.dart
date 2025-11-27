import 'package:flutter/material.dart';
import 'package:tapak_jejak/models/chat_message.dart';

class MarshaAvatar extends StatefulWidget {
  final MarshaState state;
  final double size;

  const MarshaAvatar({
    super.key,
    this.state = MarshaState.idle,
    this.size = 120,
  });

  @override
  State<MarshaAvatar> createState() => _MarshaAvatarState();
}

class _MarshaAvatarState extends State<MarshaAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;

  @override
  void initState() {
    super.initState();

    // Breathing animation (idle)
    _breathingController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _breathingAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _breathingController,
      builder: (context, child) {
        return Transform.scale(
          scale: _breathingAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/marsha.png',
                width: widget.size,
                height: widget.size,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
