import 'package:flutter/material.dart';



class MetalFabricationPage extends StatelessWidget {
  const MetalFabricationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.grey[300],
        title: const Text(
          'Interior Gallery',
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
                  image: AssetImage('assets/metal.jpeg'), 
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Title Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "Interior Designs",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Grid of Designs
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
                itemCount: designs.length,
                itemBuilder: (context, index) {
                  final design = designs[index];
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

// Interior Design Data
final List<Map<String, String>> designs = [
  {
    "title": "Affordable",
    "price": "8,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Affordable",
    "price": "7,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Shining Theme",
    "price": "6,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Golden Theme",
    "price": "9,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Black Theme",
    "price": "3,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Interior Design",
    "price": "6,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Simple Grey Theme",
    "price": "3,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Simple Theme",
    "price": "2,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Humble Theme",
    "price": "9,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Gold Design",
    "price": "12,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Affordable",
    "price": "8,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Affordable",
    "price": "7,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Shining Theme",
    "price": "6,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Golden Theme",
    "price": "9,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Black Theme",
    "price": "3,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Interior Design",
    "price": "6,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Simple Grey Theme",
    "price": "3,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Simple Theme",
    "price": "2,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Humble Theme",
    "price": "9,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
  {
    "title": "Gold Design",
    "price": "12,000,000 UGX",
    "image": "assets/metal.jpeg", 
  },
];
