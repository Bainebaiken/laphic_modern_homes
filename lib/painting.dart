import 'package:flutter/material.dart';





class PaintingPage extends StatefulWidget {
  const PaintingPage({super.key});

  @override
  State<PaintingPage> createState() => _PaintingPageState();
}

class _PaintingPageState extends State<PaintingPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.grey[300],
        title: const Text(
          'painting ',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Container(
              margin: const EdgeInsets.all(10),
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/painting 1.jpg'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Title Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "painting ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Grid of Gypsum Designs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: gypsumDesigns.length,
                itemBuilder: (context, index) {
                  final design = gypsumDesigns[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Image Section
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.asset(
                            design['image']!,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Title and Price Section
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                design['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                design['price']!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      
    );
  }
}

// Gypsum Designs Data
final List<Map<String, String>> gypsumDesigns = [
  {
    "title": "Simple & Affordable",
    "price": "500,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Grey Lights",
    "price": "400,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Humble Lights",
    "price": "500,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Brown Design",
    "price": "300,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Blue Design",
    "price": "400,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Rectangle Design",
    "price": "300,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Grey Design",
    "price": "400,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Purple Design",
    "price": "400,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Circular Lights",
    "price": "400,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Deep Lights",
    "price": "800,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
   {
    "title": "Simple & Affordable",
    "price": "500,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Grey Lights",
    "price": "400,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Humble Lights",
    "price": "500,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Brown Design",
    "price": "300,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Blue Design",
    "price": "400,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Rectangle Design",
    "price": "300,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Grey Design",
    "price": "400,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Purple Design",
    "price": "400,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Circular Lights",
    "price": "400,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
  {
    "title": "Deep Lights",
    "price": "800,000 UGX",
    "image": "assets/painting 1.jpg", // Replace with your image path
  },
];













