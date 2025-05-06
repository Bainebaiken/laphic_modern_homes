import 'package:flutter/material.dart';
import 'package:laphic_app/booking.dart';

class ServiceDetailPage extends StatelessWidget {
  final String title;

  const ServiceDetailPage({Key? key, required this.title}) : super(key: key);

  // Sample images for carousel based on service type
  List<String> _getServiceImages(String service) {
    switch (service) {
      case "Construction":
        return ["assets/construction1.jpg", "assets/construction2.jpg"];
      case "Painting":
        return ["assets/painting1.jpg", "assets/painting2.jpg"];
      case "Furniture":
        return ["assets/furniture1.jpg", "assets/furniture2.jpg"];
      case "Compound Design":
        return ["assets/compound1.jpg", "assets/compound2.jpg"];
      case "Interior Design":
        return ["assets/interior1.jpg", "assets/interior2.jpg"];
      case "Gypsum Work":
        return ["assets/gypsum1.jpg", "assets/gypsum2.jpg"];
      case "Metal Fabrication":
        return ["assets/metal1.jpg", "assets/metal2.jpg"];
      default:
        return ["assets/cleaning.jpg"];
    }
  }

  String _getServiceDescription(String service) {
    switch (service) {
      case "Construction":
        return "We provide top-notch construction services with high-quality materials and expert craftsmanship.";
      case "Painting":
        return "Brighten up your space with our professional painting services for both interior and exterior walls.";
      case "Furniture":
        return "Custom-made furniture to match your style and comfort needs, crafted with precision.";
      case "Compound Design":
        return "Transform your outdoor space with our creative compound and landscaping designs.";
      case "Interior Design":
        return "Elegant and functional interior design solutions tailored to your space and taste.";
      case "Gypsum Work":
        return "High-quality gypsum ceiling and partition works for modern spaces.";
      case "Metal Fabrication":
        return "Reliable metal fabrication for gates, windows, staircases, and custom structures.";
      default:
        return "Explore our professional service tailored to your needs.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = _getServiceImages(title);
    final description = _getServiceDescription(title);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF080F2B),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageCarousel(images),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BookingScreen()),
                  );
                },
                icon: const Icon(Icons.book),
                label: const Text("Book Now"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel(List<String> images) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(images[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
