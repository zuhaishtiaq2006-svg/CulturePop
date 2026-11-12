import 'package:flutter/material.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';

class TraditionsScreen extends StatelessWidget {
  final Country country;

  const TraditionsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
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
          '${country.name} Traditions',
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
            // Eyebrow
            Text(
              '${country.name.toUpperCase()} / EVERYDAY MEANING',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: country.primaryColor,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Discover Traditions',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: AppColors.getText(context),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'The beauty of everyday rituals and deep customs that shape a culture.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.getSubtext(context),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 22),

            // Tradition cards
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: country.traditions.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final tradition = country.traditions[index];
                return _buildTraditionCard(tradition, index, context, isDark);
              },
            ),

            const SizedBox(height: 24),

            // Bottom wisdom card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkCard
                    : AppColors.creamAccent.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: AppColors.coral, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Traditions are windows into a culture\'s soul. Observe with curiosity and respect.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.getSubtext(context),
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTraditionCard(Tradition tradition, int index, BuildContext context, bool isDark) {
    final colors = [AppColors.coral, AppColors.mint, AppColors.lavender, AppColors.sky, AppColors.peach, AppColors.gold];
    final accentColor = colors[index % colors.length];

    return Container(
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
                : AppColors.navyInk.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and gradient accent
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        accentColor.withValues(alpha: 0.15),
                        AppColors.darkCard,
                      ]
                    : [
                        accentColor.withValues(alpha: 0.1),
                        Colors.white,
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(tradition.icon, color: accentColor, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tradition.subtitle.toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: accentColor,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tradition.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: AppColors.getText(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 6, 18, 14),
            child: Text(
              tradition.description,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? AppColors.darkTextSecondary : AppColors.navySoft,
                height: 1.55,
              ),
            ),
          ),

          // "Did You Know?" golden card
          Container(
            margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        const Color(0xFF2A200F),
                        const Color(0xFF1E160A),
                      ]
                    : [
                        const Color(0xFFFEF3C7),
                        const Color(0xFFFFF8E1),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark ? const Color(0xFF5B3F11) : AppColors.gold.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('✨', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 6),
                    Text(
                      'DID YOU KNOW?',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: isDark ? const Color(0xFFFBBF24) : const Color(0xFFB45309),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  tradition.didYouKnow,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? const Color(0xFFFDE68A) : AppColors.navyInk,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),

          // Do's and Don'ts
          if (tradition.dosAndDonts.isNotEmpty)
            Container(
              margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF133B34) : AppColors.mintLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.tips_and_updates_rounded, size: 18, color: AppColors.mint),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ETIQUETTE TIP',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: AppColors.mint,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tradition.dosAndDonts,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? const Color(0xFF99F6E4) : AppColors.navyInk,
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
