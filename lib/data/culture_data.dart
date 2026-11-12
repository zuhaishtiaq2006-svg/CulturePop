import 'package:flutter/material.dart';
import '../models/country.dart';
import '../models/passport_stamp.dart';
import '../models/postcard.dart';
import 'countries/brazil_data.dart';
import 'countries/china_data.dart';
import 'countries/france_data.dart';
import 'countries/italy_data.dart';
import 'countries/japan_data.dart';
import 'countries/korea_data.dart';
import 'countries/morocco_data.dart';
import 'countries/pakistan_data.dart';
import 'countries/spain_data.dart';
import 'countries/turkiye_data.dart';

class CultureData {
  static List<Country> getCountries() {
    return [
      JapanData.getCountry(),
      ItalyData.getCountry(),
      TurkiyeData.getCountry(),
      KoreaData.getCountry(),
      ChinaData.getCountry(),
      FranceData.getCountry(),
      MoroccoData.getCountry(),
      SpainData.getCountry(),
      BrazilData.getCountry(),
      PakistanData.getCountry(),
    ];
  }

  static List<ExplorerBadge> getInitialBadges() {
    return [
      ExplorerBadge(
        id: 'b1',
        title: 'First Step',
        subtitle: 'Start your world tour journey',
        icon: Icons.flight_takeoff_rounded,
        color: const Color(0xFFE76F51),
        isUnlocked: false,
      ),
      ExplorerBadge(
        id: 'b2',
        title: 'Asia Master',
        subtitle: 'Explore Japan, Korea & China',
        icon: Icons.temple_buddhist_rounded,
        color: const Color(0xFFF4A261),
        isUnlocked: false,
      ),
      ExplorerBadge(
        id: 'b3',
        title: 'European Voyager',
        subtitle: 'Discover Italy, France & Spain',
        icon: Icons.castle_rounded,
        color: const Color(0xFF2A9D8F),
        isUnlocked: false,
      ),
      ExplorerBadge(
        id: 'b4',
        title: 'Polyglot Student',
        subtitle: 'Learn survival phrases across 5+ languages',
        icon: Icons.record_voice_over_rounded,
        color: const Color(0xFF6366F1),
        isUnlocked: false,
      ),
      ExplorerBadge(
        id: 'b5',
        title: 'Foodie Globetrotter',
        subtitle: 'Bookmark 5+ traditional dishes',
        icon: Icons.restaurant_menu_rounded,
        color: const Color(0xFFBDB2FF),
        isUnlocked: false,
      ),
      ExplorerBadge(
        id: 'b6',
        title: 'Postcard Artist',
        subtitle: 'Craft and save custom travel memories',
        icon: Icons.mail_outline_rounded,
        color: const Color(0xFFE63946),
        isUnlocked: false,
      ),
    ];
  }

  static List<Postcard> getInitialPostcards() {
    return [
      Postcard(
        id: 'post_1',
        countryName: 'Japan',
        countryEmoji: '🇯🇵',
        imageUrl: 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?auto=format&fit=crop&w=800&q=80',
        stampTitle: 'JAPAN · 85',
        stickerIcon: '🌸',
        message: 'Wish you were here! Quiet bamboo rituals and spring sakura blossoms in Kyoto.',
        sender: 'Alex Morgan',
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }
}
