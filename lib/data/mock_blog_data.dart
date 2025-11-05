import 'package:tapak_jejak/models/blog.dart';

List<BlogPost> mockBlogPosts = [
  BlogPost(
    id: 1,
    title: 'Tips Pendakian Aman di Gunung Merapi',
    category: 'Tips Pendakian',
    imageUrl: 'assets/tiket_masuk/merapi.jpg',
    date: '15 Oktober 2023',
    description:
        'Panduan lengkap persiapan pendakian, peralatan wajib, dan cara menghadapi risiko cuaca di Gunung Merapi.',
    content:
        'Gunung Merapi adalah salah satu gunung berapi aktif di Indonesia yang menarik banyak pendaki. Untuk pendakian yang aman, pastikan Anda mempersiapkan peralatan lengkap seperti jaket anti-air, tenda, dan kompas. Selalu periksa cuaca sebelum berangkat dan ikuti jalur resmi. Risiko utama adalah cuaca buruk dan aktivitas vulkanik, jadi gunakan aplikasi monitoring cuaca kami untuk update real-time.',
    linkToService: 'cuaca',
  ),
  BlogPost(
    id: 2,
    title: 'Cerita Pendakian: Dari Jakarta ke Puncak Rinjani',
    category: 'Cerita Pengalaman',
    imageUrl: 'assets/tiket_masuk/rinjani.jpg',
    date: '10 Oktober 2023',
    description:
        'Kisah inspiratif perjalanan 4 hari mendaki Gunung Rinjani, dari persiapan hingga momen di puncak.',
    content:
        'Perjalanan dimulai dari Jakarta dengan persiapan fisik selama 3 bulan. Kami menggunakan layanan porter untuk membawa beban, dan sewa alat dari aplikasi ini membuat segalanya lebih mudah. Puncak Rinjani menawarkan pemandangan Danau Segara Anak yang luar biasa. Tips: Jangan lupa bawa obat nyamuk dan persiapkan mental untuk cuaca dingin.',
    linkToService: 'porter_guide',
  ),
  BlogPost(
    id: 3,
    title: 'Berita: Status Gunung Semeru Pasca Erupsi',
    category: 'Berita Gunung',
    imageUrl: 'assets/tiket_masuk/semeru.jpg',
    date: '5 Oktober 2023',
    description:
        'Update terkini kondisi Gunung Semeru setelah erupsi terakhir, termasuk zona aman dan rekomendasi pendakian.',
    content:
        'Erupsi Gunung Semeru pada Desember 2021 telah mengubah lanskap gunung ini. Saat ini, jalur pendakian utara masih ditutup untuk keselamatan. Gunakan layanan monitoring keamanan kami untuk info real-time. Pendaki disarankan menghindari area rawan longsor dan selalu membawa alat komunikasi.',
    linkToService: 'keamanan',
  ),
  BlogPost(
    id: 4,
    title: 'Eksplorasi Alam: Flora dan Fauna di Gunung Bromo',
    category: 'Eksplorasi Alam',
    imageUrl: 'assets/gunung.jpeg',
    date: '1 Oktober 2023',
    description:
        'Jelajahi keanekaragaman hayati Gunung Bromo, dari padang rumput hingga kawah aktif.',
    content:
        'Gunung Bromo terkenal dengan padang rumput savana dan kawah aktifnya. Flora yang dominan adalah rumput alang-alang, sedangkan fauna meliputi burung langka dan hewan kecil. Saat mendaki, jaga kelestarian alam dengan tidak membuang sampah. Gunakan layanan tiket masuk untuk akses resmi.',
    linkToService: 'tiket_masuk',
  ),
  BlogPost(
    id: 5,
    title: 'Review Alat Pendakian Terbaik untuk Musim Hujan',
    category: 'Review Produk',
    imageUrl: 'assets/eiger/tenda2.jpg',
    date: '25 September 2023',
    description:
        'Ulasan tenda dan jaket anti-air dari brand terpercaya, cocok untuk kondisi hujan di gunung.',
    content:
        'Musim hujan membutuhkan peralatan tahan air. Tenda dari Eiger dengan bahan waterproof sangat direkomendasikan. Jaket anti-air dari Antarestar juga bagus untuk melindungi dari angin dan hujan. Sewa alat di aplikasi ini untuk uji coba sebelum beli.',
    linkToService: 'sewa_alat',
  ),
];
