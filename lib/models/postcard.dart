class Postcard {
  final String id;
  final String countryName;
  final String countryEmoji;
  final String imageUrl;
  final String stampTitle;
  final String stickerIcon;
  final String message;
  final String sender;
  final DateTime date;

  const Postcard({
    required this.id,
    required this.countryName,
    required this.countryEmoji,
    required this.imageUrl,
    required this.stampTitle,
    required this.stickerIcon,
    required this.message,
    required this.sender,
    required this.date,
  });
}
