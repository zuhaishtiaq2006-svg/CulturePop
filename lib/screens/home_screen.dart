import 'dart:math';
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';
import '../widgets/app_network_image.dart';
import 'country_journal_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Country> countries;
  final VoidCallback onNavigateToExplore;
  final VoidCallback onNavigateToPassport;
  final Function(Country) onToggleBookmark;

  const HomeScreen({
    super.key,
    required this.countries,
    required this.onNavigateToExplore,
    required this.onNavigateToPassport,
    required this.onToggleBookmark,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _dailyQuoteIndex = 0;

  // Cultural Quotes for "Culture Bite of the Day"
  final List<Map<String, String>> _culturalQuotes = [
    {
      'concept': 'Kintsugi (金継ぎ)',
      'country': 'Japan 🇯🇵',
      'meaning': 'The art of repairing broken pottery with gold — embracing flaws and history.',
      'tag': 'Philosophy',
    },
    {
      'concept': 'Dolce Far Niente',
      'country': 'Italy 🇮🇹',
      'meaning': 'The exquisite sweetness of doing absolutely nothing and cherishing the moment.',
      'tag': 'Lifestyle',
    },
    {
      'concept': 'Keyif',
      'country': 'Türkiye 🇹🇷',
      'meaning': 'The quiet, serene art of relaxation and sipping hot çay without rushing time.',
      'tag': 'Tradition',
    },
    {
      'concept': 'Han (한) & Jeong (정)',
      'country': 'South Korea 🇰🇷',
      'meaning': 'Deep emotional connection, shared resilience, and enduring communal warmth.',
      'tag': 'Heritage',
    },
    {
      'concept': 'Yin & Yang (阴阳)',
      'country': 'China 🇨🇳',
      'meaning': 'Harmonious balance of contrasting forces — light and shadow in perpetual dance.',
      'tag': 'Wisdom',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openCountry(Country country) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryJournalScreen(
          country: country,
          onToggleBookmark: widget.onToggleBookmark,
        ),
      ),
    );
  }

  void _surpriseMe() {
    if (widget.countries.isEmpty) return;
    final random = Random();
    final luckyCountry = widget.countries[random.nextInt(widget.countries.length)];
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Text(luckyCountry.flagEmoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Teleporting to ${luckyCountry.name}…',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        backgroundColor: luckyCountry.primaryColor,
        duration: const Duration(milliseconds: 1400),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _openCountry(luckyCountry);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final heroCountry = widget.countries.firstWhere(
      (c) => c.id == 'japan',
      orElse: () => widget.countries.first,
    );

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.warmCream,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Bar (Explorer Greeting + Dark/Light Theme Toggle + Avatar)
              _buildTopBar(isDark),

              const SizedBox(height: 18),

              // 2. Search Bar with Instant Query
              _buildSearchBar(isDark),

              const SizedBox(height: 18),

              // 3. Culture Bite of the Day (Quote Pill Card)
              _buildCultureBiteCard(isDark),

              const SizedBox(height: 22),

              // 4. Hero Escape Card ("THIS WEEK'S LITTLE ESCAPE ✦")
              _buildHeroEscapeCard(context, heroCountry, isDark),

              const SizedBox(height: 24),

              // 5. Popular Destinations Rail (All 10 Countries)
              _buildPopularRail(context, isDark),

              const SizedBox(height: 26),

              // 6. Your World Passport Widget (PDF Page 3 Spec)
              _buildPassportWidget(context, isDark),

              const SizedBox(height: 26),

              // 7. Continue Exploring Section
              _buildContinueExploring(context, isDark),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // 1. TOP BAR WITH BRAND HEADER, THEME SWITCHER & AVATAR
  // ============================================================
  Widget _buildTopBar(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row 1: Brand Logo on Left, Theme Toggle Pill + Avatar on Right
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: CulturePop Brand
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark ? AppColors.darkCoral : AppColors.coral,
                      width: 2.2,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? AppColors.darkCoral : AppColors.coral,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'CulturePop',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
                    letterSpacing: -0.4,
                  ),
                ),
              ],
            ),

            // Right: Interactive Theme Toggle Pill + Profile Avatar
            Row(
              children: [
                // Theme Toggle Pill
                GestureDetector(
                  onTap: toggleAppTheme,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                          color: isDark ? const Color(0xFF38BDF8) : const Color(0xFFF59E0B),
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          isDark ? 'Dark' : 'Light',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // Authentic Explorer Avatar
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: (isDark ? AppColors.darkCoral : AppColors.coral).withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withValues(alpha: 0.3)
                            : AppColors.navyInk.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      'assets_png/p3_8_X1.webp',
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Text('🌏', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Row 2: Full-width Greeting (Zero overflow!)
        Row(
          children: [
            Text(
              'Hey Explorer! ',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? AppColors.darkCoral : AppColors.coral,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Text('✦', style: TextStyle(color: AppColors.gold, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Where will you explore\ntoday?',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // 2. SEARCH BAR
  // ============================================================
  Widget _buildSearchBar(bool isDark) {
    return GestureDetector(
      onTap: widget.onNavigateToExplore,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.25)
                  : AppColors.navyInk.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              color: isDark ? AppColors.darkTextSecondary : AppColors.navyLight,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Search 10 countries, cities or dishes…',
                style: TextStyle(
                  color: isDark ? AppColors.darkTextSecondary : AppColors.navyLight,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkCoral.withValues(alpha: 0.15)
                    : AppColors.coralLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.tune_rounded,
                color: isDark ? AppColors.darkCoral : AppColors.coral,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // 3. CULTURE BITE OF THE DAY CARD
  // ============================================================
  Widget _buildCultureBiteCard(bool isDark) {
    final quote = _culturalQuotes[_dailyQuoteIndex];

    return GestureDetector(
      onTap: () {
        setState(() {
          _dailyQuoteIndex = (_dailyQuoteIndex + 1) % _culturalQuotes.length;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF1E293B),
                    const Color(0xFF0F172A),
                  ]
                : [
                    const Color(0xFFFFF7ED),
                    const Color(0xFFFFFBEB),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark
                ? const Color(0xFF334155)
                : const Color(0xFFFDE68A).withValues(alpha: 0.6),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.2)
                  : const Color(0xFFF59E0B).withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFFFBBF24).withValues(alpha: 0.15)
                    : const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Color(0xFFF59E0B),
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'CULTURE BITE OF THE DAY ✦',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w900,
                          color: isDark ? const Color(0xFFFBBF24) : const Color(0xFFB45309),
                          letterSpacing: 1.1,
                        ),
                      ),
                      Text(
                        quote['country']!,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    quote['concept']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    quote['meaning']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : const Color(0xFF475569),
                      height: 1.35,
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

  // ============================================================
  // 4. HERO ESCAPE CARD (PDF PAGE 3 DESIGN)
  // ============================================================
  Widget _buildHeroEscapeCard(BuildContext context, Country country, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: country.primaryColor.withValues(alpha: isDark ? 0.25 : 0.20),
            blurRadius: 26,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            // Background Artwork (Local PDF Asset with Network Fallback)
            SizedBox(
              height: 220,
              width: double.infinity,
              child: AppNetworkImage(
                imageUrl: country.bannerImageUrl,
                fit: BoxFit.cover,
                placeholderLabel: country.name,
              ),
            ),

            // Gradient Tint
            Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.88),
                  ],
                ),
              ),
            ),

            // Top Badge
            Positioned(
              top: 16,
              left: 18,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Text(
                  'THIS WEEK’S LITTLE ESCAPE ✦',
                  style: TextStyle(
                    color: AppColors.navyInk,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),

            // Surprise Me Dice Button
            Positioned(
              top: 14,
              right: 18,
              child: GestureDetector(
                onTap: _surpriseMe,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                  ),
                  child: const Row(
                    children: [
                      Text('🎲', style: TextStyle(fontSize: 13)),
                      SizedBox(width: 4),
                      Text(
                        'Surprise',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Content & Explore Action
            Positioned(
              bottom: 18,
              left: 18,
              right: 18,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discover ${country.name} ${country.flagEmoji}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Food, traditions, music & more',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () => _openCountry(country),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.coral,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
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

  // ============================================================
  // 5. POPULAR DESTINATIONS RAIL (ALL 10 COUNTRIES)
  // ============================================================
  Widget _buildPopularRail(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular destinations',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
                color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
                letterSpacing: -0.3,
              ),
            ),
            GestureDetector(
              onTap: widget.onNavigateToExplore,
              child: Text(
                'See all ➔',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: isDark ? AppColors.darkCoral : AppColors.coral,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.countries.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final c = widget.countries[index];
              return GestureDetector(
                onTap: () => _openCountry(c),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withValues(alpha: 0.2)
                            : AppColors.navyInk.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(c.flagEmoji, style: const TextStyle(fontSize: 19)),
                      const SizedBox(width: 8),
                      Text(
                        c.name,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  // 6. YOUR WORLD PASSPORT WIDGET (PDF PAGE 3 MATCH)
  // ============================================================
  Widget _buildPassportWidget(BuildContext context, bool isDark) {
    final collected = widget.countries.where((c) => c.isStampCollected).length;
    final total = widget.countries.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : AppColors.navyInk.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your World Passport',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      ' / 195 countries explored',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.navyLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: widget.onNavigateToPassport,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkCoral.withValues(alpha: 0.2)
                        : AppColors.coralLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'View Passport ➔',
                    style: TextStyle(
                      color: isDark ? AppColors.darkCoral : AppColors.coral,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: total == 0 ? 0.0 : max(0.04, collected / total),
              minHeight: 8,
              backgroundColor: isDark
                  ? const Color(0xFF1E293B)
                  : AppColors.creamAccent,
              valueColor: AlwaysStoppedAnimation(
                isDark ? AppColors.darkCoral : AppColors.coral,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Visual Stamp Tiles (PDF Page 3 Spec)
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.countries.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final c = widget.countries[index];
                return GestureDetector(
                  onTap: () => _openCountry(c),
                  child: Container(
                    width: 82,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: c.isStampCollected
                          ? (isDark
                              ? const Color(0x2A2A9D8F)
                              : AppColors.mintLight)
                          : (isDark
                              ? const Color(0xFF0F172A)
                              : AppColors.creamAccent.withValues(alpha: 0.45)),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: c.isStampCollected
                            ? AppColors.mint
                            : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
                        width: c.isStampCollected ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(c.flagEmoji, style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 3),
                        Text(
                          c.isStampCollected ? 'COLLECTED' : 'DISCOVER',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                            color: c.isStampCollected
                                ? AppColors.mint
                                : (isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.navyLight),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // 7. CONTINUE EXPLORING SECTION (PDF PAGE 3 DESIGN)
  // ============================================================
  Widget _buildContinueExploring(BuildContext context, bool isDark) {
    final country1 = widget.countries.firstWhere(
      (c) => c.id == 'japan',
      orElse: () => widget.countries[0],
    );
    final country2 = widget.countries.firstWhere(
      (c) => c.id == 'korea',
      orElse: () => widget.countries.length > 3 ? widget.countries[3] : widget.countries[0],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Continue Exploring',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildContinueCard(
                context,
                country1,
                '2 of 7 stories',
                'Your next discovery',
                AppColors.coral,
                0.28,
                isDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildContinueCard(
                context,
                country2,
                '4 of 7 stories',
                'Back to the rhythm',
                AppColors.lavender,
                0.57,
                isDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContinueCard(
    BuildContext context,
    Country country,
    String storiesCount,
    String nextUpLabel,
    Color accentColor,
    double progress,
    bool isDark,
  ) {
    return GestureDetector(
      onTap: () => _openCountry(country),
      child: Container(
        padding: const EdgeInsets.all(16),
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
                  : AppColors.navyInk.withValues(alpha: 0.05),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(country.flagEmoji, style: const TextStyle(fontSize: 26)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: isDark ? 0.25 : 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    storiesCount,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              country.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              nextUpLabel,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.darkTextSecondary : AppColors.navyLight,
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                backgroundColor: isDark
                    ? const Color(0xFF1E293B)
                    : AppColors.creamAccent,
                valueColor: AlwaysStoppedAnimation(accentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
