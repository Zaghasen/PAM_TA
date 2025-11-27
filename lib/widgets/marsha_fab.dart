import 'package:flutter/material.dart';
import 'dart:math' as math;

class MarshaFAB extends StatefulWidget {
  final VoidCallback onTap;
  final bool hasNotification;
  final bool isOpen;

  const MarshaFAB({
    super.key,
    required this.onTap,
    this.hasNotification = false,
    this.isOpen = false,
  });

  @override
  State<MarshaFAB> createState() => _MarshaFABState();
}

class _MarshaFABState extends State<MarshaFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _breathingAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _breathingAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _rotationAnimation =
        Tween<double>(
          begin: 0,
          end: math.pi / 4, // 45 degrees for X icon
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.isOpen ? 1.0 : _breathingAnimation.value,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.isOpen
                      ? [Colors.red.shade400, Colors.red.shade600]
                      : [Colors.green.shade400, Colors.teal.shade500],
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.isOpen
                        ? Colors.red.withOpacity(0.4)
                        : Colors.green.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Main icon
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        turns: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: widget.isOpen
                        ? const Icon(
                            Icons.close,
                            key: ValueKey('close'),
                            color: Colors.white,
                            size: 35,
                          )
                        : ClipOval(
                            key: ValueKey('marsha'),
                            child: Image.asset(
                              'assets/marsha.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),

                  // Sparkle effect when not open
                  if (!widget.isOpen)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Transform.rotate(
                        angle: _animationController.value * 2 * math.pi,
                        child: Icon(
                          Icons.auto_awesome,
                          color: Colors.white.withOpacity(0.8),
                          size: 16,
                        ),
                      ),
                    ),

                  // Notification badge
                  if (widget.hasNotification && !widget.isOpen)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            '!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
