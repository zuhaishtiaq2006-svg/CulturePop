import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';

class PhrasesScreen extends StatefulWidget {
  final Country country;

  const PhrasesScreen({super.key, required this.country});

  @override
  State<PhrasesScreen> createState() => _PhrasesScreenState();
}

class _PhrasesScreenState extends State<PhrasesScreen> {
  PhraseCategory? _selectedCategory;
  int _speakingIndex = -1;

  List<Phrase> get _filteredPhrases {
    if (_selectedCategory == null) return widget.country.phrases;
    return widget.country.phrases.where((p) => p.category == _selectedCategory).toList();
  }

  String _categoryLabel(PhraseCategory? cat) {
    if (cat == null) return 'All';
    switch (cat) {
      case PhraseCategory.greetings: return '👋 Greetings';
      case PhraseCategory.dining: return '🍽️ Dining';
      case PhraseCategory.directions: return '🧭 Directions';
      case PhraseCategory.shopping: return '🛍️ Shopping';
      case PhraseCategory.emergency: return '🚨 Emergency';
    }
  }

  void _simulateSpeak(int index) {
    setState(() => _speakingIndex = index);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _speakingIndex = -1);
    });
  }

  void _copyPhrase(Phrase phrase) {
    Clipboard.setData(ClipboardData(text: '${phrase.nativeScript} (${phrase.phonetic})'));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied: ${phrase.nativeScript}'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? AppColors.darkCard : AppColors.navyInk,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = _filteredPhrases;
    final categories = [null, ...PhraseCategory.values];
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
          'Speak ${widget.country.name}',
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
              '${widget.country.name.toUpperCase()} / PHRASEBOOK',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: widget.country.primaryColor,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Little Connections',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: AppColors.getText(context),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Small words make warm connections. Learn key phrases for your journey.',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.getSubtext(context),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            // Category filter
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark ? AppColors.coral : AppColors.navyInk)
                            : (isDark ? AppColors.darkCard : Colors.white),
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(
                          color: isSelected
                              ? (isDark ? AppColors.coral : AppColors.navyInk)
                              : (isDark ? AppColors.darkCardBorder : AppColors.creamAccent),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _categoryLabel(cat),
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : (isDark ? AppColors.darkTextSecondary : AppColors.navyLight),
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),
            Text(
              '${list.length} phrases',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.coral),
            ),
            const SizedBox(height: 14),

            // Phrases list
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final phrase = list[index];
                final isSpeaking = _speakingIndex == index;
                return _buildPhraseCard(phrase, index, isSpeaking, isDark);
              },
            ),

            const SizedBox(height: 24),

            // Tip card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2A200F)
                    : AppColors.goldLight.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isDark ? const Color(0xFF5B3F11) : AppColors.gold.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Text('💡', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TRAVEL TIP',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: isDark ? const Color(0xFFFBBF24) : const Color(0xFFB45309),
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Locals always appreciate when tourists try to speak their language, even imperfectly. A smile with a simple greeting goes a long way!',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.getText(context),
                            height: 1.45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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

  Widget _buildPhraseCard(Phrase phrase, int index, bool isSpeaking, bool isDark) {
    Color categoryColor;
    switch (phrase.category) {
      case PhraseCategory.greetings: categoryColor = AppColors.mint; break;
      case PhraseCategory.dining: categoryColor = AppColors.peach; break;
      case PhraseCategory.directions: categoryColor = AppColors.sky; break;
      case PhraseCategory.shopping: categoryColor = AppColors.lavender; break;
      case PhraseCategory.emergency: categoryColor = AppColors.coral; break;
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isSpeaking
              ? widget.country.primaryColor.withValues(alpha: 0.5)
              : (isDark ? AppColors.darkCardBorder : AppColors.creamAccent),
          width: isSpeaking ? 2.0 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.25)
                : AppColors.navyInk.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: category badge + actions
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  phrase.category.name.toUpperCase(),
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: categoryColor, letterSpacing: 0.5),
                ),
              ),
              const Spacer(),
              // Speaker button
              GestureDetector(
                onTap: () => _simulateSpeak(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSpeaking
                        ? widget.country.primaryColor
                        : (isDark
                            ? AppColors.darkCardBorder
                            : widget.country.primaryColor.withValues(alpha: 0.1)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isSpeaking ? Icons.volume_up_rounded : Icons.volume_up_outlined,
                    size: 18,
                    color: isSpeaking ? Colors.white : widget.country.primaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Copy button
              GestureDetector(
                onTap: () => _copyPhrase(phrase),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.copy_rounded,
                    size: 16,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.navyLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // English phrase
          Text(
            phrase.english,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.getText(context),
            ),
          ),
          const SizedBox(height: 8),

          // Native script (large, prominent)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.country.primaryColor.withValues(alpha: 0.08),
                  widget.country.accentColor.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              phrase.nativeScript,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: widget.country.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Phonetic pronunciation bubble
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF133B34) : AppColors.mintLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🗣️', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 6),
                Text(
                  phrase.phonetic,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isDark ? const Color(0xFF5EEAD4) : AppColors.mint,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          if (phrase.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              phrase.description,
              style: TextStyle(
                fontSize: 11,
                color: isDark ? AppColors.darkTextSecondary : AppColors.navyLight,
                height: 1.4,
              ),
            ),
          ],

          if (phrase.politenessTip.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💎', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    phrase.politenessTip,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.navySoft,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
