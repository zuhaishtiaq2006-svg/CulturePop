import 'package:flutter/material.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';
import '../utils/map_helper.dart';
import '../widgets/app_network_image.dart';

class CityDetailScreen extends StatefulWidget {
  final City city;
  final Country country;

  const CityDetailScreen({
    super.key,
    required this.city,
    required this.country,
  });

  @override
  State<CityDetailScreen> createState() => _CityDetailScreenState();
}

class _CityDetailScreenState extends State<CityDetailScreen> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final city = widget.city;
    final country = widget.country;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Collapsible Image App Bar with Hero Visual
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: isDark ? AppColors.darkBackground : AppColors.navyInk,
            iconTheme: const IconThemeData(color: Colors.white),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                  child: IconButton(
                    icon: const Icon(Icons.map_rounded, color: Colors.white, size: 20),
                    tooltip: 'Open in Google Maps',
                    onPressed: () {
                      MapHelper.openMap(
                        query: city.name,
                        contextCountry: country.name,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                  child: IconButton(
                    icon: Icon(
                      _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                      color: _isBookmarked ? AppColors.coral : Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isBookmarked = !_isBookmarked;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _isBookmarked
                                ? '🌟 ${city.name} added to your Travel Wishlist!'
                                : '${city.name} removed from Wishlist',
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: isDark ? AppColors.darkCard : AppColors.navyInk,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(
                    imageUrl: city.imageUrl,
                    fit: BoxFit.cover,
                    placeholderLabel: city.name,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.9),
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
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
                                '${country.flagEmoji} ${country.name.toUpperCase()}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.95),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star_rounded, color: AppColors.gold, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    city.rating.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 12,
                                      color: AppColors.navyInk,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          city.name,
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.place_rounded, color: AppColors.coral, size: 16),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                city.landmark,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white70,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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

          // City Explorer Details Body - Deep Educational Travel Guide
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. City Story & Essence
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withValues(alpha: 0.25)
                              : AppColors.navyInk.withValues(alpha: 0.04),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.darkCardBorder : AppColors.coralLight,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.auto_stories_rounded, color: AppColors.coral, size: 18),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'CITY ESSENCE & STORY',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: AppColors.coral,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          city.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.navySoft,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.darkCardBorder : AppColors.warmCream,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.wb_sunny_rounded, color: AppColors.gold, size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Prime Travel Season: ${city.bestTimeToVisit}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.getText(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // 2. Popular Places / Highlights Gallery if available
                  if (city.popularPlaces.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Famous Landmarks in ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: AppColors.getText(context),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${city.popularPlaces.length} Spots',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.coral,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 285,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: city.popularPlaces.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 14),
                        itemBuilder: (context, index) {
                          final place = city.popularPlaces[index];
                          return Container(
                            width: 250,
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkCard : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isDark
                                      ? Colors.black.withValues(alpha: 0.3)
                                      : AppColors.navyInk.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                  child: SizedBox(
                                    height: 120,
                                    width: double.infinity,
                                    child: AppNetworkImage(
                                      imageUrl: place.imageUrl,
                                      fit: BoxFit.cover,
                                      placeholderLabel: place.name,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        place.name,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: AppColors.getText(context),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        place.category,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: country.primaryColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        place.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: isDark ? AppColors.darkTextSecondary : AppColors.navySoft,
                                          height: 1.3,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      // Dedicated Map button for this specific famous place
                                      SizedBox(
                                        width: double.infinity,
                                        height: 34,
                                        child: OutlinedButton.icon(
                                          onPressed: () {
                                            MapHelper.openMap(
                                              query: place.name,
                                              contextCountry: '${city.name}, ${country.name}',
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.map_rounded,
                                            color: Color(0xFFE63946),
                                            size: 15,
                                          ),
                                          label: const Text(
                                            'View on Map 📍',
                                            style: TextStyle(
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: isDark ? Colors.white : AppColors.navyInk,
                                            backgroundColor: isDark
                                                ? const Color(0xFF1E293B)
                                                : const Color(0xFFF8FAFC),
                                            side: BorderSide(
                                              color: isDark
                                                  ? AppColors.darkCardBorder
                                                  : const Color(0xFFCBD5E1),
                                              width: 1.0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 22),
                  ],

                  // 3. Neighborhood Vibe & Local Atmosphere
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [
                                const Color(0xFF132238),
                                const Color(0xFF0F172A),
                              ]
                            : [
                                AppColors.skyLight,
                                Colors.white,
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark ? const Color(0xFF1E3A5F) : AppColors.sky.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.nature_people_rounded,
                              color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E6091),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'NEIGHBORHOOD VIBE & ATMOSPHERE',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E6091),
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          city.neighborhoodVibe.isNotEmpty
                              ? city.neighborhoodVibe
                              : 'A captivating balance of deep historical tradition and vibrant, contemporary street culture.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.getText(context),
                            height: 1.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // 4. Must-See Iconic Sights (Checklist Style)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Must-See Iconic Sights',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: AppColors.getText(context),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${city.keySights.length} Highlights',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.coral,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (city.keySights.isNotEmpty)
                    ...city.keySights.map((sight) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.darkCard : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: country.primaryColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.museum_rounded, color: country.primaryColor, size: 20),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                sight,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.getText(context),
                                ),
                              ),
                            ),
                            const Icon(Icons.check_circle_outline_rounded,
                                color: AppColors.mint, size: 18),
                          ],
                        ),
                      );
                    })
                  else
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        city.famousFor,
                        style: TextStyle(color: AppColors.getText(context)),
                      ),
                    ),

                  const SizedBox(height: 22),

                  // 5. Local Secret & Hidden Gem (Golden Card)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [
                                const Color(0xFF2A200F),
                                const Color(0xFF1E160A),
                              ]
                            : [
                                AppColors.goldLight.withValues(alpha: 0.85),
                                AppColors.peachLight,
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark ? const Color(0xFF5B3F11) : AppColors.gold.withValues(alpha: 0.4),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gold.withValues(alpha: 0.1),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.key_rounded,
                              color: isDark ? const Color(0xFFFBBF24) : const Color(0xFFB45309),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'LOCAL SECRET & HIDDEN GEM',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: isDark ? const Color(0xFFFBBF24) : const Color(0xFFB45309),
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          city.localSecret.isNotEmpty
                              ? city.localSecret
                              : 'Venture into the quiet side streets away from major avenues to discover independent artisan workshops, family cafes, and authentic everyday life.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.getText(context),
                            height: 1.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // 6. How to Get Around & Transit Advice
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withValues(alpha: 0.2)
                              : AppColors.navyInk.withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.directions_subway_rounded,
                              color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF2B6CB0),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'NAVIGATING THE CITY',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF2B6CB0),
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          city.gettingAround.isNotEmpty
                              ? city.gettingAround
                              : 'Easily explored via public metro systems, local buses, and pedestrian friendly cobblestone corridors.',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.navySoft,
                            height: 1.5,
                          ),
                        ),
                        if (city.travelTip.isNotEmpty) ...[
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF132238) : AppColors.skyLight,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.tips_and_updates_rounded,
                                  size: 16,
                                  color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E6091),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Pro Travel Tip: ${city.travelTip}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF1E6091),
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // 7. Signature City Food Delicacies
                  if (city.topDishes.isNotEmpty) ...[
                    Text(
                      'Local Food Specials in this City',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.getText(context),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: city.topDishes.map((dish) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.darkCard : AppColors.coralLight,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDark ? AppColors.darkCardBorder : AppColors.coral.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('🍽️', style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 6),
                              Text(
                                dish,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.getText(context),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 26),
                  ],

                  // 8. Action Button: Save to Travel Wishlist
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isBookmarked = !_isBookmarked;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _isBookmarked
                                  ? '🌟 ${city.name} saved to your World Tour journal!'
                                  : 'Removed ${city.name} from journal',
                            ),
                            backgroundColor: AppColors.coral,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        );
                      },
                      icon: Icon(
                        _isBookmarked ? Icons.bookmark_added_rounded : Icons.bookmark_add_rounded,
                        size: 20,
                      ),
                      label: Text(
                        _isBookmarked ? 'SAVED TO MY WORLD TOUR' : 'ADD TO MY TRAVEL WISHLIST',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isBookmarked ? AppColors.mint : AppColors.coral,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
