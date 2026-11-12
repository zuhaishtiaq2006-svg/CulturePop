import 'package:flutter/material.dart';

class FamousPlace {
  final String name;
  final String category;
  final String imageUrl;
  final String description;
  final String whyVisit;
  final String bestTimeToVisit;
  final String entryTip;
  final double rating;

  const FamousPlace({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.whyVisit,
    required this.bestTimeToVisit,
    required this.entryTip,
    this.rating = 4.9,
  });
}

class City {
  final String name;
  final String landmark;
  final String imageUrl;
  final String description;
  final String bestTimeToVisit;
  final String famousFor;
  final double rating;
  final bool isPopular;
  final List<String> keySights;
  final List<FamousPlace> popularPlaces;
  final String localSecret;
  final String gettingAround;
  final String neighborhoodVibe;
  final List<String> topDishes;
  final String travelTip;

  const City({
    required this.name,
    required this.landmark,
    required this.imageUrl,
    required this.description,
    required this.bestTimeToVisit,
    required this.famousFor,
    this.rating = 4.9,
    this.isPopular = false,
    this.keySights = const [],
    this.popularPlaces = const [],
    this.localSecret = '',
    this.gettingAround = 'Walkable center with comprehensive transit network.',
    this.neighborhoodVibe = 'Vibrant, historic and pedestrian friendly.',
    this.topDishes = const [],
    this.travelTip = 'Get a contactless transit pass on arrival.',
  });
}

class FoodItem {
  final String name;
  final String localName;
  final String category;
  final String imageUrl;
  final String description;
  final List<String> ingredients;
  final String tasteProfile;
  final String tableEtiquette;
  final String priceRange;
  bool isFavorite;

  FoodItem({
    required this.name,
    required this.localName,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.ingredients,
    required this.tasteProfile,
    required this.tableEtiquette,
    this.priceRange = '\$\$',
    this.isFavorite = false,
  });
}

class AudioTrack {
  final String title;
  final String subtitle;
  final String genre;
  final String duration;
  final String instrument;
  final String description;
  final int bpm;

  const AudioTrack({
    required this.title,
    required this.subtitle,
    required this.genre,
    required this.duration,
    required this.instrument,
    required this.description,
    this.bpm = 95,
  });
}

class ClothingItem {
  final String name;
  final String localName;
  final String whenItsWorn;
  final String imageUrl;
  final String description;
  final String fabricDetails;
  final String culturalMeaning;

  const ClothingItem({
    required this.name,
    required this.localName,
    required this.whenItsWorn,
    required this.imageUrl,
    required this.description,
    required this.fabricDetails,
    required this.culturalMeaning,
  });
}

enum PhraseCategory {
  greetings,
  dining,
  directions,
  shopping,
  emergency,
}

class Phrase {
  final String english;
  final String nativeScript;
  final String phonetic;
  final String description;
  final String politenessTip;
  final PhraseCategory category;

  const Phrase({
    required this.english,
    required this.nativeScript,
    required this.phonetic,
    required this.description,
    required this.politenessTip,
    this.category = PhraseCategory.greetings,
  });
}

class Tradition {
  final String title;
  final String subtitle;
  final String description;
  final String didYouKnow;
  final IconData icon;
  final String dosAndDonts;

  const Tradition({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.didYouKnow,
    required this.icon,
    this.dosAndDonts = 'Observe respectfully and follow the lead of local elders.',
  });
}

class EtiquetteItem {
  final String title;
  final String category;
  final String doRule;
  final String dontRule;
  final String whyItMatters;
  final IconData icon;

  const EtiquetteItem({
    required this.title,
    required this.category,
    required this.doRule,
    required this.dontRule,
    required this.whyItMatters,
    this.icon = Icons.info_outline_rounded,
  });
}

class FestivalItem {
  final String name;
  final String month;
  final String duration;
  final String imageUrl;
  final String description;
  final String celebrationRitual;
  final String touristTip;

  const FestivalItem({
    required this.name,
    required this.month,
    required this.duration,
    required this.imageUrl,
    required this.description,
    required this.celebrationRitual,
    required this.touristTip,
  });
}

class TravelBudgetInfo {
  final String currencyCode;
  final String currencySymbol;
  final double exchangeRateToUsd;
  final double exchangeRateToPkr;
  final double dailyBackpackerUsd;
  final double dailyComfortUsd;
  final double dailyLuxuryUsd;
  final String tippingGuideline;
  final String cashOrCardAdvice;
  final String bargainingTip;

  const TravelBudgetInfo({
    required this.currencyCode,
    required this.currencySymbol,
    required this.exchangeRateToUsd,
    required this.exchangeRateToPkr,
    required this.dailyBackpackerUsd,
    required this.dailyComfortUsd,
    required this.dailyLuxuryUsd,
    required this.tippingGuideline,
    required this.cashOrCardAdvice,
    required this.bargainingTip,
  });
}

class TravelEmergencyInfo {
  final String police;
  final String ambulance;
  final String touristHotline;
  final String tapWaterSafety;
  final String plugType;
  final String simCardAdvice;

  const TravelEmergencyInfo({
    required this.police,
    required this.ambulance,
    required this.touristHotline,
    required this.tapWaterSafety,
    required this.plugType,
    required this.simCardAdvice,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class Country {
  final String id;
  final String name;
  final String nativeName;
  final String flagEmoji;
  final String continent;
  final String capital;
  final String currency;
  final String motto;
  final String shortDescription;
  final String fullDescription;
  final String bannerImageUrl;
  final Color primaryColor;
  final Color accentColor;
  final List<City> cities;
  final List<FoodItem> foods;
  final List<AudioTrack> tracks;
  final List<ClothingItem> clothes;
  final List<Phrase> phrases;
  final List<Tradition> traditions;
  final List<QuizQuestion> quiz;
  final List<EtiquetteItem> etiquette;
  final List<FestivalItem> festivals;
  static const TravelBudgetInfo defaultBudgetInfo = TravelBudgetInfo(
    currencyCode: 'USD',
    currencySymbol: '\$',
    exchangeRateToUsd: 1.0,
    exchangeRateToPkr: 278.0,
    dailyBackpackerUsd: 45.0,
    dailyComfortUsd: 120.0,
    dailyLuxuryUsd: 350.0,
    tippingGuideline: 'Tipping standards vary by establishment.',
    cashOrCardAdvice: 'Major international credit cards are widely accepted in cities.',
    bargainingTip: 'Polite bargaining is common in local markets; fixed prices in malls.',
  );

  static const TravelEmergencyInfo defaultEmergencyInfo = TravelEmergencyInfo(
    police: '112',
    ambulance: '112',
    touristHotline: '112',
    tapWaterSafety: 'Check local guidelines regarding tap water.',
    plugType: 'Standard plugs (Universal adapter recommended)',
    simCardAdvice: 'eSIM or tourist SIM card available at international airports.',
  );

  final TravelBudgetInfo budgetInfo;
  final TravelEmergencyInfo emergencyInfo;
  bool isBookmarked;
  bool isStampCollected;

  Country({
    required this.id,
    required this.name,
    required this.nativeName,
    required this.flagEmoji,
    required this.continent,
    required this.capital,
    required this.currency,
    required this.motto,
    required this.shortDescription,
    required this.fullDescription,
    required this.bannerImageUrl,
    required this.primaryColor,
    required this.accentColor,
    required this.cities,
    required this.foods,
    this.tracks = const [],
    required this.clothes,
    required this.phrases,
    required this.traditions,
    required this.quiz,
    this.etiquette = const [],
    this.festivals = const [],
    this.budgetInfo = defaultBudgetInfo,
    this.emergencyInfo = defaultEmergencyInfo,
    this.isBookmarked = false,
    this.isStampCollected = false,
  });
}
