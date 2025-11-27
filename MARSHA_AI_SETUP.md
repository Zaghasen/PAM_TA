# 🤖 Marsha AI Assistant - Setup Guide

## 🎯 Overview

Marsha adalah AI Assistant yang terintegrasi dengan Google Gemini AI untuk membantu user dalam:

- Perencanaan pendakian gunung
- Rekomendasi peralatan
- Tips keselamatan
- Info cuaca dan route
- Panduan untuk pendaki pemula

## 🔧 Setup API Key

### 1. Dapatkan Gemini API Key

1. Buka [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Login dengan Google account
3. Klik "Create API Key"
4. Copy API key yang dihasilkan

### 2. Tambahkan API Key ke Project

Buka file: `lib/services/gemini_service.dart`

Ganti baris:

```dart
static const String _apiKey = 'YOUR_GEMINI_API_KEY_HERE';
```

Dengan API key kamu:

```dart
static const String _apiKey = 'AIzaSy...'; // API key dari Google AI Studio
```

## 🎨 Features

### ✨ Marsha Floating Action Button

- **Lokasi**: Pojok kanan bawah home page
- **Animasi**: Breathing effect (membesar-kecil)
- **Badge**: Notifikasi merah untuk first-time tip
- **Transform**: Berubah jadi X icon saat chat terbuka

### 💬 Chat Panel Interface

- **Slide Animation**: Muncul dari bawah dengan smooth animation
- **Glassmorphism**: Blur background dengan gradient overlay
- **Drag to Close**: Swipe down untuk menutup
- **Real-time Chat**: Conversation dengan AI

### 👩 Marsha Avatar

- **Animated Character**: Karakter perempuan dengan hiking gear
- **Expressions**:
  - 😊 **Greeting**: Wave animation saat menyambut
  - 🤔 **Thinking**: Sedang memproses pertanyaan
  - 💡 **Explaining**: Menjelaskan dengan gestures
  - 👍 **Encouraging**: Memberi motivasi
  - ⚠️ **Warning**: Memberikan peringatan safety
- **Breathing & Blinking**: Natural idle animation

### 🚀 Quick Actions

Tombol shortcut untuk pertanyaan umum:

- 🏔️ **Gunung Pemula**: Rekomendasi gunung untuk pemula
- 🎒 **Checklist Peralatan**: Daftar peralatan wajib
- ⚠️ **Safety Tips**: Tips keselamatan pendakian
- 🌤️ **Waktu Terbaik**: Waktu ideal untuk mendaki

### 🎤 Input Methods

- **Text Input**: Ketik pertanyaan di chat box
- **Send Button**: Klik untuk kirim pesan
- **Enter Key**: Tekan Enter untuk kirim

## 📱 User Flow

1. **Open Home Page** → Lihat Marsha FAB di pojok kanan bawah
2. **Tap FAB** → Chat panel slide up dengan animasi
3. **Marsha Greeting** → Avatar wave + greeting message
4. **Choose Action**:
   - Tap quick action button
   - Ketik pertanyaan sendiri
5. **Get Response** → Marsha thinking → AI response
6. **Continue Chat** → Conversation history tersimpan
7. **Close** → Swipe down / tap X / tap background

## 🎭 Marsha Personality

Marsha dirancang dengan personality:

- **Ramah & Energik**: Greeting yang warm dan motivating
- **Expert**: Knowledgeable tentang hiking & outdoor
- **Safety First**: Prioritas utama keselamatan
- **Bahasa Santai**: Indonesian yang friendly tapi profesional
- **Emoji Usage**: Pakai emoji untuk lebih hidup

## 💬 Sample Conversations

### Example 1: Pemula

**User**: "Saya pemula, gunung apa yang bagus?"
**Marsha**: "Halo pendaki pemula! 🌟 Untuk pemulai, saya rekomendasikan:

1. **Gunung Prau** (Dieng) - 2.565 mdpl

   - Jalur relatif mudah
   - Pemandangan sunrise yang indah
   - Pendakian 3-4 jam

2. **Gunung Papandayan** (Garut) - 2.665 mdpl
   - Bisa naik turun sehari
   - Kawah aktif yang spektakuler
   - Jalur lebar dan aman

Persiapan penting:

- Sepatu hiking yang nyaman
- Jaket windproof
- Headlamp & powerbank
- Bawa air 2-3 liter

Yuk mulai petualangan kamu! 💪⛰️"

### Example 2: Equipment

**User**: "Peralatan apa yang harus dibawa ke Rinjani?"
**Marsha**: "Untuk pendakian Gunung Rinjani (3-4 hari), ini checklist lengkapnya! 🎒

**Must Have**:
✅ Carrier 60L+ (berat barang ~15kg)
✅ Sleeping bag suhu -5°C (dingin di malam hari!)
✅ Tenda 2-3 orang
✅ Matras/sleeping pad
✅ Jaket windproof + inner thermal
✅ Trekking pole (untuk turunan)
✅ Headlamp + baterai cadangan

**Pakaian**:
✅ Kaos quick dry 3 pcs
✅ Celana hiking panjang 2 pcs
✅ Jaket tebal/down jacket
✅ Buff/masker
✅ Topi/hat
✅ Sarung tangan

Kalau mau rental, saya bisa bantu rekomendasi toko yang oke! 😊"

## 🔥 Advanced Features (Future)

- 🎤 **Voice Input**: Speech-to-text untuk tanya voice
- 📍 **Location Aware**: Saran berdasarkan lokasi user
- 📊 **Analytics**: Track pertanyaan populer
- 🏆 **Gamification**: Badge untuk chat tertentu
- 🌐 **Multi-language**: Support English

## ⚙️ Configuration

### Customize Marsha Personality

Edit file: `lib/services/gemini_service.dart`

Ubah system prompt di `_initializeChat()`:

```dart
_chat = _model.startChat(history: [
  Content.text('''
Kamu adalah Marsha, asisten pendakian...
[Customize personality disini]
'''),
```

### Adjust Response Settings

```dart
generationConfig: GenerationConfig(
  temperature: 0.7,      // Creativity (0.0-1.0)
  topK: 40,              // Sampling parameter
  topP: 0.95,            // Nucleus sampling
  maxOutputTokens: 1024, // Max response length
),
```

## 🐛 Troubleshooting

### Issue: "Koneksi bermasalah"

**Solution**:

- Cek internet connection
- Pastikan API key valid
- Cek quota API (gratis ada limit)

### Issue: FAB tidak muncul

**Solution**:

- Pastikan sudah di home page
- Cek import statements
- Restart app

### Issue: Marsha tidak respond

**Solution**:

- Cek API key sudah benar
- Tunggu beberapa detik (API processing)
- Cek console untuk error message

## 📊 API Quota

Free tier Gemini API:

- **60 requests per minute**
- **1,500 requests per day**
- Cukup untuk testing dan demo

Untuk production, consider upgrade ke paid tier.

## 🎨 Customization Tips

### Change Avatar Color

Edit: `lib/widgets/marsha_avatar.dart`

```dart
gradient: LinearGradient(
  colors: [
    Colors.green.shade300,  // Change this
    Colors.teal.shade400,   // And this
  ],
),
```

### Change FAB Position

Edit: `lib/screens/home/home_page.dart`

```dart
Positioned(
  right: 20,  // Horizontal position
  bottom: 20, // Vertical position
  child: MarshaFAB(...),
),
```

---

## 🚀 Ready to Test!

1. ✅ Install dependencies: `flutter pub get`
2. ✅ Add API key ke `gemini_service.dart`
3. ✅ Run app: `flutter run`
4. ✅ Tap FAB di home page
5. ✅ Chat dengan Marsha! 🎉

**Happy Hiking with Marsha! 🏔️✨**
