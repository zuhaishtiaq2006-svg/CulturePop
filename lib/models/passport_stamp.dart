import 'package:flutter/material.dart';

class PassportStamp {
  final String countryId;
  final String countryName;
  final String flagEmoji;
  final String sealText;
  final DateTime dateEarned;
  final Color sealColor;

  const PassportStamp({
    required this.countryId,
    required this.countryName,
    required this.flagEmoji,
    required this.sealText,
    required this.dateEarned,
    required this.sealColor,
  });
}

class ExplorerBadge {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  bool isUnlocked;

  ExplorerBadge({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.isUnlocked = false,
  });
}
