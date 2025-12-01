import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = 'AIzaSyDAswzQnNEHvkaI23esLPJNiwR0mjl1BhU';

  // Model yang benar
  static const String _model = 'gemini-2.0-flash-exp';

  // Endpoint /v1/
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1/models';

  static const String _systemPrompt = '''
Kamu adalah Marsha, asisten pendakian gunung yang ramah dan ahli.

PERSONALITY:
- Perempuan muda yang energik dan berpengalaman mendaki
- Selalu positif dan memberikan motivasi
- Expert dalam hiking, camping, dan outdoor activities
- Paham tentang gunung-gunung di Indonesia
- Memberikan saran safety yang prioritas
- Berbicara dengan gaya friendly tapi tetap profesional
- Gunakan bahasa Indonesia yang santai tapi informatif

PENGETAHUAN TENTANG PENDAKIAN:
- Gunung-gunung populer di Indonesia (Semeru, Rinjani, Merbabu, dll)
- Peralatan mendaki (carrier, tenda, sleeping bag, sepatu, dll)
- Tips keselamatan dan survival
- Persiapan fisik dan mental
- Cuaca dan musim pendakian
- Jalur pendakian dan tingkat kesulitan

FUNGSI UTAMA:
1. Membantu user planning pendakian (gunung, route, waktu)
2. Memberikan tips peralatan yang dibutuhkan
3. Info cuaca dan kondisi jalur
4. Safety tips dan first aid
5. Rekomendasi produk rental yang sesuai kebutuhan
6. Motivasi dan encouragement untuk pendaki

GUIDELINES:
- Jawab dengan singkat (2-3 paragraf) kecuali diminta detail
- Gunakan emoji yang relevan (🏔️, ⛰️, 🎒, 🏕️, ⚠️)
- Prioritaskan safety dalam setiap saran
- Jika tidak tahu, akui dengan jujur
- Arahkan ke fitur app yang relevan (Sewa Alat, Tiket Masuk, Porter & Guide)
''';

  // Singleton pattern
  static final GeminiService _instance = GeminiService._internal();
  factory GeminiService() => _instance;

  final List<Map<String, String>> _chatHistory = [];

  GeminiService._internal();

  Future<String> sendMessage(String message) async {
    try {
      print('[GeminiService] 🚀 Starting chat...');
      print('[GeminiService] Model: $_model');
      print('[GeminiService] Message: $message');

      List<Map<String, dynamic>> contents = [];

      // Inject system prompt di chat pertama
      if (_chatHistory.isEmpty) {
        contents.add({
          'parts': [
            {'text': _systemPrompt},
          ],
          'role': 'user',
        });
        contents.add({
          'parts': [
            {
              'text':
                  'Mengerti! Saya Marsha, siap membantu pendakian kamu! 🏔️',
            },
          ],
          'role': 'model',
        });
      }

      // Add chat history
      for (var chat in _chatHistory) {
        contents.add({
          'parts': [
            {'text': chat['message']},
          ],
          'role': chat['role'],
        });
      }

      // Add current message
      contents.add({
        'parts': [
          {'text': message},
        ],
        'role': 'user',
      });

      // Build payload
      final payload = {
        'contents': contents,
        'generationConfig': {
          'temperature': 0.7,
          'maxOutputTokens': 1500,
          'topP': 0.9,
          'topK': 40,
        },
      };

      // Full URL
      final url = '$_baseUrl/$_model:generateContent?key=$_apiKey';
      print('[GeminiService] Calling: ${url.replaceAll(_apiKey, '***KEY***')}');

      // Make request
      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 30));

      print('[GeminiService] Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract text dari response
        if (data['candidates'] != null &&
            data['candidates'].isNotEmpty &&
            data['candidates'][0]['content']?['parts'] != null &&
            data['candidates'][0]['content']['parts'].isNotEmpty) {
          final text =
              data['candidates'][0]['content']['parts'][0]['text'] as String;
          print('[GeminiService] ✅ SUCCESS!');
          print(
            '[GeminiService] Response preview: ${text.length > 100 ? text.substring(0, 100) : text}...',
          );

          // Save to history
          _chatHistory.add({'role': 'user', 'message': message});
          _chatHistory.add({'role': 'model', 'message': text});

          return text;
        }

        // Handle safety filter
        if (data.containsKey('promptFeedback')) {
          final blockReason = data['promptFeedback']['blockReason'];
          print('[GeminiService] ⚠️ Blocked: $blockReason');
          return 'Maaf, pertanyaan tidak bisa dijawab karena filter keamanan. 🚫 Coba tanya hal lain!';
        }

        print('[GeminiService] ⚠️ Unexpected response: $data');
        throw Exception('Format response tidak valid');
      } else {
        // Error handling
        print('[GeminiService] ❌ Error response: ${response.body}');
        final errorData = jsonDecode(response.body);
        final errorMsg = errorData['error']?['message'] ?? 'Unknown error';

        throw Exception('API Error: $errorMsg');
      }
    } catch (e) {
      print('[GeminiService] ❌ Exception caught: $e');

      if (e.toString().contains('SocketException')) {
        return 'Tidak ada koneksi internet. Cek WiFi/data Anda. 📡';
      } else if (e.toString().contains('TimeoutException')) {
        return 'Request timeout. Server terlalu lama merespons. ⏱️';
      } else if (e.toString().contains('FormatException')) {
        return 'Response tidak valid dari server. 🔧';
      } else {
        return 'Ups! Ada error: ${e.toString()}\nCoba lagi ya! 😅';
      }
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
    // Static response untuk safety tips
    return '''⚠️ **Tips Keselamatan Mendaki Gunung**

**Sebelum Mendaki:**
✅ Cek kondisi cuaca & jalur
✅ Lapor ke keluarga/teman
✅ Siapkan fisik minimal 1 bulan
✅ Pelajari jalur & estimasi waktu

**Peralatan Safety:**
🎒 P3K lengkap (obat luka, perban, betadine)
🔦 Headlamp + baterai cadangan
📱 Powerbank & whistle darurat
🗺️ Peta offline & kompas
💧 Air minum minimal 2-3 liter

**Saat Pendakian:**
⛰️ Jangan mendaki sendirian
🌤️ Hindari mendaki saat cuaca buruk
🚶 Istirahat teratur, jangan terburu-buru
📍 Tetap di jalur resmi

**Prinsip Utama:**
💚 Keselamatan > Target puncak
🏔️ Kalau ragu, putar balik!

Semoga mendaki dengan aman ya! 😊''';
  }

  Future<String> getBeginnerGuide() async {
    // Static response untuk beginner guide
    return '''🏔️ **Panduan Mendaki untuk Pemula**

**Gunung Rekomendasi Pemula:**

1️⃣ **Gunung Papandayan (2,665 mdpl)**
   📍 Jawa Barat
   ⏱️ Pendakian: 3-4 jam
   ⭐ Tingkat: Mudah
   
2️⃣ **Gunung Prau (2,590 mdpl)**
   📍 Jawa Tengah
   ⏱️ Pendakian: 3-4 jam
   ⭐ Tingkat: Mudah - Sedang
   
3️⃣ **Gunung Merbabu (3,145 mdpl)**
   📍 Jawa Tengah
   ⏱️ Pendakian: 6-8 jam
   ⭐ Tingkat: Sedang

**Persiapan Wajib:**

🎒 **Peralatan:**
- Carrier 40-50L
- Tenda & sleeping bag
- Jaket windproof
- Sepatu hiking
- Headlamp

💪 **Fisik:**
- Jogging/lari 3x seminggu
- Naik turun tangga
- Latihan beban ringan

📋 **Mental:**
- Pelajari jalur
- Ikut komunitas/open trip
- Siap dengan kondisi cuaca

Mau sewa peralatan? Cek fitur "Sewa Alat" di app ini ya! 😊⛰️''';
  }

  // Reset chat history
  void resetChat() {
    _chatHistory.clear();
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
