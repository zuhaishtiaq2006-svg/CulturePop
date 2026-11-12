import 'package:flutter/material.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';
import '../utils/map_helper.dart';
import '../widgets/app_network_image.dart';
import 'city_detail_screen.dart';

class CitiesScreen extends StatefulWidget {
  final Country country;

  const CitiesScreen({super.key, required this.country});

  @override
  State<CitiesScreen> createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  String _searchQuery = '';

  List<City> get _filteredCities {
    if (_searchQuery.trim().isEmpty) return widget.country.cities;
    return widget.country.cities.where((city) {
      return city.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          city.landmark.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          city.famousFor.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _navigateToCityDetail(City city) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CityDetailScreen(
          city: city,
          country: widget.country,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = _filteredCities;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : AppColors.navyInk,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Text(
              widget.country.flagEmoji,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Cities & Famous Places',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : AppColors.navyInk,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined, color: AppColors.coral, size: 24),
            tooltip: 'View in Google Maps',
            onPressed: () {
              MapHelper.openMap(query: widget.country.name);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              height: 44,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : const Color(0xFFE2E8F0),
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
              child: TextField(
                onChanged: (val) => setState(() => _searchQuery = val),
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white : AppColors.navyInk,
                ),
                decoration: InputDecoration(
                  hintText: 'Search city, landmark or sights…',
                  hintStyle: TextStyle(
                    color: AppColors.getSubtext(context),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.getSubtext(context),
                    size: 19,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),

            // Cities List matching screenshot
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              separatorBuilder: (context, index) => const SizedBox(height: 18),
              itemBuilder: (context, index) {
                final city = list[index];

                return Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkCardBorder
                          : const Color(0xFFE2E8F0),
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withValues(alpha: 0.3)
                            : AppColors.navyInk.withValues(alpha: 0.06),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Image with badges & overlay
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 195,
                              width: double.infinity,
                              child: AppNetworkImage(
                                imageUrl: city.imageUrl,
                                fit: BoxFit.cover,
                                placeholderLabel: city.name,
                              ),
                            ),

                            // Dark gradient overlay for text readability
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withValues(alpha: 0.35),
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.88),
                                    ],
                                    stops: const [0.0, 0.45, 1.0],
                                  ),
                                ),
                              ),
                            ),

                            // Top Left Landmark Badge
                            Positioned(
                              top: 12,
                              left: 12,
                              right: 70,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.65),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text(
                                    city.landmark,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Top Right Rating Badge
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.15),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Color(0xFFF59E0B),
                                      size: 15,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      city.rating.toString(),
                                      style: const TextStyle(
                                        color: AppColors.navyInk,
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Bottom Left City Name & Famous for
                            Positioned(
                              left: 16,
                              right: 16,
                              bottom: 12,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    city.name,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Famous for: ${city.famousFor}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withValues(alpha: 0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Card Body
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              city.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.5,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : const Color(0xFF475569),
                                height: 1.45,
                              ),
                            ),

                            // Key Sights Badges with Red Pin
                            if (city.keySights.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: city.keySights.take(3).map((sight) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? const Color(0xFF1E293B)
                                          : const Color(0xFFF1F5F9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('📍', style: TextStyle(fontSize: 11)),
                                        const SizedBox(width: 5),
                                        Flexible(
                                          child: Text(
                                            sight,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 11.5,
                                              fontWeight: FontWeight.w700,
                                              color: isDark
                                                  ? Colors.white70
                                                  : const Color(0xFF1E293B),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],

                            // Action Buttons Row (Explore + Map)
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                // Red Explore Button
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 46,
                                    child: ElevatedButton.icon(
                                      onPressed: () => _navigateToCityDetail(city),
                                      icon: const Icon(
                                        Icons.explore_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      label: Text(
                                        'Explore ',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFC52828),
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),

                                // White Map Button
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 46,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        MapHelper.openMap(
                                          query: city.name,
                                          contextCountry: widget.country.name,
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: isDark
                                            ? AppColors.darkCard
                                            : Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 4),
                                        side: BorderSide(
                                          color: isDark
                                              ? AppColors.darkCardBorder
                                              : const Color(0xFFCBD5E1),
                                          width: 1.2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.map_rounded,
                                            color: Color(0xFFE63946),
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              'Map 📍',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: isDark
                                                    ? Colors.white
                                                    : AppColors.navyInk,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
