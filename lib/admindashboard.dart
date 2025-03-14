import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const AdminDashboard());
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Admin Dashboard',
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10),
        children: const [
          DashboardTile(title: 'Manage Bookings', screen: ManageBookingsScreen()),
          DashboardTile(title: 'Manage Feedback', screen: ManageFeedbackScreen()),
          DashboardTile(title: 'Manage Services', screen: ManageServicesScreen()),
          DashboardTile(title: 'Manage Images', screen: ManageImagesScreen()),
        ],
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final Widget screen;

  const DashboardTile({super.key, required this.title, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
        child: Center(child: Text(title, textAlign: TextAlign.center)),
      ),
    );
  }
}

class ManageBookingsScreen extends StatelessWidget {
  const ManageBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Bookings')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['name'] ?? 'No Name'),
                subtitle: Text(doc['date'] ?? 'No Date'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => FirebaseFirestore.instance.collection('bookings').doc(doc.id).delete(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class ManageFeedbackScreen extends StatelessWidget {
  const ManageFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Feedback')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['message'] ?? 'No Message'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => FirebaseFirestore.instance.collection('feedback').doc(doc.id).delete(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class ManageServicesScreen extends StatelessWidget {
  const ManageServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Services')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('services').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['serviceName'] ?? 'Unnamed Service'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => FirebaseFirestore.instance.collection('services').doc(doc.id).delete(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class ManageImagesScreen extends StatefulWidget {
  const ManageImagesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ManageImagesScreenState createState() => _ManageImagesScreenState();
}

class _ManageImagesScreenState extends State<ManageImagesScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _uploadImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    
    File file = File(pickedFile.path);
    try {
      final ref = FirebaseStorage.instance.ref().child('gallery/${DateTime.now().millisecondsSinceEpoch}');
      await ref.putFile(file);
      String imageUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('gallery').add({'imageUrl': imageUrl});
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Images')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('gallery').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              return Stack(
                children: [
                  Image.network(doc['imageUrl'], fit: BoxFit.cover),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => FirebaseFirestore.instance.collection('gallery').doc(doc.id).delete(),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadImage,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

class FirebaseStorage {
  // ignore: prefer_typing_uninitialized_variables
  static var instance;
}

class QuerySnapshot {
  get docs => null;
}

class FirebaseFirestore {
  // ignore: prefer_typing_uninitialized_variables
  static var instance;
}





// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:laphic_app/main.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';



// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedIndex = 0;
//   final List<Widget> _screens = [
//     const BookingsScreen(),
//     const FeedbackScreen(),
//     ManageServicesScreen(),
//     const ManageImagesScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Admin Dashboard")),
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
//           BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
//           BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Services'),
//           BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Gallery'),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class BookingsScreen extends StatelessWidget {
//   const BookingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const CircularProgressIndicator();
//         return ListView(
//           children: snapshot.data!.docs.map((doc) {
//             return ListTile(
//               title: Text(doc['service']),
//               subtitle: Text(doc['customer_name']),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }

// extension on Object {
//   get docs => null;
// }

// class FeedbackScreen extends StatelessWidget {
//   const FeedbackScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('feedbacks').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const CircularProgressIndicator();
//         return ListView(
//           children: snapshot.data!.docs.map((doc) {
//             return ListTile(
//               title: Text(doc['customer_name']),
//               subtitle: Text(doc['feedback']),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }

// class ManageServicesScreen extends StatelessWidget {
//   final TextEditingController serviceController = TextEditingController();

//   ManageServicesScreen({super.key});

//   void addService() {
//     FirebaseFirestore.instance.collection('services').add({'name': serviceController.text});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(controller: serviceController, decoration: const InputDecoration(labelText: 'Service Name')),
//         ElevatedButton(onPressed: addService, child: const Text('Add Service')),
//         Expanded(
//           child: StreamBuilder(
//             stream: FirebaseFirestore.instance.collection('services').snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) return const CircularProgressIndicator();
//               return ListView(
//                 children: snapshot.data!.docs.map((doc) {
//                   return ListTile(
//                     title: Text(doc['name']),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete),
//                       onPressed: () => doc.reference.delete(),
//                     ),
//                   );
//                 }).toList(),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ManageImagesScreen extends StatefulWidget {
//   const ManageImagesScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ManageImagesScreenState createState() => _ManageImagesScreenState();
// }

// class _ManageImagesScreenState extends State<ManageImagesScreen> {
//   final ImagePicker _picker = ImagePicker();

//   Future<void> uploadImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile == null) return;
//     final ref = FirebaseStorage.instance.ref().child('gallery/${pickedFile.name}');
//     await ref.putFile(File(pickedFile.path));
//     final url = await ref.getDownloadURL();
//     FirebaseFirestore.instance.collection('gallery').add({'image_url': url});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(onPressed: uploadImage, child: const Text('Upload Image')),
//         Expanded(
//           child: StreamBuilder(
//             stream: FirebaseFirestore.instance.collection('gallery').snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) return const CircularProgressIndicator();
//               return GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   var doc = snapshot.data!.docs[index];
//                   return Stack(
//                     children: [
//                       Image.network(doc['image_url']),
//                       Positioned(
//                         right: 0,
//                         child: IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => doc.reference.delete(),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }


