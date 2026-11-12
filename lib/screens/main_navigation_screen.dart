import 'package:flutter/material.dart';
import '../data/culture_data.dart';
import '../models/country.dart';
import '../models/passport_stamp.dart';
import '../models/postcard.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'explore_screen.dart';
import 'passport_screen.dart';
import 'profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => MainNavigationScreenState();
}

class MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  late List<Country> _countries;
  late List<ExplorerBadge> _badges;
  late List<Postcard> _postcards;

  @override
  void initState() {
    super.initState();
    _countries = CultureData.getCountries();
    _badges = CultureData.getInitialBadges();
    _postcards = CultureData.getInitialPostcards();
  }

  void switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void toggleBookmark(Country country) {
    setState(() {
      country.isBookmarked = !country.isBookmarked;
    });
  }

  void toggleFoodFavorite(FoodItem food) {
    setState(() {
      food.isFavorite = !food.isFavorite;
    });
  }

  void addPostcard(Postcard postcard) {
    setState(() {
      _postcards.insert(0, postcard);
    });
  }

  void unlockPassportStamp(String countryId) {
    setState(() {
      for (var c in _countries) {
        if (c.id == countryId) {
          c.isStampCollected = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(
        countries: _countries,
        onNavigateToExplore: () => switchTab(1),
        onNavigateToPassport: () => switchTab(2),
        onToggleBookmark: toggleBookmark,
      ),
      ExploreScreen(
        countries: _countries,
        onToggleBookmark: toggleBookmark,
      ),
      PassportScreen(
        countries: _countries,
        badges: _badges,
        onNavigateToExplore: () => switchTab(1),
      ),
      ProfileScreen(
        countries: _countries,
        badges: _badges,
        postcards: _postcards,
        onNavigateToExplore: () => switchTab(1),
      ),
    ];

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.warmCream,
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          border: isDark
              ? const Border(
                  top: BorderSide(color: AppColors.darkCardBorder, width: 1))
              : null,
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.35)
                  : AppColors.navyInk.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_rounded, 'Home', isDark),
                _buildNavItem(1, Icons.explore_rounded, 'Explore', isDark),
                _buildNavItem(2, Icons.badge_rounded, 'Passport', isDark),
                _buildNavItem(3, Icons.person_rounded, 'Profile', isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, bool isDark) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => switchTab(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                  ? AppColors.darkCoral.withValues(alpha: 0.22)
                  : AppColors.coralLight)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected
                  ? (isDark ? AppColors.darkCoral : AppColors.coral)
                  : (isDark ? AppColors.darkTextSecondary : AppColors.navyLight),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isDark ? AppColors.darkCoral : AppColors.coral,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
