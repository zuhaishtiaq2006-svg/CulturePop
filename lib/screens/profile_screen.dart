import 'dart:math';
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/country.dart';
import '../models/passport_stamp.dart';
import '../models/postcard.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  final List<Country> countries;
  final List<ExplorerBadge> badges;
  final List<Postcard> postcards;
  final VoidCallback onNavigateToExplore;

  const ProfileScreen({
    super.key,
    required this.countries,
    required this.badges,
    required this.postcards,
    required this.onNavigateToExplore,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int get _collected => widget.countries.where((c) => c.isStampCollected).length;
  int get _totalCities => widget.countries.fold<int>(0, (sum, c) => sum + c.cities.length);
  String get _explorerTitle {
    if (_collected >= 7) return 'World Voyager';
    if (_collected >= 4) return 'Cultural Nomad';
    if (_collected >= 1) return 'Curious Traveler';
    return 'Fresh Explorer';
  }
  int get _level {
    if (_collected >= 7) return 4;
    if (_collected >= 4) return 3;
    if (_collected >= 1) return 2;
    return 1;
  }

  void _showPostcardModal(BuildContext context, Postcard card) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: AppColors.navyInk.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                  child: Image.network(
                    card.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${card.countryEmoji} ${card.countryName}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: AppColors.navyInk,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.coralLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              card.stampTitle,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: AppColors.coral,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        card.message,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.navyInk,
                          height: 1.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(card.stickerIcon, style: const TextStyle(fontSize: 22)),
                          const SizedBox(width: 8),
                          Text(
                            '— ${card.sender}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: AppColors.coral,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Postcard saved to gallery! 📸'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.download_rounded, size: 18),
                          label: const Text('Download Postcard'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.navyInk,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
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
      },
    );
  }

  void _showAboutProject(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.creamAccent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.coralLight,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.school_rounded, color: AppColors.coral, size: 24),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'COMSATS University Islamabad',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppColors.navyInk,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Sahiwal Campus • Computer Science',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.coral,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildInfoRow('📚', 'Course', 'Mobile App Development'),
                _buildInfoRow('📱', 'Project', 'CulturePop – Interactive World Tour'),
                _buildInfoRow('👨‍🏫', 'Submitted To', 'Sir Yousaf Khan'),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.warmCream,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GROUP MEMBERS',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: AppColors.coral,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('• Basmah Haroon (FA24-BSE-007)', style: TextStyle(fontSize: 13, color: AppColors.navySoft, height: 1.6)),
                      Text('• Rabia Mukhtar (FA24-BSE-021)', style: TextStyle(fontSize: 13, color: AppColors.navySoft, height: 1.6)),
                      Text('• Zuha Ishtiaq (FA24-BSE-034)', style: TextStyle(fontSize: 13, color: AppColors.navySoft, height: 1.6)),
                      SizedBox(height: 8),
                      Text('BS Software Engineering (BSSE) • FA-24 • Section A',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.navyLight)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String emoji, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Text('$label: ', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.navyInk)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13, color: AppColors.navySoft))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bookmarkedCountries = widget.countries.where((c) => c.isBookmarked).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== GRADIENT HERO HEADER ======
            _buildHeroHeader(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 22),

                  // ====== STATS ROW ======
                  _buildStatsRow(),

                  const SizedBox(height: 24),

                  // ====== ACHIEVEMENT BADGES ======
                  _buildAchievementSection(),

                  const SizedBox(height: 24),

                  // ====== TAB BAR ======
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.creamAccent),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.navyInk.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: AppColors.navyInk,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.navyLight,
                      labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(text: '💌 Postcards'),
                        Tab(text: '📌 Wishlist'),
                        Tab(text: '🗺️ World Tour'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ====== TAB CONTENT ======
                  SizedBox(
                    height: 260,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildPostcardsTab(),
                        _buildWishlistTab(bookmarkedCountries),
                        _buildWorldTourTab(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ====== DARK THEME PREFERENCE TILE ======
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
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
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isDark
                                ? [const Color(0xFF38BDF8), const Color(0xFF6366F1)]
                                : [AppColors.gold, AppColors.peach],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      title: Text(
                        'Appearance: ${isDark ? "Dark Theme" : "Light Theme"}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.navyInk,
                        ),
                      ),
                      subtitle: Text(
                        isDark ? 'Tap to switch to Light Ivory Mode' : 'Tap to switch to Midnight Obsidian Mode',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.navyLight,
                        ),
                      ),
                      trailing: Switch.adaptive(
                        value: isDark,
                        activeThumbColor: AppColors.darkCoral,
                        onChanged: (_) {
                          toggleAppTheme();
                          setState(() {});
                        },
                      ),
                      onTap: () {
                        toggleAppTheme();
                        setState(() {});
                      },
                    ),
                  ),

                  // ====== PROJECT DETAILS ======
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppColors.creamAccent),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.navyInk.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.coral, AppColors.peach],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.school_rounded, color: Colors.white, size: 22),
                      ),
                      title: const Text(
                        'Academic Project Details',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.navyInk),
                      ),
                      subtitle: const Text(
                        'COMSATS University • Sir Yousaf Khan',
                        style: TextStyle(fontSize: 11, color: AppColors.navyLight),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.coralLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.coral),
                      ),
                      onTap: () => _showAboutProject(context),
                    ),
                  ),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== HERO HEADER ====================
  Widget _buildHeroHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 60, 22, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A2238), Color(0xFF101830), Color(0xFF0D1220)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: Column(
        children: [
          // Top bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'THE EXPLORER ✦',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'LEVEL $_level',
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          // Avatar + Progress Ring
          Stack(
            alignment: Alignment.center,
            children: [
              // Progress ring
              SizedBox(
                width: 100,
                height: 100,
                child: CustomPaint(
                  painter: _ProgressRingPainter(
                    progress: _collected / 9.0,
                    color: AppColors.coral,
                    bgColor: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ),
              // Avatar
              Container(
                width: 82,
                height: 82,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.coral, AppColors.peach, AppColors.gold],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.coral.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.travel_explore_rounded, color: Colors.white, size: 42),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Name
          const Text(
            'Explorer',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),

          // Title badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.coral.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              _explorerTitle,
              style: const TextStyle(
                color: AppColors.coral,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Bio
          Text(
            'Collecting stories, not miles ✦',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.65),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$_collected of 9 countries explored',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== STATS ROW ====================
  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard('$_collected', 'Countries\nExplored', AppColors.coral, Icons.flag_rounded),
        const SizedBox(width: 8),
        _buildStatCard('$_totalCities', 'Total\nCities', AppColors.sky, Icons.location_city_rounded),
        const SizedBox(width: 8),
        _buildStatCard('${widget.postcards.length}', 'Postcards\nCreated', AppColors.peach, Icons.mail_rounded),
        const SizedBox(width: 8),
        _buildStatCard('${_collected * 5}', 'Explorer\nXP', AppColors.gold, Icons.star_rounded),
      ],
    );
  }

  Widget _buildStatCard(String count, String label, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.15)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            const SizedBox(height: 6),
            Text(
              count,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: AppColors.navyLight,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== ACHIEVEMENTS ====================
  Widget _buildAchievementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Achievement Badges',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.navyInk),
            ),
            Text(
              '${widget.badges.where((b) => b.isUnlocked).length} / ${widget.badges.length} earned',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.coral),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.badges.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final badge = widget.badges[index];
              return Container(
                width: 100,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: badge.isUnlocked
                        ? badge.color.withValues(alpha: 0.4)
                        : AppColors.creamAccent,
                    width: badge.isUnlocked ? 1.5 : 1.0,
                  ),
                  boxShadow: badge.isUnlocked
                      ? [BoxShadow(color: badge.color.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 3))]
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      badge.icon,
                      color: badge.isUnlocked ? badge.color : AppColors.navyLight.withValues(alpha: 0.4),
                      size: 24,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      badge.title,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
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
      ],
    );
  }

  // ==================== TAB: POSTCARDS ====================
  Widget _buildPostcardsTab() {
    if (widget.postcards.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.coralLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.mail_outline_rounded, size: 36, color: AppColors.coral),
            ),
            const SizedBox(height: 12),
            const Text('No postcards yet', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.navyInk)),
            const SizedBox(height: 4),
            const Text('Create memories from your journeys', style: TextStyle(color: AppColors.navyLight, fontSize: 12)),
            const SizedBox(height: 12),
            TextButton(
              onPressed: widget.onNavigateToExplore,
              child: const Text('Create your first postcard ➔', style: TextStyle(color: AppColors.coral, fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.postcards.length,
      separatorBuilder: (context, index) => const SizedBox(width: 14),
      itemBuilder: (context, index) {
        final card = widget.postcards[index];
        // Slight rotation for polaroid feel
        final angle = (index % 2 == 0 ? 1.0 : -1.0) * 0.02;
        return Transform.rotate(
          angle: angle,
          child: GestureDetector(
            onTap: () => _showPostcardModal(context, card),
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navyInk.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(2, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo area with border feel
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        card.imageUrl,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${card.countryEmoji} ${card.countryName}',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.navyInk),
                            ),
                            Text(card.stickerIcon, style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          card.message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10, color: AppColors.navyLight, fontStyle: FontStyle.italic, height: 1.3),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '— ${card.sender}',
                          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.coral),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ==================== TAB: WISHLIST ====================
  Widget _buildWishlistTab(List<Country> bookmarked) {
    if (bookmarked.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lavenderLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.bookmark_border_rounded, size: 36, color: AppColors.lavender),
            ),
            const SizedBox(height: 12),
            const Text('No saved countries', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.navyInk)),
            const SizedBox(height: 4),
            const Text('Bookmark countries while exploring', style: TextStyle(color: AppColors.navyLight, fontSize: 12)),
            const SizedBox(height: 12),
            TextButton(
              onPressed: widget.onNavigateToExplore,
              child: const Text('Explore countries ➔', style: TextStyle(color: AppColors.coral, fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: bookmarked.length,
      separatorBuilder: (context, index) => const SizedBox(width: 12),
      itemBuilder: (context, index) {
        final c = bookmarked[index];
        return Container(
          width: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: c.primaryColor.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: c.primaryColor.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Country banner mini
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                child: Image.network(
                  c.bannerImageUrl,
                  height: 90,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(c.flagEmoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(height: 6),
              Text(
                c.name,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.navyInk),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bookmark_rounded, color: AppColors.coral, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    '${c.cities.length} Cities',
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.navyLight),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ==================== TAB: WORLD TOUR ====================
  Widget _buildWorldTourTab() {
    return ListView.separated(
      itemCount: widget.countries.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final c = widget.countries[index];
        final explored = c.isStampCollected;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: explored ? AppColors.mint.withValues(alpha: 0.3) : AppColors.creamAccent,
            ),
          ),
          child: Row(
            children: [
              Text(c.flagEmoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.name,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.navyInk),
                    ),
                    Text(
                      '${c.cities.length} cities • ${c.foods.length} dishes • ${c.phrases.length} phrases',
                      style: const TextStyle(fontSize: 10, color: AppColors.navyLight),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: explored ? AppColors.mintLight : AppColors.coralLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  explored ? 'EXPLORED ✓' : 'READY',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: explored ? AppColors.mint : AppColors.coral,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Circular progress ring painter for the avatar
class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color bgColor;

  _ProgressRingPainter({
    required this.progress,
    required this.color,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    const strokeWidth = 4.0;

    // Background ring
    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
