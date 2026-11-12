import 'package:flutter/material.dart';
import '../models/country.dart';
import '../theme/app_theme.dart';

class PostcardStudioScreen extends StatefulWidget {
  final Country country;

  const PostcardStudioScreen({super.key, required this.country});

  @override
  State<PostcardStudioScreen> createState() => _PostcardStudioScreenState();
}

class _PostcardStudioScreenState extends State<PostcardStudioScreen> {
  late String _selectedImage;
  late String _selectedStamp;
  String _selectedSticker = '🌸';
  String _message = 'Wish you were here! A little memory from this beautiful world.';
  int _selectedFilter = 0;
  final TextEditingController _msgController = TextEditingController();

  final List<String> _stickers = ['🌸', '🍜', '⛩️', '🏮', '🍕', '☕', '🎈', '🍵', '✨', '✈️', '🥐', '🏖️', '🍇'];
  final List<String> _filterNames = ['Original', 'Vintage Warm', 'Golden Hour', 'Cool Mist'];

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.country.bannerImageUrl;
    _selectedStamp = '${widget.country.name.toUpperCase()} · 85';
    _msgController.text = _message;
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  void _editMessageDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDark ? AppColors.darkCard : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(
            'Write Your Postcard Message',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColors.getText(context),
            ),
          ),
          content: TextField(
            controller: _msgController,
            maxLines: 4,
            style: TextStyle(fontSize: 13, color: AppColors.getText(context)),
            decoration: InputDecoration(
              hintText: 'Wish you were here!…',
              hintStyle: TextStyle(color: AppColors.getSubtext(context)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
                ),
              ),
              filled: true,
              fillColor: isDark
                  ? AppColors.darkCardBorder
                  : AppColors.creamAccent.withValues(alpha: 0.3),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: AppColors.getSubtext(context))),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _message = _msgController.text.trim();
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.coral,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              child: const Text('Apply Message'),
            ),
          ],
        );
      },
    );
  }

  ColorFilter? _getFilter() {
    switch (_selectedFilter) {
      case 1: // Vintage Warm
        return ColorFilter.mode(Colors.amber.withValues(alpha: 0.2), BlendMode.colorBurn);
      case 2: // Golden Hour
        return ColorFilter.mode(Colors.orange.withValues(alpha: 0.25), BlendMode.overlay);
      case 3: // Cool Mist
        return ColorFilter.mode(Colors.cyan.withValues(alpha: 0.18), BlendMode.softLight);
      default:
        return null;
    }
  }

  void _savePostcard() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Text('💌', style: TextStyle(fontSize: 22)),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Postcard saved to your Profile Memories gallery!',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.mint,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

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
          'Postcard Studio',
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
              '${widget.country.name.toUpperCase()} / THE POSTCARD STUDIO',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: widget.country.primaryColor,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Send a Little Memory',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: AppColors.getText(context),
              ),
            ),
            const SizedBox(height: 16),

            // Postcard Live Visual Canvas
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: isDark ? AppColors.darkCardBorder : AppColors.creamAccent,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.3)
                        : AppColors.navyInk.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Scenic Backdrop Image with Filter
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    child: SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: _getFilter() != null
                          ? ColorFiltered(
                              colorFilter: _getFilter()!,
                              child: Image.network(_selectedImage, fit: BoxFit.cover),
                            )
                          : Image.network(_selectedImage, fit: BoxFit.cover),
                    ),
                  ),
                  // Postcard Message & Stamp Region
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Message & Signature
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _message,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.getText(context),
                                  height: 1.45,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Text(
                                    _selectedSticker,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '— Alex Morgan',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.coral,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Postal Stamp Mark
                        Container(
                          width: 74,
                          height: 86,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkCardBorder
                                : AppColors.coralLight,
                            border: Border.all(color: AppColors.coral, width: 1.5),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.country.flagEmoji,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _selectedStamp,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.coral,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '〰️ AIRMAIL 〰️',
                                style: TextStyle(
                                  fontSize: 5,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.getSubtext(context),
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
            ),

            const SizedBox(height: 22),

            // Controls 1: Photo Color Filter
            Text(
              'Photo Mood & Filter',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.getText(context),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filterNames.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilter == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = index),
                    child: Container(
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
                          _filterNames[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : (isDark ? AppColors.darkTextSecondary : AppColors.navyInk),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            // Controls 2: Scenic Background Image Choice
            Text(
              'Select City Scene',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.getText(context),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.country.cities.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final city = widget.country.cities[index];
                  final isSelected = _selectedImage == city.imageUrl;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedImage = city.imageUrl),
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppColors.coral : Colors.transparent,
                          width: 2.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(city.imageUrl, fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            // Controls 3: Sticker Choice
            Text(
              'Add Cultural Sticker',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.getText(context),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _stickers.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final s = _stickers[index];
                  final isSelected = _selectedSticker == s;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedSticker = s),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark ? AppColors.darkCardBorder : AppColors.coralLight)
                            : (isDark ? AppColors.darkCard : Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? AppColors.coral : (isDark ? AppColors.darkCardBorder : AppColors.creamAccent),
                        ),
                      ),
                      child: Center(
                        child: Text(s, style: const TextStyle(fontSize: 22)),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 22),

            // Controls 4: Edit Message Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: _editMessageDialog,
                icon: const Icon(Icons.edit_note_rounded, size: 20),
                label: const Text('Edit Postcard Message'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.getText(context),
                  side: BorderSide(
                    color: isDark ? AppColors.darkTextSecondary : AppColors.navyInk,
                    width: 1.2,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Primary Save Action
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: _savePostcard,
                icon: const Icon(Icons.send_rounded, size: 20),
                label: const Text(
                  'SAVE & SHARE POSTCARD',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.0),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.coral,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                  elevation: 3,
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
