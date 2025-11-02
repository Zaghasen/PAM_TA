import 'package:flutter/material.dart';
import 'package:tapak_jejak/screens/icons/travel_ojek/travel&ojek_detail_page.dart';
import 'package:tapak_jejak/models/mountain.dart';

class TravelOjekPage extends StatefulWidget {
  const TravelOjekPage({super.key});

  @override
  State<TravelOjekPage> createState() => _TravelOjekPageState();
}

class _TravelOjekPageState extends State<TravelOjekPage> {
  String? selectedProvince;

  static String _formatCurrency(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  List<Mountain> _getFilteredMountains() {
    final List<Mountain> allMountains = [
      Mountain(
        image: 'assets/tiket_masuk/merapi.jpg',
        name: 'Gunung Merapi',
        managedBy: 'Balai Taman Nasional Gunung Merapi',
        description:
            'Gunung berapi aktif dengan pemandangan spektakuler dan jalur pendakian menantang.',
        location: 'Yogyakarta, Jawa Tengah',
        height: 2914,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/merbabu.jpg',
        name: 'Gunung Merbabu',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan panorama sunrise yang memukau dan jalur pendakian yang terjangkau.',
        location: 'Magelang, Jawa Tengah',
        height: 3145,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/lawu.jpg',
        name: 'Gunung Lawu',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung mistis dengan legenda dan pemandangan hamparan sawah yang indah.',
        location: 'Karanganyar, Jawa Timur',
        height: 3265,
        prices: {
          'Hari Kerja WNI': 12000,
          'Hari Kerja WNA': 120000,
          'Hari Libur WNI': 18000,
          'Hari Libur WNA': 180000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/semeru.jpg',
        name: 'Gunung Semeru',
        managedBy: 'Taman Nasional Bromo Tengger Semeru',
        description:
            'Gunung tertinggi di Jawa dengan puncak Mahameru dan panorama luar biasa.',
        location: 'Lumajang, Jawa Timur',
        height: 3676,
        prices: {
          'Hari Kerja WNI': 30000,
          'Hari Kerja WNA': 200000,
          'Hari Libur WNI': 35000,
          'Hari Libur WNA': 250000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/rinjani.jpg',
        name: 'Gunung Rinjani',
        managedBy: 'Taman Nasional Gunung Rinjani',
        description:
            'Gunung dengan danau Segara Anak yang mempesona dan pendakian epik.',
        location: 'Lombok, Nusa Tenggara Barat',
        height: 3726,
        prices: {
          'Hari Kerja WNI': 25000,
          'Hari Kerja WNA': 250000,
          'Hari Libur WNI': 30000,
          'Hari Libur WNA': 300000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/slamet.jpg',
        name: 'Gunung Slamet',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan vegetasi yang masih asri dan jalur pendakian yang menantang.',
        location: 'Banyumas, Jawa Tengah',
        height: 3428,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/sindoro.jpg',
        name: 'Gunung Sindoro',
        managedBy: 'Perhutani',
        description:
            'Gunung kembar dengan Sumbing, menawarkan pendakian yang menyenangkan.',
        location: 'Temanggung, Jawa Tengah',
        height: 3135,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/sumbing.jpg',
        name: 'Gunung Sumbing',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan puncak yang landai dan pemandangan yang luas.',
        location: 'Temanggung, Jawa Tengah',
        height: 3371,
        prices: {
          'Hari Kerja WNI': 12000,
          'Hari Kerja WNA': 120000,
          'Hari Libur WNI': 18000,
          'Hari Libur WNA': 180000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/prau.jpg',
        name: 'Gunung Prau',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung dengan hamparan edelweis dan sunrise yang memukau.',
        location: 'Wonogiri, Jawa Tengah',
        height: 2565,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/raung.jpg',
        name: 'Gunung Raung',
        managedBy: 'Balai Taman Nasional Alas Purwo',
        description:
            'Gunung dengan kawah aktif dan hutan tropis yang masih alami.',
        location: 'Banyuwangi, Jawa Timur',
        height: 3332,
        prices: {
          'Hari Kerja WNI': 20000,
          'Hari Kerja WNA': 180000,
          'Hari Libur WNI': 25000,
          'Hari Libur WNA': 220000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/andong.jpg',
        name: 'Gunung Andong',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan pemandangan sawah terasering dan udara sejuk.',
        location: 'Boyolali, Jawa Tengah',
        height: 1726,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/buthak.jpg',
        name: 'Gunung Buthak',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung dengan jalur pendakian yang mudah dan panorama yang indah.',
        location: 'Pati, Jawa Tengah',
        height: 1101,
        prices: {
          'Hari Kerja WNI': 8000,
          'Hari Kerja WNA': 80000,
          'Hari Libur WNI': 12000,
          'Hari Libur WNA': 120000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/kembang.jpg',
        name: 'Gunung Kembang',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan vegetasi yang hijau dan jalur pendakian yang menyenangkan.',
        location: 'Pati, Jawa Tengah',
        height: 1275,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/pakuwaja.jpg',
        name: 'Gunung Pakuwaja',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description: 'Gunung dengan pemandangan laut dari puncaknya yang unik.',
        location: 'Pati, Jawa Tengah',
        height: 551,
        prices: {
          'Hari Kerja WNI': 5000,
          'Hari Kerja WNA': 50000,
          'Hari Libur WNI': 8000,
          'Hari Libur WNA': 80000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/telomoyo.jpg',
        name: 'Gunung Telomoyo',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan jalur pendakian yang landai dan cocok untuk pemula.',
        location: 'Magelang, Jawa Tengah',
        height: 1894,
        prices: {
          'Hari Kerja WNI': 12000,
          'Hari Kerja WNA': 120000,
          'Hari Libur WNI': 18000,
          'Hari Libur WNA': 180000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/ungaran.jpg',
        name: 'Gunung Ungaran',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan hutan pinus yang rindang dan udara yang sejuk.',
        location: 'Semarang, Jawa Tengah',
        height: 2050,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/bismo.jpg',
        name: 'Gunung Bismo',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description: 'Gunung dengan legenda dan pemandangan yang mistis.',
        location: 'Boyolali, Jawa Tengah',
        height: 2525,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/agung.jpg',
        name: 'Gunung Agung',
        managedBy: 'Taman Nasional Bali Barat',
        description:
            'Gunung berapi aktif di Bali dengan pemandangan spiritual dan budaya yang kaya.',
        location: 'Karangasem, Bali',
        height: 3142,
        prices: {
          'Hari Kerja WNI': 20000,
          'Hari Kerja WNA': 200000,
          'Hari Libur WNI': 25000,
          'Hari Libur WNA': 250000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/argopuro.jpg',
        name: 'Gunung Argopuro',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung dengan hutan hujan tropis dan jalur pendakian yang menantang.',
        location: 'Probolinggo, Jawa Timur',
        height: 3088,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/arjuno.jpg',
        name: 'Gunung Arjuno',
        managedBy: 'Perhutani',
        description: 'Gunung dengan pemandangan danau dan vegetasi yang subur.',
        location: 'Malang, Jawa Timur',
        height: 3339,
        prices: {
          'Hari Kerja WNI': 12000,
          'Hari Kerja WNA': 120000,
          'Hari Libur WNI': 18000,
          'Hari Libur WNA': 180000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/bawakaraeng.jpg',
        name: 'Gunung Bawakaraeng',
        managedBy: 'Taman Nasional Bantimurung Bulusaraung',
        description:
            'Gunung dengan pemandangan laut dan hutan yang masih alami.',
        location: 'Gowa, Sulawesi Selatan',
        height: 2831,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/binaiya.jpg',
        name: 'Gunung Binaiya',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung dengan jalur pendakian yang mudah dan panorama yang indah.',
        location: 'Minahasa Utara, Sulawesi Utara',
        height: 3011,
        prices: {
          'Hari Kerja WNI': 8000,
          'Hari Kerja WNA': 80000,
          'Hari Libur WNI': 12000,
          'Hari Libur WNA': 120000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/bukit_raya.jpg',
        name: 'Bukit Raya',
        managedBy: 'Taman Nasional Bukit Baka Bukit Raya',
        description:
            'Gunung dengan hutan hujan tropis dan biodiversitas tinggi.',
        location: 'Sintang, Kalimantan Barat',
        height: 2278,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/cikuray.jpg',
        name: 'Gunung Cikuray',
        managedBy: 'Taman Nasional Gunung Halimun Salak',
        description: 'Gunung dengan pemandangan danau dan vegetasi yang hijau.',
        location: 'Sukabumi, Jawa Barat',
        height: 2821,
        prices: {
          'Hari Kerja WNI': 12000,
          'Hari Kerja WNA': 120000,
          'Hari Libur WNI': 18000,
          'Hari Libur WNA': 180000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/ciremai.jpg',
        name: 'Gunung Ciremai',
        managedBy: 'Perhutani',
        description:
            'Gunung dengan jalur pendakian yang populer dan pemandangan yang luas.',
        location: 'Kuningan, Jawa Barat',
        height: 3078,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/dempo.jpg',
        name: 'Gunung Dempo',
        managedBy: 'Taman Nasional Bukit Barisan Selatan',
        description:
            'Gunung dengan kawah aktif dan pemandangan yang spektakuler.',
        location: 'Lubuk Linggau, Sumatera Selatan',
        height: 3173,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/gamalama.jpg',
        name: 'Gunung Gamalama',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description: 'Gunung berapi aktif dengan pemandangan laut yang indah.',
        location: 'Ternate, Maluku Utara',
        height: 1715,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/gandang_dewata.jpg',
        name: 'Gunung Gandang Dewata',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description: 'Gunung dengan legenda dan pemandangan yang mistis.',
        location: 'Lombok Timur, Nusa Tenggara Barat',
        height: 2064,
        prices: {
          'Hari Kerja WNI': 8000,
          'Hari Kerja WNA': 80000,
          'Hari Libur WNI': 12000,
          'Hari Libur WNA': 120000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/gede.jpg',
        name: 'Gunung Gede',
        managedBy: 'Taman Nasional Gunung Gede Pangrango',
        description:
            'Gunung dengan hutan hujan tropis dan jalur pendakian yang menantang.',
        location: 'Cianjur, Jawa Barat',
        height: 2958,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/halau_halau.jpg',
        name: 'Gunung Halau-Halau',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description: 'Gunung dengan pemandangan laut dan vegetasi yang unik.',
        location: 'Sangihe, Sulawesi Utara',
        height: 1227,
        prices: {
          'Hari Kerja WNI': 5000,
          'Hari Kerja WNA': 50000,
          'Hari Libur WNI': 8000,
          'Hari Libur WNA': 80000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/halimun.jpg',
        name: 'Gunung Halimun',
        managedBy: 'Taman Nasional Gunung Halimun Salak',
        description:
            'Gunung dengan hutan yang masih alami dan biodiversitas tinggi.',
        location: 'Bogor, Jawa Barat',
        height: 1929,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/inerie.jpg',
        name: 'Gunung Inerie',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung dengan pemandangan laut dan jalur pendakian yang unik.',
        location: 'Biak Numfor, Papua',
        height: 2267,
        prices: {
          'Hari Kerja WNI': 12000,
          'Hari Kerja WNA': 120000,
          'Hari Libur WNI': 18000,
          'Hari Libur WNA': 180000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/kerinci.jpg',
        name: 'Gunung Kerinci',
        managedBy: 'Taman Nasional Kerinci Seblat',
        description:
            'Gunung tertinggi di Sumatera dengan pemandangan yang luar biasa.',
        location: 'Kerinci, Jambi',
        height: 3805,
        prices: {
          'Hari Kerja WNI': 20000,
          'Hari Kerja WNA': 200000,
          'Hari Libur WNI': 25000,
          'Hari Libur WNA': 250000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/leuser.jpg',
        name: 'Gunung Leuser',
        managedBy: 'Taman Nasional Gunung Leuser',
        description:
            'Gunung dengan hutan hujan tropis dan satwa liar yang beragam.',
        location: 'Aceh, Aceh',
        height: 3381,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/marapi.jpg',
        name: 'Gunung Marapi',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description: 'Gunung berapi aktif dengan pemandangan yang spektakuler.',
        location: 'Agam, Sumatera Barat',
        height: 2891,
        prices: {
          'Hari Kerja WNI': 12000,
          'Hari Kerja WNA': 120000,
          'Hari Libur WNI': 18000,
          'Hari Libur WNA': 180000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/mekongga.jpg',
        name: 'Gunung Mekongga',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description: 'Gunung dengan pemandangan laut dan vegetasi yang subur.',
        location: 'Flores Timur, Nusa Tenggara Timur',
        height: 1645,
        prices: {
          'Hari Kerja WNI': 8000,
          'Hari Kerja WNA': 80000,
          'Hari Libur WNI': 12000,
          'Hari Libur WNA': 120000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/pangrango.jpg',
        name: 'Gunung Pangrango',
        managedBy: 'Taman Nasional Gunung Gede Pangrango',
        description:
            'Gunung dengan jalur pendakian yang menantang dan panorama yang indah.',
        location: 'Bogor, Jawa Barat',
        height: 3019,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/papandayan.jpg',
        name: 'Gunung Papandayan',
        managedBy: 'Taman Nasional Gunung Halimun Salak',
        description: 'Gunung dengan kawah aktif dan pemandangan yang unik.',
        location: 'Garut, Jawa Barat',
        height: 2665,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/pesagi.jpg',
        name: 'Gunung Pesagi',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung dengan pemandangan laut dan jalur pendakian yang menyenangkan.',
        location: 'Lombok Utara, Nusa Tenggara Barat',
        height: 617,
        prices: {
          'Hari Kerja WNI': 5000,
          'Hari Kerja WNA': 50000,
          'Hari Libur WNI': 8000,
          'Hari Libur WNA': 80000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/puncak jaya.jpg',
        name: 'Puncak Jaya',
        managedBy: 'Taman Nasional Lorentz',
        description:
            'Gunung tertinggi di Indonesia dengan pemandangan es yang spektakuler.',
        location: 'Papua, Papua',
        height: 4884,
        prices: {
          'Hari Kerja WNI': 50000,
          'Hari Kerja WNA': 500000,
          'Hari Libur WNI': 60000,
          'Hari Libur WNA': 600000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/sibuatan.jpg',
        name: 'Gunung Sibuatan',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description: 'Gunung dengan pemandangan laut dan vegetasi yang subur.',
        location: 'Sangihe, Sulawesi Utara',
        height: 1872,
        prices: {
          'Hari Kerja WNI': 8000,
          'Hari Kerja WNA': 80000,
          'Hari Libur WNI': 12000,
          'Hari Libur WNA': 120000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/welirang.jpg',
        name: 'Gunung Welirang',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung dengan kawah aktif dan pemandangan yang spektakuler.',
        location: 'Mojokerto, Jawa Timur',
        height: 3156,
        prices: {
          'Hari Kerja WNI': 15000,
          'Hari Kerja WNA': 150000,
          'Hari Libur WNI': 20000,
          'Hari Libur WNA': 200000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/trikora.jpg',
        name: 'Gunung Trikora',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung tertinggi di Papua dengan pemandangan es yang luar biasa.',
        location: 'Jayawijaya, Papua',
        height: 4750,
        prices: {
          'Hari Kerja WNI': 30000,
          'Hari Kerja WNA': 300000,
          'Hari Libur WNI': 35000,
          'Hari Libur WNA': 350000,
        },
      ),
      Mountain(
        image: 'assets/tiket_masuk/talamau.jpg',
        name: 'Gunung Talamau',
        managedBy: 'Balai Konservasi Sumber Daya Alam',
        description:
            'Gunung dengan hutan hujan tropis dan biodiversitas tinggi.',
        location: 'Minahasa, Sulawesi Utara',
        height: 1680,
        prices: {
          'Hari Kerja WNI': 10000,
          'Hari Kerja WNA': 100000,
          'Hari Libur WNI': 15000,
          'Hari Libur WNA': 150000,
        },
      ),
    ];

    if (selectedProvince == null || selectedProvince == 'Semua') {
      return allMountains;
    }

    return allMountains.where((mountain) {
      return mountain.location.contains(selectedProvince!);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final allMountains = _getFilteredMountains();
    final mountains = selectedProvince == null || selectedProvince == 'Semua'
        ? allMountains
        : allMountains
              .where(
                (mountain) => mountain.location.contains(selectedProvince!),
              )
              .toList();

    // Extract unique provinces from mountains
    Set<String> provinces = {'Semua'};
    for (var mountain in allMountains) {
      var parts = mountain.location.split(', ');
      if (parts.length > 1) {
        provinces.add(parts[1]);
      }
    }
    List<String> sortedProvinces = provinces.toList()..sort();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.shade400,
                Colors.green.shade300,
                Colors.green.shade200,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: [
                Image.asset('assets/LOGO.png', height: 40, width: 40),
                const SizedBox(width: 8),
                Text(
                  'Travel & Ojek',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      // Add notification functionality
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Filter Section
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF2A4D3A).withOpacity(0.9),
                    Color(0xFF4A7C59).withOpacity(0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.95),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF2A4D3A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.filter_list,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Filter Berdasarkan Provinsi',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A4D3A),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_getFilteredMountains().length} Gunung',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2A4D3A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.green.shade200,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.shade100.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Pilih Provinsi',
                          labelStyle: TextStyle(
                            color: Color(0xFF2A4D3A),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            backgroundColor: Colors.green.shade50.withOpacity(
                              0.7,
                            ),
                            letterSpacing: 0.5,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          suffixIcon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFF2A4D3A),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        initialValue: selectedProvince,
                        style: TextStyle(
                          color: Color(0xFF2A4D3A),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        dropdownColor: Colors.white,
                        items: sortedProvinces.map((province) {
                          return DropdownMenuItem(
                            value: province,
                            child: Row(
                              children: [
                                Icon(
                                  province == 'Semua'
                                      ? Icons.public
                                      : Icons.location_on,
                                  color: Color(0xFF2A4D3A),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  province == 'Semua'
                                      ? 'Semua Provinsi'
                                      : province,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => selectedProvince = value),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Mountain List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: mountains.length,
                itemBuilder: (context, index) {
                  final mountain = mountains[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TravelOjekDetailPage(mountain: mountain),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Hero Image with Gradient Overlay
                              Stack(
                                children: [
                                  Image.asset(
                                    mountain.image,
                                    height: 220,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    height: 220,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.7),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    left: 16,
                                    right: 16,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          mountain.name,
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black.withOpacity(
                                                  0.5,
                                                ),
                                                offset: const Offset(1, 1),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              mountain.location,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 16,
                                    right: 16,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.height,
                                            size: 16,
                                            color: Color(0xFF2A4D3A),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${mountain.height} mdpl',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF2A4D3A),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Content Section
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Description
                                    Text(
                                      mountain.description,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Managed By
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.business,
                                          size: 20,
                                          color: Colors.grey.shade600,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            'Dikelola oleh: ${mountain.managedBy}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
