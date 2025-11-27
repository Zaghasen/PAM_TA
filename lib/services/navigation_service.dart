import 'package:flutter/material.dart';
import 'package:tapak_jejak/screens/icons/blog/blog.dart';
import 'package:tapak_jejak/screens/icons/camping_ground/camping_ground.dart';
import 'package:tapak_jejak/screens/icons/cuaca/cuaca.dart';
import 'package:tapak_jejak/screens/icons/eat_stay/eat&stay.dart';
import 'package:tapak_jejak/screens/icons/event/event.dart';
import 'package:tapak_jejak/screens/icons/keamanan/keamanan.dart';
import 'package:tapak_jejak/screens/icons/porter_guide/porter&guide.dart';
import 'package:tapak_jejak/screens/icons/sewa_alat/sewa_alat.dart';
import 'package:tapak_jejak/screens/icons/tiket_masuk/tiket_masuk.dart';
import 'package:tapak_jejak/screens/icons/travel_ojek/travel&ojek.dart';
import 'package:tapak_jejak/screens/icons/trip/private&open_trip.dart';
import 'package:tapak_jejak/screens/icons/tutorial/tutorial.dart';
import 'package:tapak_jejak/screens/terms/terms_page.dart';

class NavigationService {
  static void navigateToService(BuildContext context, String serviceName) {
    Widget? page;
    bool needsTerms = false;

    switch (serviceName) {
      case 'tiket_masuk':
        page = const TiketMasukPage();
        needsTerms = true;
        break;
      case 'travel_ojek':
        page = const TravelOjekPage();
        needsTerms = true;
        break;
      case 'porter_guide':
        page = const PorterGuidePage();
        needsTerms = true;
        break;
      case 'sewa_alat':
        page = const SewaAlatPage();
        needsTerms = true;
        break;
      case 'trip':
        page = const PrivateOpenTripPage();
        needsTerms = true;
        break;
      case 'camping_ground':
        page = const CampingGroundPage();
        needsTerms = true;
        break;
      case 'event':
        page = const EventPage();
        break;
      case 'eat_stay':
        page = const EatStayPage();
        break;
      case 'keamanan':
        page = const KeamananPage();
        break;
      case 'cuaca':
        page = const CuacaPage();
        break;
      case 'blog':
        page = const BlogPage();
        break;
      case 'tutorial':
        page = const TutorialPage();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Layanan $serviceName tidak ditemukan')),
        );
        return;
    }

    if (needsTerms) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TermsScreen(nextPage: page!)),
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page!));
    }
  }
}
