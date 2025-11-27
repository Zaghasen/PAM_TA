import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String _apiKey =
      'AIzaSyDAswzQnNEHvkaI23esLPJNiwR0mjl1BhU'; // API key dari user
  late final GenerativeModel _model;
  late final ChatSession _chat;

  // Singleton pattern
  static final GeminiService _instance = GeminiService._internal();
  factory GeminiService() => _instance;

  GeminiService._internal() {
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.7,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 1024,
      ),
    );

    _initializeChat();
  }

  void _initializeChat() {
    _chat = _model.startChat(
      history: [
        Content.text('''
Kamu adalah Marsha, asisten pendakian gunung yang ramah dan ahli.
Karaktermu:
- Perempuan muda yang energik dan berpengalaman mendaki
- Selalu positif dan memberikan motivasi
- Expert dalam hiking, camping, dan outdoor activities
- Paham tentang gunung-gunung di Indonesia
- Memberikan saran safety yang prioritas
- Berbicara dengan gaya friendly tapi tetap profesional
- Gunakan bahasa Indonesia yang santai tapi informatif

Tugasmu:
1. Membantu user planning pendakian (gunung, route, waktu)
2. Memberikan tips peralatan yang dibutuhkan
3. Info cuaca dan kondisi jalur
4. Safety tips dan first aid
5. Rekomendasi produk rental yang sesuai kebutuhan
6. Motivasi dan encouragement untuk pendaki

Jawab dengan singkat (2-3 paragraf) kecuali diminta detail.
Gunakan emoji yang relevan untuk membuat percakapan lebih hidup.
'''),
        Content.model([
          TextPart(
            'Halo! Saya Marsha, asisten pendakian kamu! 👋⛰️\n\nSaya siap membantu kamu merencanakan petualangan outdoor yang aman dan menyenangkan. Mau tanya tentang gunung, peralatan, atau tips pendakian? Tanya aja! 😊',
          ),
        ]),
      ],
    );
  }

  // Send message and get response
  Future<String> sendMessage(String message) async {
    try {
      final response = await _chat.sendMessage(Content.text(message));
      return response.text ??
          'Maaf, saya tidak bisa memproses pertanyaan itu. Coba tanya yang lain? 🤔';
    } catch (e) {
      print('Error sending message: $e');
      return 'Ups! Koneksi saya sedang bermasalah. Coba lagi nanti ya! 😅';
    }
  }

  // Get contextual greeting based on time
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat pagi! ☀️';
    } else if (hour < 15) {
      return 'Selamat siang! 😊';
    } else if (hour < 18) {
      return 'Selamat sore! 🌤️';
    } else {
      return 'Selamat malam! 🌙';
    }
  }

  // Quick action responses
  Future<String> getMountainInfo(String mountainName) async {
    return sendMessage(
      'Tolong kasih info lengkap tentang Gunung $mountainName, termasuk jalur pendakian, tingkat kesulitan, dan tips khusus.',
    );
  }

  Future<String> getWeatherAdvice(String location) async {
    return sendMessage(
      'Bagaimana kondisi cuaca dan waktu terbaik untuk mendaki di $location?',
    );
  }

  Future<String> getEquipmentList(String tripType) async {
    return sendMessage(
      'Peralatan apa saja yang harus saya bawa untuk $tripType? Buat dalam bentuk checklist.',
    );
  }

  Future<String> getSafetyTips() async {
    return sendMessage(
      'Apa saja tips keselamatan penting yang harus diperhatikan saat mendaki gunung?',
    );
  }

  Future<String> getBeginnerGuide() async {
    return sendMessage(
      'Saya pemula dan ingin mulai mendaki. Gunung mana yang cocok dan apa yang harus saya persiapkan?',
    );
  }

  // Reset chat history
  void resetChat() {
    _initializeChat();
  }

  // Get suggested questions
  List<String> getSuggestedQuestions() {
    return [
      '🏔️ Gunung mana yang cocok untuk pemula?',
      '🎒 Apa saja peralatan wajib mendaki?',
      '🌤️ Kapan waktu terbaik mendaki Semeru?',
      '⚠️ Tips safety untuk pendaki solo?',
      '💪 Bagaimana cara training untuk mendaki?',
      '🏕️ Rekomendasi camping ground di Rinjani?',
    ];
  }
}
