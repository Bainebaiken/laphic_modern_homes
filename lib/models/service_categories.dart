import 'package:flutter/material.dart';

class ServiceCategory {
  final String title;
  final IconData icon;
  final Widget screen;
  final String imagePath;
  final double rating;
  final String description;
  final bool isPopular;

  ServiceCategory({
    required this.title,
    required this.icon,
    required this.screen,
    required this.imagePath,
    required this.rating,
    required this.description,
    required this.isPopular,
  });
}