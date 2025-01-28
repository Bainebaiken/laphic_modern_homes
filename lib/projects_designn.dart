import 'package:flutter/material.dart';



class OngoingProjects extends StatelessWidget {
  const OngoingProjects({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Stack(
              children: [
                Image.asset(
                  'assets/SWIUXEXDJDK.jpg', // Replace with your header image path
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 200,
                  color: Colors.black.withOpacity(0.5),
                ),
                const Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    'ON GOING PROJECTS',
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

            // Grid Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: ongoingProjects.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.asset(
                              ongoingProjects[index]['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ongoingProjects[index]['location']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
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

// Data for ongoing projects
final List<Map<String, String>> ongoingProjects = [
  {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Congo'},
  {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Lweza Plot No 77'},
  {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Kitende Plot No 890'},
  {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Jinja Plot No 44'},
  {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Location: Nalumunye Bandwe'},
  {'image': 'assets/SWIUXEXDJDK.jpg', 'location': 'Located: Congo'},
];
