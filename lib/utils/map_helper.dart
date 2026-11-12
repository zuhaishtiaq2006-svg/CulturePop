import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class MapHelper {
  /// Opens Google Maps with a search query for the given city or place
  static Future<void> openMap({
    required String query,
    String contextCountry = '',
  }) async {
    final cleanQuery = contextCountry.trim().isNotEmpty
        ? '${query.trim()}, ${contextCountry.trim()}'
        : query.trim();

    final encoded = Uri.encodeComponent(cleanQuery);
    final mapUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encoded');

    try {
      final launched = await launchUrl(
        mapUri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        await launchUrl(mapUri, mode: LaunchMode.platformDefault);
      }
    } catch (_) {
      // Fallback for desktop platforms or when launchUrl has restrictions
      if (!kIsWeb && Platform.isWindows) {
        try {
          await Process.run('cmd', ['/c', 'start', '', mapUri.toString()]);
        } catch (_) {}
      }
    }
  }
}
