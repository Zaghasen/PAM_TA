import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:tapak_jejak/models/chat_message.dart';
import 'package:tapak_jejak/services/gemini_service.dart';
import 'package:tapak_jejak/widgets/marsha_avatar.dart';

class MarshaChatPanel extends StatefulWidget {
  final VoidCallback onClose;

  const MarshaChatPanel({super.key, required this.onClose});

  @override
  State<MarshaChatPanel> createState() => _MarshaChatPanelState();
}

class _MarshaChatPanelState extends State<MarshaChatPanel>
    with SingleTickerProviderStateMixin {
  final GeminiService _geminiService = GeminiService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  MarshaState _marshaState = MarshaState.greeting;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _slideController.forward();
    _addGreeting();
  }

  void _addGreeting() {
    setState(() {
      _messages.add(
        ChatMessage.marsha(
          '${_geminiService.getGreeting()} Saya Marsha, asisten pendakian kamu! 👋⛰️\n\nAda yang bisa saya bantu hari ini?',
        ),
      );
      _marshaState = MarshaState.greeting;
    });
  }

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage.user(text));
      _messages.add(ChatMessage.typing());
      _isTyping = true;
      _marshaState = MarshaState.thinking;
    });

    _messageController.clear();
    _scrollToBottom();

    try {
      final response = await _geminiService.sendMessage(text);

      setState(() {
        _messages.removeWhere((m) => m.type == MessageType.typing);
        _messages.add(ChatMessage.marsha(response));
        _isTyping = false;
        _marshaState = MarshaState.explaining;
      });

      _scrollToBottom();

      // Return to idle after explanation
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _marshaState = MarshaState.idle);
        }
      });
    } catch (e) {
      setState(() {
        _messages.removeWhere((m) => m.type == MessageType.typing);
        _messages.add(
          ChatMessage.marsha(
            'Ups! Ada masalah dengan koneksi saya. Coba lagi nanti ya! 😅',
          ),
        );
        _isTyping = false;
        _marshaState = MarshaState.idle;
      });
    }
  }

  void _handleQuickAction(String action, String prompt) async {
    setState(() {
      _messages.add(ChatMessage.user(action));
      _messages.add(ChatMessage.typing());
      _isTyping = true;
      _marshaState = MarshaState.thinking;
    });

    _scrollToBottom();

    try {
      String response;
      if (prompt == 'beginner') {
        response = await _geminiService.getBeginnerGuide();
      } else if (prompt == 'safety') {
        response = await _geminiService.getSafetyTips();
      } else {
        response = await _geminiService.sendMessage(action);
      }

      setState(() {
        _messages.removeWhere((m) => m.type == MessageType.typing);
        _messages.add(ChatMessage.marsha(response));
        _isTyping = false;
        _marshaState = MarshaState.explaining;
      });

      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.removeWhere((m) => m.type == MessageType.typing);
        _isTyping = false;
        _marshaState = MarshaState.idle;
      });
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 500) {
            _closePanel();
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.9),
                      Colors.green.shade50.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    _buildHeader(),
                    _buildAvatar(),
                    _buildQuickActions(),
                    Expanded(child: _buildChatHistory()),
                    _buildInputArea(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade400, Colors.teal.shade500],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.psychology_rounded, color: Colors.white, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Marsha - AI Assistant',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Your Hiking Buddy 🏔️',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: _closePanel,
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: MarshaAvatar(state: _marshaState, size: 100),
    );
  }

  Widget _buildQuickActions() {
    if (_messages.length > 2) return SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildQuickActionButton('🏔️ Gunung Pemula', 'beginner'),
              _buildQuickActionButton(
                '🎒 Checklist Peralatan',
                'Apa saja peralatan wajib untuk mendaki?',
              ),
              _buildQuickActionButton('⚠️ Safety Tips', 'safety'),
              _buildQuickActionButton(
                '🌤️ Waktu Terbaik',
                'Kapan waktu terbaik untuk mendaki?',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String label, String prompt) {
    return ElevatedButton(
      onPressed: () => _handleQuickAction(label, prompt),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade100,
        foregroundColor: Colors.green.shade800,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildChatHistory() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];

        if (message.type == MessageType.typing) {
          return _buildTypingIndicator();
        }

        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          gradient: message.isUser
              ? LinearGradient(
                  colors: [Colors.green.shade400, Colors.teal.shade400],
                )
              : null,
          color: message.isUser ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : Colors.black87,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(0),
            SizedBox(width: 4),
            _buildDot(1),
            SizedBox(width: 4),
            _buildDot(2),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.5, end: 1.0),
      duration: Duration(milliseconds: 600),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.green.shade400,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
      onEnd: () {},
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Tanya Marsha apapun...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                  ),
                  textInputAction: TextInputAction.send,
                  onSubmitted: _sendMessage,
                  enabled: !_isTyping,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.teal.shade500],
                ),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.send, color: Colors.white),
                onPressed: _isTyping
                    ? null
                    : () => _sendMessage(_messageController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _closePanel() {
    _slideController.reverse().then((_) {
      widget.onClose();
    });
  }
}
