# 🎨 Panduan Warna Card - TAPAK JEJAK

Dokumen ini berisi daftar semua warna yang digunakan di card-card aplikasi, sehingga Anda bisa mengubahnya dengan mudah sewaktu-waktu.

---

## 📱 HOME PAGE (`lib/screens/home/home_page.dart`)

### 1. **AppBar Gradient**

- **Lokasi**: Line ~68-70
- **Warna**:
  ```dart
  Colors.green.shade400,  // Hijau terang
  Colors.green.shade300,  // Hijau sedang
  Colors.green.shade200,  // Hijau muda
  ```

### 2. **Service Icons Card**

- **Lokasi**: Line ~192
- **Warna Background Gradient**:
  ```dart
  Colors.green.shade100,  // Hijau sangat muda (kiri atas)
  Colors.green.shade50,   // Hijau sangat pucat (kanan bawah)
  ```
- **Shadow Card**:
  ```dart
  Colors.black.withOpacity(0.1)  // Hitam transparan
  ```
- **Teks Judul**:
  ```dart
  Color(0xFF2A4D3A)  // Hijau gelap
  ```
- **Shadow Teks**:
  ```dart
  Colors.black.withOpacity(0.3)  // Hitam transparan
  ```

### 3. **Service Icon Individual**

- **Lokasi**: Line ~544
- **Warna Background**:
  ```dart
  Colors.white  // Putih
  ```
- **Shadow**:
  ```dart
  Colors.black.withOpacity(0.1)  // Hitam transparan
  ```

### 4. **Monitoring Card**

- **Lokasi**: Line ~343
- **Warna Background Gradient**:
  ```dart
  Colors.green.shade100,  // Hijau sangat muda
  Colors.green.shade50,   // Hijau sangat pucat
  ```
- **Shadow**:
  ```dart
  Colors.black.withOpacity(0.1)  // Hitam transparan
  ```
- **Teks Judul**:
  ```dart
  Color(0xFF2A4D3A)  // Hijau gelap
  ```

### 5. **Product Grid Cards**

- Menggunakan `ProductCard` widget - lihat bagian Widget Card

---

## 🛒 CART PAGE (`lib/screens/cart/cart_page.dart`)

### 1. **AppBar Gradient**

- **Lokasi**: Line ~99-111
- **Warna**:
  ```dart
  Colors.green.shade400,  // Hijau terang
  Colors.green.shade300,  // Hijau sedang
  Colors.green.shade200,  // Hijau muda
  ```

### 2. **Category Filter Container**

- **Lokasi**: Line ~189-193
- **Background**:
  ```dart
  Colors.white  // Putih
  ```
- **Shadow**:
  ```dart
  Colors.black.withOpacity(0.05)  // Hitam transparan halus
  ```

### 3. **Swipe to Delete Background**

- **Lokasi**: Line ~499
- **Warna**:
  ```dart
  Colors.red  // Merah
  ```
- **Icon & Text**:
  ```dart
  Colors.white  // Putih
  ```

### 4. **Ticket Order Card**

- **Lokasi**: Line ~528 (dalam method `_buildTicketOrderCard`)
- **Card Elevation**: 3
- **Border Radius**: 16
- **Warna Container Info**:
  ```dart
  Colors.purple.shade50    // Background info leader (ungu pucat)
  Colors.purple.shade700   // Icon leader (ungu gelap)
  Colors.orange.shade700   // Icon pendaki (orange gelap)
  Colors.orange.shade100   // Background currency badge (orange pucat)
  Colors.orange.shade900   // Text currency (orange sangat gelap)
  Color(0xFF2A4D3A)        // Total price text (hijau gelap)
  ```

### 5. **Empty Cart**

- **Lokasi**: Line ~300
- **Teks**:
  ```dart
  Color(0xFF2A4D3A)  // Hijau gelap untuk judul
  Colors.black       // Hitam untuk deskripsi
  ```
- **Button**:
  ```dart
  backgroundColor: Color(0xFF2A4D3A)  // Hijau gelap
  foregroundColor: Colors.white        // Putih
  ```

---

## ❤️ WISHLIST PAGE (`lib/screens/wishlist/wishlist_page.dart`)

### 1. **AppBar Gradient**

- **Warna**: Sama dengan Home & Cart
  ```dart
  Colors.green.shade400,
  Colors.green.shade300,
  Colors.green.shade200,
  ```

### 2. **Category Filter Tabs**

- **Selected Tab**:
  ```dart
  Gradient: categoryData['color']  // Orange/Green tergantung kategori
  Text: Colors.white
  ```
- **Unselected Tab**:
  ```dart
  Gradient: Colors.grey.shade100, Colors.grey.shade200
  Text: Colors.black87
  ```

### 3. **Travel/Ojek Card (Wishlist)**

- **Lokasi**: Method `_buildTravelOjekWishlistCard`
- **Card Shadow**:
  ```dart
  elevation: 3
  ```
- **Image Gradient Overlay**:
  ```dart
  Colors.transparent (atas)
  Colors.black.withOpacity(0.7) (bawah)
  ```
- **Info Row Icons**:
  ```dart
  Colors.green.shade700  // Hijau gelap untuk semua icon
  ```
- **Total Price**:
  ```dart
  Color(0xFF2A4D3A)  // Hijau gelap
  ```
- **Button "Buat Pesanan"**:
  ```dart
  backgroundColor: Color(0xFF2A4D3A)  // Hijau gelap
  foregroundColor: Colors.white       // Putih
  ```

### 4. **Porter/Guide Card (Wishlist)**

- **Lokasi**: Method `_buildPorterGuideWishlistCard`
- **Category Badge**:
  ```dart
  backgroundColor: Color(0xFF2A4D3A)  // Hijau gelap
  textColor: Colors.white             // Putih
  ```
- **Favorite Icon**:
  ```dart
  backgroundColor: Colors.pink.shade400  // Pink
  iconColor: Colors.white                 // Putih
  ```
- **Price Container**:
  ```dart
  backgroundColor: Color(0xFF2A4D3A).withOpacity(0.08)  // Hijau gelap transparan
  textColor: Color(0xFF2A4D3A)                          // Hijau gelap
  ```
- **Button**:
  ```dart
  backgroundColor: Color(0xFF2A4D3A)  // Hijau gelap
  foregroundColor: Colors.white       // Putih
  ```

### 5. **Ticket Order Card (Wishlist)**

- Sama dengan Cart - lihat bagian Cart Ticket Order Card

### 6. **Empty Wishlist**

- **Teks Judul**: `Color(0xFF2A4D3A)` (hijau gelap)
- **Button**: `backgroundColor: Color(0xFF2A4D3A)`

### 7. **Swipe to Delete**

- **Background**: `Colors.orange.shade600` (untuk wishlist, berbeda dengan cart yang merah)

---

## 👤 PROFILE PAGE (`lib/screens/profile/profile_page.dart`)

### 1. **AppBar Gradient**

- **Warna**: Sama dengan halaman lain
  ```dart
  Colors.green.shade400,
  Colors.green.shade300,
  Colors.green.shade200,
  ```

### 2. **Profile Header Card**

- **Background Gradient**:
  ```dart
  Colors.green.shade600,  // Hijau gelap (atas)
  Colors.green.shade400,  // Hijau sedang (bawah)
  ```
- **Avatar Border**:
  ```dart
  Colors.white  // Putih
  ```
- **Teks Nama**:
  ```dart
  Colors.white  // Putih
  ```
- **Teks Email**:
  ```dart
  Colors.white70  // Putih transparan
  ```

### 3. **Menu Items**

- **Background**: `Colors.white`
- **Border**: `Colors.grey.shade200`
- **Icon Tint**: Berbeda-beda per menu (orange, blue, purple, green, red)
- **Text**: `Colors.black87`

### 4. **Logout Button**

- **Background**:
  ```dart
  Colors.red.shade50  // Merah pucat
  ```
- **Text & Icon**:
  ```dart
  Colors.red.shade700  // Merah gelap
  ```

---

## 💳 MEMBERSHIP PAGE (`lib/screens/membership/membership_page.dart`)

### 1. **AppBar Gradient**

- **Warna**: Sama dengan halaman lain
  ```dart
  Colors.green.shade400,
  Colors.green.shade300,
  Colors.green.shade200,
  ```

### 2. **Membership Card (Silver)**

- **Gradient**:
  ```dart
  Colors.grey.shade300,  // Abu-abu terang (kiri)
  Colors.grey.shade100,  // Abu-abu pucat (kanan)
  ```
- **Icon**: `Colors.grey.shade600`

### 3. **Membership Card (Gold)**

- **Gradient**:
  ```dart
  Colors.amber.shade400,  // Emas terang (kiri)
  Colors.amber.shade200,  // Emas pucat (kanan)
  ```
- **Icon**: `Colors.amber.shade700`

### 4. **Membership Card (Platinum)**

- **Gradient**:
  ```dart
  Colors.blue.shade400,  // Biru terang (kiri)
  Colors.blue.shade200,  // Biru pucat (kanan)
  ```
- **Icon**: `Colors.blue.shade700`

### 5. **Feature List Items**

- **Check Icon**: `Colors.green` (hijau)
- **Text**: `Colors.black87`

### 6. **Benefits Container**

- **Background**: `Colors.green.shade50` (hijau sangat pucat)
- **Border**: `Colors.green.shade200` (hijau muda)

### 7. **CTA Button**

- **Background**: `Color(0xFF2A4D3A)` (hijau gelap)
- **Text**: `Colors.white` (putih)

---

## 🎨 WIDGET CARDS (Reusable)

### Product Card (`lib/widgets/product_card.dart`)

- **Card Elevation**: 2
- **Border Radius**: 12
- **Brand Badge**: `Colors.orange.shade600`
- **Price Text**: `Color(0xFF2A4D3A)`
- **Star Icon**: `Colors.amber`
- **Favorite Icon Active**: `Colors.pink`

### Mountain Card (jika ada)

- **Image Overlay**: Gradient dari transparent ke `Colors.black.withOpacity(0.7)`
- **Badge**: `Colors.white.withOpacity(0.9)`
- **Icon**: `Color(0xFF2A4D3A)`

---

## 🔧 CARA MENGUBAH WARNA

1. **Buka file yang ingin diubah** (lihat path di atas)
2. **Cari line number** yang tercantum
3. **Ganti nilai warna**:

   - Material Colors: `Colors.green.shade400` → `Colors.blue.shade400`
   - Hex Colors: `Color(0xFF2A4D3A)` → `Color(0xFF1E3A8A)`
   - Opacity: `withOpacity(0.1)` → `withOpacity(0.2)`

4. **Hot Reload** aplikasi untuk melihat perubahan

---

## 📝 CATATAN PENTING

- **Konsistensi**: Gunakan warna yang sama untuk elemen sejenis di semua halaman
- **Kontras**: Pastikan teks tetap readable setelah mengubah background
- **Tema**: Warna utama aplikasi adalah hijau gelap (`Color(0xFF2A4D3A)`)
- **Accessibility**: Hindari kombinasi warna yang sulit dibaca

---

**Terakhir diupdate**: 1 Desember 2025
