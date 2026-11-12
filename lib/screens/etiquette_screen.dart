import 'package:flutter/material.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';

class EtiquetteScreen extends StatefulWidget {
  final Country country;

  const EtiquetteScreen({super.key, required this.country});

  @override
  State<EtiquetteScreen> createState() => _EtiquetteScreenState();
}

class _EtiquetteScreenState extends State<EtiquetteScreen> {
  String _selectedCategory = 'All';

  List<String> get _categories {
    final set = <String>{'All'};
    for (var item in widget.country.etiquette) {
      set.add(item.category);
    }
    return set.toList();
  }

  List<EtiquetteItem> get _filteredList {
    if (_selectedCategory == 'All') return widget.country.etiquette;
    return widget.country.etiquette
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final country = widget.country;
    final list = _filteredList;
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
          '${country.flagEmoji} Cultural Etiquette & Manners',
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
            // Intro Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : null,
                gradient: isDark
                    ? null
                    : LinearGradient(
                        colors: [
                          country.primaryColor.withValues(alpha: 0.12),
                          country.accentColor.withValues(alpha: 0.08),
                        ],
                      ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? AppColors.darkCardBorder
                      : country.primaryColor.withValues(alpha: 0.25),
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: country.primaryColor,
                    child: const Icon(Icons.handshake_rounded, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Travel Like a Respectful Local',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: AppColors.getText(context),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Understanding local taboos, dining manners and social cues earns warm smiles anywhere.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.getSubtext(context),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Category Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: country.primaryColor,
                      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppColors.getText(context),
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                        fontSize: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isSelected
                              ? country.primaryColor
                              : (isDark ? AppColors.darkCardBorder : AppColors.slate200),
                        ),
                      ),
                      onSelected: (val) {
                        if (val) setState(() => _selectedCategory = cat);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 18),

            // Rules List
            if (list.isEmpty)
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: Text(
                    'No etiquette guidelines found for this category.',
                    style: TextStyle(color: AppColors.getSubtext(context)),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = list[index];
                  return Container(
                    decoration: AppDecorations.modernCard(context: context),
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: isDark
                                  ? AppColors.darkCardBorder
                                  : AppColors.slate100,
                              child: Icon(item.icon, size: 18, color: country.primaryColor),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.getText(context),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.darkCardBorder : AppColors.slate100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                item.category,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.getSubtext(context),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // DO Box
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF133B34)
                                : AppColors.emeraldLight.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.emerald.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('✅', style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? const Color(0xFFCCFBF1) : AppColors.navyInk,
                                      height: 1.4,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'ALWAYS DO: ',
                                        style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.mint),
                                      ),
                                      TextSpan(text: item.doRule),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // DON'T Box
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF3B1A1A)
                                : AppColors.roseLight.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.rose.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('❌', style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? const Color(0xFFFFE4E6) : AppColors.navyInk,
                                      height: 1.4,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: 'NEVER DO: ',
                                        style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.rose),
                                      ),
                                      TextSpan(text: item.dontRule),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Why It Matters
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline_rounded, size: 14, color: AppColors.getSubtext(context)),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Why it matters: ${item.whyItMatters}',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.getSubtext(context),
                                  height: 1.35,
                                ),
                              ),
                            ),
                          ],
                        ),
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
