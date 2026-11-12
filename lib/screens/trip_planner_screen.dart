import 'package:flutter/material.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';

class TripPlannerScreen extends StatefulWidget {
  final Country country;

  const TripPlannerScreen({super.key, required this.country});

  @override
  State<TripPlannerScreen> createState() => _TripPlannerScreenState();
}

class _TripPlannerScreenState extends State<TripPlannerScreen> {
  int _selectedDuration = 3; // 3 or 7 days
  final Set<String> _completedItems = {};

  List<Map<String, dynamic>> _getItinerary(int days) {
    final country = widget.country;
    final cities = country.cities;
    final foods = country.foods;

    if (days == 3) {
      final city1 = cities.isNotEmpty ? cities[0] : null;
      final city2 = cities.length > 1 ? cities[1] : city1;
      return [
        {
          'day': 'Day 1',
          'title': 'Arrival & Historic Heart of ${city1?.name ?? country.capital}',
          'city': city1?.name ?? country.capital,
          'activities': [
            'Explore ${city1?.landmark ?? "Central Historic District"} at morning opening hours.',
            'Sample authentic ${foods.isNotEmpty ? foods[0].name : "local street food"} for lunch.',
            'Stroll through historic artisan alleys and capture golden hour photographs.',
          ],
        },
        {
          'day': 'Day 2',
          'title': 'Cultural Immersion & Local Traditions in ${city2?.name ?? country.name}',
          'city': city2?.name ?? country.name,
          'activities': [
            'Visit the premier heritage museum and iconic architectural monuments.',
            'Join an authentic traditional workshop or tea / culinary tasting.',
            'Evening stroll through the bustling night bazaar or cultural riverfront.',
          ],
        },
        {
          'day': 'Day 3',
          'title': 'Hidden Alleys, Crafts & Souvenir Hunting',
          'city': city1?.name ?? country.capital,
          'activities': [
            'Pick up handmade local souvenirs, woven textiles & traditional spices.',
            'Sunset dinner panoramic view celebrating your cultural discovery.',
            'Stamp your CulturePop Passport and save memory postcards.',
          ],
        },
      ];
    } else {
      // 7 Days Grand Tour
      return [
        {
          'day': 'Day 1',
          'title': 'Touchdown in ${country.capital} & Old Town Stroll',
          'city': country.capital,
          'activities': [
            'Arrive, settle into boutique heritage accommodations & relax.',
            'Orientation walking tour around ancient town squares.',
            'Welcome banquet tasting iconic signature starters and herbal drinks.',
          ],
        },
        {
          'day': 'Day 2',
          'title': 'Imperial Palaces, Temples & Grand Architecture',
          'city': country.capital,
          'activities': [
            'Guided morning exploration of royal historical complexes.',
            'Authentic culinary lunch featuring classic regional delicacies.',
            'Attend a live traditional music performance or folk dance recital.',
          ],
        },
        {
          'day': 'Day 3',
          'title': 'Scenic High-Speed Transit to ${cities.length > 1 ? cities[1].name : "Coast"}',
          'city': cities.length > 1 ? cities[1].name : 'Regional Countryside',
          'activities': [
            'Board scenic railway / transport across beautiful natural landscapes.',
            'Afternoon walk along historic harbor or mountainous trails.',
            'Seafood / local specialty dinner overlooking panoramic night lights.',
          ],
        },
        {
          'day': 'Day 4',
          'title': 'Artisan Masters, Ceramic Studios & Textiles',
          'city': cities.length > 1 ? cities[1].name : 'Regional Countryside',
          'activities': [
            'Hands-on workshop learning traditional craft from master artisans.',
            'Quiet picnic in a serene national park or classical garden.',
            'Sunset photography session at an iconic panoramic viewpoint.',
          ],
        },
        {
          'day': 'Day 5',
          'title': 'Adventure into ${cities.length > 2 ? cities[2].name : "Historical Valley"}',
          'city': cities.length > 2 ? cities[2].name : 'Ancient Province',
          'activities': [
            'Morning visit to UNESCO World Heritage archaeological ruins.',
            'Farm-to-table lunch at an organic vineyard or family farm.',
            'Stroll through vibrant evening street food night markets.',
          ],
        },
        {
          'day': 'Day 6',
          'title': 'Culinary Cooking Class & Hidden Neighborhoods',
          'city': cities.length > 2 ? cities[2].name : 'Ancient Province',
          'activities': [
            'Visit the bustling morning produce market with a local chef.',
            'Hands-on cooking masterclass making 3 traditional dishes.',
            'Evening stroll discovering indie bookstores, vinyl cafes & gelato.',
          ],
        },
        {
          'day': 'Day 7',
          'title': 'Grand Finale & Heartfelt Farewell',
          'city': country.capital,
          'activities': [
            'Last-minute artisan shopping for ceramics, textiles & tea.',
            'Grand farewell banquet dinner at a rooftop garden restaurant.',
            'Complete your CulturePop Quiz to test your travel mastery!',
          ],
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final country = widget.country;
    final itinerary = _getItinerary(_selectedDuration);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : AppColors.navyInk,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${country.flagEmoji} Smart Trip & Itinerary Planner',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: AppColors.getText(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Plan Switcher
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.slate200.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : Colors.transparent,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedDuration = 3),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedDuration == 3
                              ? (isDark ? AppColors.darkCardBorder : Colors.white)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: _selectedDuration == 3
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          '⚡ 3-Day Express Tour',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: _selectedDuration == 3 ? FontWeight.w900 : FontWeight.w600,
                            color: _selectedDuration == 3 ? country.primaryColor : AppColors.getSubtext(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedDuration = 7),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedDuration == 7
                              ? (isDark ? AppColors.darkCardBorder : Colors.white)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: _selectedDuration == 7
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          '🗺️ 7-Day Grand Explorer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: _selectedDuration == 7 ? FontWeight.w900 : FontWeight.w600,
                            color: _selectedDuration == 7 ? country.primaryColor : AppColors.getSubtext(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Progress Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [country.primaryColor, country.accentColor],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.checklist_rtl_rounded, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$_selectedDuration-Day Curated Itinerary',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Check off activities as you explore. ${_completedItems.length} activities completed!',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Days Cards
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itinerary.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final dayData = itinerary[index];
                final dayLabel = dayData['day'] as String;
                final dayTitle = dayData['title'] as String;
                final cityName = dayData['city'] as String;
                final activities = (dayData['activities'] as List<String>);

                return Container(
                  decoration: AppDecorations.modernCard(context: context),
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: country.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              dayLabel.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkCardBorder : AppColors.slate100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '📍 $cityName',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.getText(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        dayTitle,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: AppColors.getText(context),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Divider(height: 1, color: isDark ? Colors.white12 : AppColors.slate200),
                      const SizedBox(height: 12),
                      ...activities.map((act) {
                        final isDone = _completedItems.contains('$dayLabel-$act');
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                final key = '$dayLabel-$act';
                                if (isDone) {
                                  _completedItems.remove(key);
                                } else {
                                  _completedItems.add(key);
                                }
                              });
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  isDone ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                                  color: isDone ? AppColors.mint : (isDark ? AppColors.darkTextSecondary : AppColors.slate400),
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    act,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isDone
                                          ? (isDark ? AppColors.darkTextSecondary : AppColors.slate400)
                                          : AppColors.getText(context),
                                      decoration: isDone ? TextDecoration.lineThrough : null,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
