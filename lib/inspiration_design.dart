import 'package:flutter/material.dart';









class InspirationHall extends StatelessWidget {
  const InspirationHall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Stack(
              children: [
                Image.asset(
                  'assets/design.jpeg', // Replace with your image path
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 200,
                  color: Colors.black.withOpacity(0.4),
                ),
                const Positioned(
                  top: 50,
                  left: 50,
                  child: Text(
                    'Get Inspiration with Us ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Image Grid Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 2.5,
                ),
                itemCount: inspirationImages.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      inspirationImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // "Click Here for More" Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your navigation or action logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Click Here for More',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Replace with your image assets
final List<String> inspirationImages = [
  
  'assets/WhatsApp Image 2024-10-05 at 21.24.00_89194cc6.jpg',
  'assets/interior7.jpeg',
  'assets/painting 1.jpg',
  'assets/interior3.jpeg',
  'assets/house5.jpeg',
  'assets/laphic2.PNG',
  'assets/SWIUXEXDJDK.jpg',
  'assets/painting2.jpeg',
  'assets/metal.jpeg',
  'assets/compound 1.jpg',
  'assets/design.jpeg',
  'assets/gypsum6.webp',
  'assets/bed.jpg',
  'assets/WhatsApp Image 2024-10-05 at 21.24.00_89194cc6.jpg',
  'assets/interior7.jpeg',
  'assets/painting 1.jpg',
  'assets/interior3.jpeg',
  'assets/house5.jpeg',
  'assets/laphic2.PNG',
  'assets/SWIUXEXDJDK.jpg',
  'assets/painting2.jpeg',
  'assets/metal.jpeg',
  'assets/compound 1.jpg',
  'assets/design.jpeg',
  'assets/gypsum6.webp',
  'assets/bed.jpg',
  'assets/WhatsApp Image 2024-10-05 at 21.24.00_89194cc6.jpg',
  'assets/interior7.jpeg',
  'assets/painting 1.jpg',
  'assets/interior3.jpeg',
  'assets/house5.jpeg',
  'assets/laphic2.PNG',
  'assets/SWIUXEXDJDK.jpg',
  'assets/painting2.jpeg',
  'assets/metal.jpeg',
  'assets/compound 1.jpg',
  'assets/design.jpeg',
  'assets/gypsum6.webp',
  'assets/bed.jpg',
  'assets/WhatsApp Image 2024-10-05 at 21.24.00_89194cc6.jpg',
  'assets/interior7.jpeg',
  'assets/painting 1.jpg',
  'assets/interior3.jpeg',
  'assets/house5.jpeg',
  'assets/laphic2.PNG',
  'assets/SWIUXEXDJDK.jpg',
  'assets/painting2.jpeg',
  'assets/metal.jpeg',
  'assets/compound 1.jpg',
  'assets/design.jpeg',
  'assets/gypsum6.webp',
  'assets/bed.jpg',
];
