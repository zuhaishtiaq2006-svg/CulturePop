import 'package:flutter/material.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';
import 'cities_screen.dart';
import 'food_screen.dart';
import 'festivals_screen.dart';
import 'attire_screen.dart';
import 'phrases_screen.dart';
import 'traditions_screen.dart';
import 'quiz_screen.dart';
import 'postcard_studio_screen.dart';

class CountryJournalScreen extends StatelessWidget {
  final Country country;
  final Function(Country) onToggleBookmark;

  const CountryJournalScreen({
    super.key,
    required this.country,
    required this.onToggleBookmark,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              country.isBookmarked
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              color: country.isBookmarked
                  ? AppColors.coral
                  : (isDark ? AppColors.darkTextPrimary : AppColors.navyInk),
            ),
            onPressed: () => onToggleBookmark(country),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Journal Eyebrow
            Text(
              'YOUR CULTURE JOURNAL',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.darkTextSecondary : AppColors.navyLight,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 4),

            // Country Title (Overflow-safe with Expanded)
            Row(
              children: [
                Expanded(
                  child: Text(
                    country.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(country.flagEmoji, style: const TextStyle(fontSize: 28)),
              ],
            ),

            const SizedBox(height: 8),

            // Little Escape Banner Box
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    country.primaryColor.withValues(alpha: 0.12),
                    country.accentColor.withValues(alpha: 0.15),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: country.primaryColor.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: country.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${country.flagEmoji} A little escape to ${country.name}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        country.nativeName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.navyInk.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Welcome to ${country.name}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.navyInk,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    country.fullDescription,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: AppColors.navySoft,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Portals Header
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Follow your curiosity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.navyInk,
                  ),
                ),
                Text(
                  '8 discoveries ✦',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.coral,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // 1. Cities & Landmarks
            _buildDiscoveryPortal(
              context,
              icon: Icons.location_city_rounded,
              category: 'Famous Places',
              title: 'Explore ${country.cities.length} Iconic Cities',
              subtitle: 'From ${country.cities.first.name} to ${country.cities.last.name}',
              color: AppColors.sky,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitiesScreen(country: country),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 2. Food & Flavors
            _buildDiscoveryPortal(
              context,
              icon: Icons.restaurant_rounded,
              category: 'Food & Flavors',
              title: 'Taste ${country.name}',
              subtitle: 'A delicious place to begin · ${country.foods.first.name} & more',
              color: AppColors.peach,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodScreen(country: country),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 3. Cultural Festivals & Carnivals
            _buildDiscoveryPortal(
              context,
              icon: Icons.festival_rounded,
              category: 'Festivals & Events',
              title: 'Celebrate ${country.name}',
              subtitle: 'From ${country.festivals.isNotEmpty ? country.festivals.first.name : "grand celebrations"} & living rituals',
              color: const Color(0xFFE63946),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FestivalsScreen(country: country),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 4. Woven Stories (Clothing)
            _buildDiscoveryPortal(
              context,
              icon: Icons.checkroom_rounded,
              category: 'Woven Stories',
              title: 'Wear the Culture',
              subtitle: 'Stories woven into every fold · ${country.clothes.first.name}',
              color: AppColors.mint,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AttireScreen(country: country),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 5. Say Hello (Phrases)
            _buildDiscoveryPortal(
              context,
              icon: Icons.record_voice_over_rounded,
              category: 'Little Connections',
              title: 'Speak the Language',
              subtitle: 'Small words, warm connections & pronunciation audio',
              color: AppColors.coral,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhrasesScreen(country: country),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 6. Everyday Meaning (Traditions)
            _buildDiscoveryPortal(
              context,
              icon: Icons.spa_rounded,
              category: 'Everyday Meaning',
              title: 'Discover Traditions',
              subtitle: 'The beauty of everyday rituals and deep customs',
              color: const Color(0xFF5390D9),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TraditionsScreen(country: country),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 7. Mini Quiz
            _buildDiscoveryPortal(
              context,
              icon: Icons.psychology_rounded,
              category: 'Culture Check',
              title: 'Test Your Culture IQ',
              subtitle: '5 questions challenge · Earn your official passport stamp',
              color: AppColors.gold,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(country: country),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 8. Virtual Postcard Studio
            _buildDiscoveryPortal(
              context,
              icon: Icons.mail_rounded,
              category: 'Postcard Studio',
              title: 'Send a Memory',
              subtitle: 'A little piece of ${country.name}, handcrafted by you',
              color: const Color(0xFFE63946),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostcardStudioScreen(country: country),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Bottom Note
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.creamAccent),
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome, color: AppColors.coral, size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'A starting point, not the whole story. Every region has something new to share.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.navyLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscoveryPortal(
    BuildContext context, {
    required IconData icon,
    required String category,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
          width: 1,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: isDark ? 0.2 : 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color, size: 26),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.navyLight,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.navyLight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
