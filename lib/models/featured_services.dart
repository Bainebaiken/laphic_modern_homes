class FeaturedService {
  final String title;
  final String imagePath;
  final String price;
  final double rating;
  final String duration;
  final String serviceType;
  final int discount;
  final int reviewCount;

  FeaturedService({
    required this.title,
    required this.imagePath,
    required this.price,
    required this.rating,
    required this.duration,
    required this.serviceType,
    required this.discount,
    required this.reviewCount,
  });
}