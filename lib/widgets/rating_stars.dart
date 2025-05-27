import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;

  const RatingStars({Key? key, required this.rating, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: const Color.fromARGB(255, 201, 138, 12), size: size);
        } else if (index < rating) {
          return Icon(Icons.star_half, color: const Color.fromARGB(255, 204, 137, 13), size: size);
        } else {
          return Icon(Icons.star_border, color: const Color.fromARGB(255, 215, 150, 8), size: size);
        }
      }),
    );
  }
}