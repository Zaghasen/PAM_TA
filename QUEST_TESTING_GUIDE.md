# 🎮 Panduan Testing Sistem Quest & Gamification

## Fitur yang Sudah Diimplementasikan ✅

### 1. **Real-time Quest System**

- Quest Daily, Weekly, dan Achievement
- Progress tracking otomatis
- Update UI real-time dengan setState

### 2. **Point System**

Aktivitas yang memberikan poin:

- ✅ **Lihat produk**: +5 poin (tracked otomatis saat buka product detail)
- ✅ **Tambah ke cart/rental**: +50 poin
- ✅ **Tambah ke wishlist**: Tracked untuk quest "Explorer"
- ✅ **Baca tutorial**: +30 poin (tracked saat buka tutorial)
- ✅ **Check cuaca**: +15 poin (tracked saat buka weather page)

### 3. **Mountain Climber Game**

- Visual gunung interaktif
- 4 checkpoint: Base Camp → Camp 1 → Camp 2 → Summit
- Avatar pendaki yang bergerak sesuai progress poin
- Animasi smooth dan responsive

## 🧪 Cara Testing

### Test 1: Daily Quest - "Jelajahi Katalog"

1. Buka halaman Membership
2. Lihat quest "Jelajahi Katalog" (target: 5 produk)
3. Buka halaman Sewa Alat (atau produk apapun)
4. Buka detail 5 produk berbeda
5. Kembali ke Membership → Klik icon refresh ↻ di app bar
6. **Expected**: Progress quest berubah 0/5 → 5/5 ✅

### Test 2: Daily Quest - "Baca Tutorial"

1. Buka halaman Tutorial
2. Baca 1 tutorial (buka detail)
3. Kembali ke Membership → Refresh
4. **Expected**: Quest "Baca Tutorial" selesai (1/1) ✅

### Test 3: Daily Quest - "Check Cuaca"

1. Buka halaman Cuaca
2. Pilih lokasi dan lihat detail cuaca
3. Kembali ke Membership → Refresh
4. **Expected**: Quest "Check Cuaca" selesai (1/1) ✅

### Test 4: Weekly Quest - "Rental Pertama"

1. Buka halaman produk
2. Tambahkan produk ke keranjang (klik "Tambah ke Keranjang")
3. Lihat notifikasi: "... +50 poin" 🎉
4. Kembali ke Membership → Refresh
5. **Expected**:
   - Quest "Rental Pertama" selesai (1/1) ✅
   - Total poin bertambah +50
   - Avatar pendaki naik di gunung

### Test 5: Weekly Quest - "Explorer" (Wishlist)

1. Buka halaman produk
2. Klik icon ❤️ (favorite) pada 5 produk berbeda
3. Kembali ke Membership → Refresh
4. **Expected**: Quest "Explorer" selesai (5/5) ✅

### Test 6: Mountain Climber Game Animation

1. Lakukan berbagai aktivitas (rental, baca tutorial, dll)
2. Setiap kembali ke Membership → Refresh
3. **Expected**:
   - Avatar pendaki bergerak naik
   - Checkpoint berubah warna saat tercapai
   - Progress card update real-time
   - Next milestone card update

### Test 7: Reset Data (Untuk Testing Ulang)

```dart
// Tambahkan button temporary di membership page atau run di debug console:
QuestService().resetAllData();
```

## 📊 Monitoring Progress

### Cara Check Progress:

1. **Buka Membership Page**
2. **Klik icon Refresh (↻)** di app bar kanan atas
3. Lihat perubahan:
   - Poin total di game gunung
   - Progress bar di setiap quest
   - Status quest (✅ completed atau progress x/y)
   - Level membership (Bronze → Silver → Gold → Platinum)

### Debug Tips:

Jika quest tidak update:

1. Pastikan klik **Refresh button** di Membership page
2. Cek apakah aktivitas benar-benar dilakukan (misal: buka DETAIL produk, bukan hanya list)
3. Restart app jika perlu (data tersimpan di Hive)

## 🎯 Quest Completion Targets

### Daily Quests:

- Jelajahi Katalog: 5 produk → +20 poin
- Baca Tutorial: 1 tutorial → +30 poin
- Check Cuaca: 1 kali → +15 poin

### Weekly Quests:

- Rental Pertama: 1 rental → +100 poin
- Shopping Spree: 3 pembelian → +150 poin
- Explorer: 5 wishlist → +50 poin

### Achievements:

- Pendaki Pemula: 1 trip → +200 poin
- Reviewer Aktif: 5 review → +100 poin
- Loyal Customer: 10 pembelian → +300 poin
- Master Climber: Level Platinum → +500 poin

## 🏔️ Membership Levels

| Level    | Poin Required | Benefit                                          |
| -------- | ------------- | ------------------------------------------------ |
| Bronze   | 0 - 500       | Diskon 5%, Tutorial basic                        |
| Silver   | 501 - 1000    | Diskon 10%, Free shipping >250k                  |
| Gold     | 1001 - 1500   | Diskon 15%, Free shipping >500k, Event access    |
| Platinum | 1501+         | Diskon 20%, Free shipping unlimited, VIP support |

## 🔄 Data Persistence

Semua progress disimpan menggunakan **Hive** (local storage):

- ✅ Total points
- ✅ Activity counters
- ✅ Quest progress
- ✅ Daily reset tracking
- ✅ Membership level

Data akan **tetap tersimpan** meskipun app ditutup!

## 🎨 UI Features

1. **Loading State**: Spinner saat memuat data
2. **Refresh Button**: Manual refresh untuk update latest data
3. **Points Notification**: Snackbar hijau dengan emoji 🎉
4. **Quest Progress Bar**: Visual progress untuk setiap quest
5. **Mountain Game**: Animated climbing game
6. **Checkpoint Badges**: Colored badges untuk setiap level

---

**Note**: Sistem ini sekarang **FULLY RESPONSIVE** dan **REAL-TIME**! 🚀

Setiap aktivitas user akan:

1. Langsung tracked ke database (Hive)
2. Update quest progress
3. Calculate points
4. Show notification
5. Update UI saat refresh
