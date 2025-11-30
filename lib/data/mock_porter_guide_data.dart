import 'package:tapak_jejak/models/porter_guide.dart';

class MockPorterGuideData {
  static List<PorterGuide> getAllPorterGuides() {
    return [
      PorterGuide(
        id: 1,
        name: 'Bambang Suprapto',
        photoUrl: 'https://i.pravatar.cc/150?img=12',
        experienceYears: 8,
        rating: 4.9,
        totalReviews: 156,
        languages: ['Indonesia', 'English', 'Jawa'],
        certifications: [
          'Sertifikat Guide Profesional',
          'First Aid & CPR',
          'Mountain Rescue Basic',
        ],
        specialMountains: ['Merapi', 'Merbabu', 'Sindoro', 'Sumbing'],
        specialty: 'Both',
        description:
            'Guide dan porter berpengalaman dengan spesialisasi gunung-gunung di Jawa Tengah. Telah memandu lebih dari 500 pendakian dengan tingkat keselamatan 100%.',
        packages: [
          Package(
            name: 'Paket Hemat Porter',
            description: 'Porter untuk membawa barang maksimal 20kg',
            price: 150000,
            includes: [
              'Porter bawa barang 20kg',
              'Asuransi barang',
              'GPS tracking',
            ],
            duration: 'Per hari',
          ),
          Package(
            name: 'Paket Guide Premium',
            description: 'Guide profesional dengan pengetahuan mendalam',
            price: 300000,
            includes: [
              'Guide berpengalaman',
              'Briefing safety',
              'Info flora & fauna',
              'GPS tracking',
              'Emergency kit',
            ],
            duration: 'Per hari',
          ),
          Package(
            name: 'Paket All-Inclusive Expedition',
            description: 'Paket lengkap untuk pengalaman mendaki terbaik',
            price: 850000,
            includes: [
              'Guide + Porter profesional',
              'Tenda camping (kapasitas 2-3 orang)',
              'Sleeping bag & matras',
              'Carrier 60L',
              'Kompor & peralatan masak',
              'Makan 3x sehari',
              'Permit & administrasi',
              'Dokumentasi foto & video',
              'GPS tracking real-time',
              'Emergency kit & P3K',
              'Asuransi perjalanan',
            ],
            duration: '2D1N',
            photoVideoService: true,
          ),
        ],
        reviews: [
          Review(
            reviewerName: 'Andi Setiawan',
            reviewerPhoto: 'https://i.pravatar.cc/150?img=33',
            rating: 5.0,
            comment:
                'Mas Bambang sangat profesional! Ramah, sabar, dan pengetahuannya luas. Dokumentasinya juga keren banget!',
            date: '15 November 2025',
            mountainClimbed: 'Gunung Merapi',
            photos: [],
          ),
          Review(
            reviewerName: 'Siti Nurhaliza',
            reviewerPhoto: 'https://i.pravatar.cc/150?img=45',
            rating: 4.9,
            comment:
                'Paket all-inclusive nya worth it! Tinggal bawa badan aja. Guide nya jago foto, hasil fotonya bagus-bagus!',
            date: '3 November 2025',
            mountainClimbed: 'Gunung Merbabu',
          ),
          Review(
            reviewerName: 'Rudi Hartono',
            reviewerPhoto: 'https://i.pravatar.cc/150?img=51',
            rating: 4.8,
            comment:
                'Pengalaman pertama mendaki jadi menyenangkan berkat Mas Bambang. Recommended!',
            date: '28 Oktober 2025',
            mountainClimbed: 'Gunung Sindoro',
          ),
        ],
        achievements: [
          Achievement(
            title: 'Top Rated Guide 2025',
            icon: '🏆',
            description: 'Rating tertinggi di kategori guide',
          ),
          Achievement(
            title: '500+ Expeditions',
            icon: '⛰️',
            description: 'Telah memandu 500+ pendakian',
          ),
          Achievement(
            title: 'Safety Champion',
            icon: '🛡️',
            description: '100% safety record',
          ),
        ],
      ),
      PorterGuide(
        id: 2,
        name: 'Hendra Wijaya',
        photoUrl: 'https://i.pravatar.cc/150?img=13',
        experienceYears: 6,
        rating: 4.8,
        totalReviews: 98,
        languages: ['Indonesia', 'English', 'Sunda'],
        certifications: [
          'Sertifikat Guide Profesional',
          'Wilderness First Responder',
        ],
        specialMountains: ['Semeru', 'Rinjani', 'Lawu'],
        specialty: 'Guide',
        description:
            'Spesialis gunung-gunung tinggi dengan pengalaman mendaki ke puncak tertinggi di Indonesia. Fokus pada keselamatan dan edukasi lingkungan.',
        packages: [
          Package(
            name: 'Paket Guide Profesional',
            description: 'Guide berpengalaman untuk gunung tinggi',
            price: 350000,
            includes: [
              'Guide bersertifikat',
              'Briefing teknis',
              'Emergency support',
              'GPS tracking',
            ],
            duration: 'Per hari',
          ),
          Package(
            name: 'Paket Expedition Semeru/Rinjani',
            description: 'Paket lengkap untuk pendakian gunung tinggi',
            price: 1200000,
            includes: [
              'Guide profesional',
              'Porter untuk logistik',
              'Tenda & sleeping bag',
              'Makan selama pendakian',
              'Permit & biaya masuk',
              'Dokumentasi',
              'Asuransi',
            ],
            duration: '3D2N',
            photoVideoService: true,
          ),
        ],
        reviews: [
          Review(
            reviewerName: 'Dimas Prasetyo',
            reviewerPhoto: 'https://i.pravatar.cc/150?img=60',
            rating: 5.0,
            comment:
                'Mendaki Semeru bareng Mas Hendra luar biasa! Penjelasannya detail, safety first banget.',
            date: '20 November 2025',
            mountainClimbed: 'Gunung Semeru',
          ),
          Review(
            reviewerName: 'Lisa Anggraini',
            reviewerPhoto: 'https://i.pravatar.cc/150?img=47',
            rating: 4.7,
            comment: 'Profesional dan helpful. Recommended untuk pemula!',
            date: '10 November 2025',
            mountainClimbed: 'Gunung Lawu',
          ),
        ],
        achievements: [
          Achievement(
            title: 'High Altitude Expert',
            icon: '🏔️',
            description: 'Spesialis gunung 3000+ mdpl',
          ),
          Achievement(
            title: 'Eco Champion',
            icon: '🌱',
            description: 'Peduli lingkungan gunung',
          ),
        ],
      ),
      PorterGuide(
        id: 3,
        name: 'Yusuf Rahman',
        photoUrl: 'https://i.pravatar.cc/150?img=14',
        experienceYears: 10,
        rating: 4.95,
        totalReviews: 210,
        languages: ['Indonesia', 'English', 'Mandarin', 'Jawa'],
        certifications: [
          'International Mountain Guide',
          'Advanced First Aid',
          'Photography Professional',
        ],
        specialMountains: ['Rinjani', 'Semeru', 'Kerinci', 'Raung'],
        specialty: 'Both',
        description:
            'Guide internasional dengan kemampuan multilingual. Spesialis dokumentasi dan photography service untuk pendakian Anda.',
        packages: [
          Package(
            name: 'Paket Guide Multilingual',
            description: 'Guide dengan kemampuan bahasa Inggris & Mandarin',
            price: 400000,
            includes: [
              'Multilingual guide',
              'Cultural insights',
              'Safety briefing',
              'GPS tracking',
            ],
            duration: 'Per hari',
          ),
          Package(
            name: 'Paket Premium Photography Expedition',
            description: 'Pendakian dengan dokumentasi profesional',
            price: 1500000,
            includes: [
              'Guide profesional',
              'Porter tim support',
              'Photography service',
              'Drone footage',
              'Edited photos & videos',
              'Tenda & equipment',
              'Makan premium',
              'Permit all-in',
              'Asuransi premium',
            ],
            duration: '3D2N',
            photoVideoService: true,
          ),
        ],
        reviews: [
          Review(
            reviewerName: 'Michael Chen',
            reviewerPhoto: 'https://i.pravatar.cc/150?img=68',
            rating: 5.0,
            comment:
                'Amazing guide! He speaks perfect English and Mandarin. The photo service is outstanding!',
            date: '25 November 2025',
            mountainClimbed: 'Gunung Rinjani',
          ),
          Review(
            reviewerName: 'Putri Maharani',
            reviewerPhoto: 'https://i.pravatar.cc/150?img=44',
            rating: 5.0,
            comment:
                'Hasil foto dan video nya profesional banget! Seperti punya videographer pribadi.',
            date: '12 November 2025',
            mountainClimbed: 'Gunung Semeru',
          ),
        ],
        achievements: [
          Achievement(
            title: 'International Guide',
            icon: '🌍',
            description: 'Tersertifikasi internasional',
          ),
          Achievement(
            title: 'Master Photographer',
            icon: '📸',
            description: 'Dokumentasi profesional',
          ),
          Achievement(
            title: '1000+ Expeditions',
            icon: '🎖️',
            description: 'Veteran dengan 1000+ pendakian',
          ),
        ],
      ),
      PorterGuide(
        id: 4,
        name: 'Agus Hermawan',
        photoUrl: 'https://i.pravatar.cc/150?img=15',
        experienceYears: 5,
        rating: 4.7,
        totalReviews: 75,
        languages: ['Indonesia', 'Jawa'],
        certifications: ['Sertifikat Porter Profesional', 'Basic First Aid'],
        specialMountains: ['Merbabu', 'Merapi', 'Lawu', 'Slamet'],
        specialty: 'Porter',
        description:
            'Porter profesional dengan stamina kuat. Spesialis membawa barang berat untuk pendakian jarak jauh.',
        packages: [
          Package(
            name: 'Paket Porter Standar',
            description: 'Porter untuk barang maksimal 20kg',
            price: 120000,
            includes: ['Porter bawa barang 20kg', 'Asuransi barang'],
            duration: 'Per hari',
          ),
          Package(
            name: 'Paket Porter + Equipment',
            description: 'Porter + sewa perlengkapan camping',
            price: 350000,
            includes: [
              'Porter profesional',
              'Tenda 2-3 orang',
              'Sleeping bag',
              'Carrier 60L',
              'Kompor + tabung gas',
              'Asuransi',
            ],
            duration: '2D1N',
          ),
        ],
        reviews: [
          Review(
            reviewerName: 'Budi Santoso',
            reviewerPhoto: 'https://i.pravatar.cc/150?img=56',
            rating: 4.8,
            comment:
                'Kuat banget orangnya, barang berat diangkat dengan mudah. Recommended!',
            date: '8 November 2025',
            mountainClimbed: 'Gunung Merbabu',
          ),
        ],
        achievements: [
          Achievement(
            title: 'Strong Porter',
            icon: '💪',
            description: 'Spesialis barang berat',
          ),
        ],
      ),
      PorterGuide(
        id: 5,
        name: 'Dedi Kurniawan',
        photoUrl: 'https://i.pravatar.cc/150?img=52',
        experienceYears: 7,
        rating: 4.85,
        totalReviews: 130,
        languages: ['Indonesia', 'English'],
        certifications: [
          'Sertifikat Guide Profesional',
          'Wilderness First Aid',
          'Navigation Expert',
        ],
        specialMountains: ['Slamet', 'Sindoro', 'Sumbing', 'Prau'],
        specialty: 'Both',
        description:
            'Guide dan porter handal dengan keahlian navigasi. Cocok untuk jalur-jalur yang menantang.',
        packages: [
          Package(
            name: 'Paket Guide Navigasi',
            description: 'Guide dengan keahlian navigasi untuk jalur sulit',
            price: 280000,
            includes: [
              'Guide berpengalaman',
              'Navigation equipment',
              'Safety briefing',
              'GPS tracking',
            ],
            duration: 'Per hari',
          ),
          Package(
            name: 'Paket Complete Expedition',
            description: 'Paket lengkap untuk pendakian nyaman',
            price: 900000,
            includes: [
              'Guide + Porter',
              'Tenda & sleeping bag',
              'Makan 3x',
              'Equipment lengkap',
              'Permit',
              'Dokumentasi',
              'Asuransi',
            ],
            duration: '2D1N',
            photoVideoService: true,
          ),
        ],
        reviews: [
          Review(
            reviewerName: 'Rina Susanti',
            reviewerPhoto: 'https://i.pravatar.cc/150?img=48',
            rating: 4.9,
            comment:
                'Mas Dedi jago navigasi, meski kabut tebal tetap lancar perjalanannya.',
            date: '18 November 2025',
            mountainClimbed: 'Gunung Slamet',
          ),
        ],
        achievements: [
          Achievement(
            title: 'Navigation Master',
            icon: '🧭',
            description: 'Ahli navigasi medan sulit',
          ),
          Achievement(
            title: 'All Weather Guide',
            icon: '⛈️',
            description: 'Berpengalaman di segala cuaca',
          ),
        ],
      ),
      PorterGuide(
        id: 6,
        name: 'Fajar Ramadhan',
        photoUrl: 'https://i.pravatar.cc/150?img=57',
        experienceYears: 4,
        rating: 4.6,
        totalReviews: 52,
        languages: ['Indonesia', 'Sunda'],
        certifications: ['Sertifikat Guide', 'First Aid Basic'],
        specialMountains: ['Ciremai', 'Gede', 'Pangrango', 'Papandayan'],
        specialty: 'Guide',
        description:
            'Guide muda dan energik, spesialis gunung-gunung di Jawa Barat. Ramah untuk pendaki pemula.',
        packages: [
          Package(
            name: 'Paket Guide Pemula',
            description: 'Guide ramah untuk pendaki pemula',
            price: 200000,
            includes: ['Guide friendly', 'Basic training', 'Safety support'],
            duration: 'Per hari',
          ),
          Package(
            name: 'Paket Beginner Friendly Expedition',
            description: 'Paket khusus untuk pendaki pemula',
            price: 750000,
            includes: [
              'Guide sabar & ramah',
              'Porter support',
              'Equipment lengkap',
              'Training dasar',
              'Makan 3x',
              'Permit',
              'Dokumentasi',
            ],
            duration: '2D1N',
            photoVideoService: true,
          ),
        ],
        reviews: [
          Review(
            reviewerName: 'Novi Amelia',
            reviewerPhoto: 'https://i.pravatar.cc/150?img=43',
            rating: 4.7,
            comment:
                'Pertama kali mendaki, Mas Fajar sabar banget ngajarin. Senang bisa sampai puncak!',
            date: '5 November 2025',
            mountainClimbed: 'Gunung Papandayan',
          ),
        ],
        achievements: [
          Achievement(
            title: 'Beginner Friendly',
            icon: '👍',
            description: 'Spesialis pendaki pemula',
          ),
        ],
      ),
    ];
  }

  static List<PorterGuide> getPorterGuidesByMountain(String mountainName) {
    final allGuides = getAllPorterGuides();
    return allGuides
        .where(
          (guide) => guide.specialMountains.any(
            (mountain) =>
                mountainName.toLowerCase().contains(mountain.toLowerCase()),
          ),
        )
        .toList();
  }

  static PorterGuide? getPorterGuideById(int id) {
    final allGuides = getAllPorterGuides();
    try {
      return allGuides.firstWhere((guide) => guide.id == id);
    } catch (e) {
      return null;
    }
  }
}
