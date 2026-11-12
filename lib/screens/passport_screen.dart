import 'package:flutter/material.dart';
import '../models/country.dart';
import '../models/passport_stamp.dart';
import '../theme/app_theme.dart';
import 'country_journal_screen.dart';

class PassportScreen extends StatelessWidget {
  final List<Country> countries;
  final List<ExplorerBadge> badges;
  final VoidCallback onNavigateToExplore;

  const PassportScreen({
    super.key,
    required this.countries,
    required this.badges,
    required this.onNavigateToExplore,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final collectedCountries = countries.where((c) => c.isStampCollected).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Eyebrow
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCoral.withValues(alpha: 0.2) : AppColors.coralLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'YOUR CURIOSITY, COLLECTED ✦',
                  style: TextStyle(
                    color: isDark ? AppColors.darkCoral : AppColors.coral,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'My World Passport',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 18),

              // Digital Leather-Bound Passport Cover
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E2640), Color(0xFF101524), Color(0xFF090D17)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.gold.withValues(alpha: 0.4), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.navyInk.withValues(alpha: 0.25),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'CULTUREPOP',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3.0,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.gold.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'OFFICIAL PASSPORT',
                            style: TextStyle(
                              color: AppColors.gold,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.gold.withValues(alpha: 0.5), width: 1.5),
                        ),
                        child: const Center(
                          child: Icon(Icons.public_rounded, size: 42, color: AppColors.gold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'ALEX MORGAN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${collectedCountries.length} / ${countries.length} countries explored',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: countries.isEmpty ? 0.0 : collectedCountries.length / countries.length,
                        minHeight: 6,
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        valueColor: const AlwaysStoppedAnimation(AppColors.gold),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              // Stamps Section Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Little places, big memories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.navyInk,
                    ),
                  ),
                  Text(
                    '${collectedCountries.length} Collected',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.coral,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Visa Stamps Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: countries.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.25,
                ),
                itemBuilder: (context, index) {
                  final c = countries[index];
                  final isCollected = c.isStampCollected;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountryJournalScreen(
                            country: c,
                            onToggleBookmark: (_) {},
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: isCollected
                              ? c.primaryColor.withValues(alpha: 0.6)
                              : (isDark ? AppColors.darkCardBorder : AppColors.creamAccent),
                          width: isCollected ? 1.5 : 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withValues(alpha: 0.25)
                                : AppColors.navyInk.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(c.flagEmoji, style: const TextStyle(fontSize: 26)),
                          const SizedBox(height: 6),
                          Text(
                            c.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isCollected
                                  ? c.primaryColor.withValues(alpha: isDark ? 0.2 : 0.12)
                                  : (isDark ? const Color(0xFF0F172A) : AppColors.creamAccent.withValues(alpha: 0.6)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              isCollected ? 'COLLECTED ✓' : 'TO EXPLORE',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: isCollected ? c.primaryColor : (isDark ? AppColors.darkTextSecondary : AppColors.navyLight),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Achievement Badges
              const Text(
                'Achievement Badges',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navyInk,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: badges.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final badge = badges[index];

                    return Container(
                      width: 130,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: badge.isUnlocked
                              ? badge.color.withValues(alpha: 0.4)
                              : AppColors.creamAccent,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            badge.icon,
                            color: badge.isUnlocked ? badge.color : AppColors.navyLight.withValues(alpha: 0.5),
                            size: 26,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            badge.title,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: badge.isUnlocked ? AppColors.navyInk : AppColors.navyLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            badge.isUnlocked ? 'EARNED ✦' : 'LOCKED',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                              color: badge.isUnlocked ? badge.color : AppColors.navyLight,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Explore More Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: onNavigateToExplore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.coral,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text(
                    'Explore More Countries ➔',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
