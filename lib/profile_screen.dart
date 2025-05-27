

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:laphic_app/booking.dart';
// import 'package:laphic_app/feedback.dart';
// import 'package:laphic_app/livechat.dart';
// import 'package:laphic_app/projects_designn.dart';
// import 'package:laphic_app/services.dart';
// import 'package:laphic_app/settings_screen.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   // Brand colors
//   final Color primaryColor = const Color(0xFF080F2B);
//   final Color accentColor = const Color(0xFFFF9800); // Orange
//   final Color bgColor = const Color(0xFFF8F9FC);
//   final Color cardColor = Colors.white;
  
//   int _currentNavIndex = 0;
//   bool _isEditing = false;
//   File? _imageFile;

//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController = TextEditingController(text: "John Doe");
//   final TextEditingController _emailController = TextEditingController(text: "johndoe@example.com");
//   final TextEditingController _phoneController = TextEditingController(text: "+256 700000000");

//   Future<void> _pickImage() async {
//     final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() {
//         _imageFile = File(picked.path);
//       });
//     }
//   }

//   void _showPasswordDialog() {
//     // Create controller variables without underscores to avoid shadowing
//     final passwordController = TextEditingController();
//     final confirmController = TextEditingController();
//     // Create local variables for toggle states
//     bool passwordVisible = false;
//     bool confirmVisible = false;
    
//     showDialog(
//       context: context,
//       builder: (context) => StatefulBuilder(
//         builder: (BuildContext context, StateSetter setDialogState) {
//           return AlertDialog(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//             title: Text(
//               "Change Password",
//               style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: passwordController,
//                   obscureText: !passwordVisible,
//                   decoration: InputDecoration(
//                     labelText: "New Password",
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                     suffixIcon: IconButton(
//                       icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
//                       onPressed: () {
//                         setDialogState(() {
//                           passwordVisible = !passwordVisible;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextField(
//                   controller: confirmController,
//                   obscureText: !confirmVisible,
//                   decoration: InputDecoration(
//                     labelText: "Confirm Password",
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                     suffixIcon: IconButton(
//                       icon: Icon(confirmVisible ? Icons.visibility_off : Icons.visibility),
//                       onPressed: () {
//                         setDialogState(() {
//                           confirmVisible = !confirmVisible;
//                         });
//                       },
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             actions: [
//               TextButton(
//                 child: Text("Cancel", style: TextStyle(color: Colors.grey)),
//                 onPressed: () => Navigator.pop(context),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: accentColor,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 ),
//                 child: const Text("Update"),
//                 onPressed: () {
//                   // Check if passwords match
//                   if (passwordController.text.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Password cannot be empty")),
//                     );
//                     return;
//                   }
                  
//                   if (passwordController.text != confirmController.text) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Passwords do not match")),
//                     );
//                     return;
//                   }
                  
//                   // Password update logic would go here
//                   Navigator.pop(context);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Row(
//                         children: const [
//                           Icon(Icons.check_circle, color: Colors.white),
//                           SizedBox(width: 12),
//                           Text("Password updated successfully"),
//                         ],
//                       ),
//                       backgroundColor: Colors.green,
//                       behavior: SnackBarBehavior.floating,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                   );
//                 },
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }

//   void _saveChanges() {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isEditing = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Row(
//             children: const [
//               Icon(Icons.check_circle, color: Colors.white),
//               SizedBox(width: 12),
//               Text("Profile updated successfully"),
//             ],
//           ),
//           backgroundColor: Colors.green,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgColor,
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'My Profile',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: primaryColor,
//         actions: [
//           AnimatedSwitcher(
//             duration: const Duration(milliseconds: 300),
//             child: _isEditing
//                 ? Row(
//                     key: const ValueKey('editing'),
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.save),
//                         tooltip: 'Save Changes',
//                         onPressed: _saveChanges,
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.cancel),
//                         tooltip: 'Cancel Editing',
//                         onPressed: () => setState(() => _isEditing = false),
//                       ),
//                     ],
//                   )
//                 : IconButton(
//                     key: const ValueKey('not_editing'),
//                     icon: const Icon(Icons.edit),
//                     tooltip: 'Edit Profile',
//                     onPressed: () => setState(() => _isEditing = true),
//                   ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildProfileHeader(),
//             _buildProfileForm(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: _buildBottomNavBar(),
//     );
//   }

//   Widget _buildProfileHeader() {
//     return Container(
//       padding: const EdgeInsets.only(bottom: 24),
//       decoration: BoxDecoration(
//         color: primaryColor,
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         children: [
//           const SizedBox(height: 16),
//           Stack(
//             alignment: Alignment.bottomRight,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: accentColor, width: 2),
//                 ),
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.grey[200],
//                   backgroundImage: _imageFile != null
//                       ? FileImage(_imageFile!)
//                       : const AssetImage('assets/profile_avatar.png') as ImageProvider,
//                 ),
//               ),
//               if (_isEditing)
//                 Positioned(
//                   child: GestureDetector(
//                     onTap: _pickImage,
//                     child: Container(
//                       padding: const EdgeInsets.all(3),
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                       ),
//                       child: CircleAvatar(
//                         backgroundColor: accentColor,
//                         radius: 18,
//                         child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             _nameController.text,
//             style: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             _emailController.text,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.white.withOpacity(0.8),
//             ),
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileForm() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Profile Info Section
//             Card(
//               elevation: 1,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Personal Information",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: primaryColor,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       "Full Name",
//                       _nameController,
//                       Icons.person_outline,
//                       _isEditing,
//                       (value) {
//                         if (value == null || value.isEmpty) return 'Name is required';
//                         return null;
//                       },
//                     ),
//                     _buildTextField(
//                       "Email",
//                       _emailController,
//                       Icons.email_outlined,
//                       _isEditing,
//                       (value) {
//                         if (value == null || !value.contains('@')) return 'Enter a valid email';
//                         return null;
//                       },
//                     ),
//                     _buildTextField(
//                       "Phone",
//                       _phoneController,
//                       Icons.phone_outlined,
//                       _isEditing,
//                       (value) {
//                         if (value == null || value.length < 10) return 'Enter valid phone number';
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
            
//             const SizedBox(height: 16),
            
//             // Security Section
//             Card(
//               elevation: 1,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Security",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: primaryColor,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     ListTile(
//                       onTap: _isEditing ? _showPasswordDialog : null,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       tileColor: _isEditing ? Colors.grey[100] : null,
//                       leading: Icon(Icons.lock_outline, color: _isEditing ? accentColor : Colors.grey),
//                       title: Text("Change Password", 
//                         style: TextStyle(
//                           color: _isEditing ? null : Colors.grey,
//                         ),
//                       ),
//                       trailing: _isEditing 
//                         ? Icon(Icons.arrow_forward_ios, size: 16, color: accentColor) 
//                         : null,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
            
//             const SizedBox(height: 16),
            
//             // Settings Section
//             Card(
//               elevation: 1,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(16),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => SettingsScreen(
//                         onThemeChanged: (bool isDark) {},
//                         isDarkMode: false,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Row(
//                     children: [
//                       Icon(Icons.settings_outlined, color: accentColor),
//                       const SizedBox(width: 16),
//                       const Text(
//                         "Account Settings",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const Spacer(),
//                       const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
            
//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//       String label, 
//       TextEditingController controller, 
//       IconData icon,
//       bool editable, 
//       String? Function(String?)? validator
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: controller,
//         enabled: editable,
//         validator: validator,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: editable ? accentColor : Colors.grey),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: Colors.grey.shade300),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: accentColor, width: 2),
//           ),
//           filled: true,
//           fillColor: editable ? Colors.white : Colors.grey.shade50,
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomNavBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         child: BottomNavigationBar(
//           currentIndex: _currentNavIndex,
//           selectedItemColor: accentColor,
//           unselectedItemColor: Colors.grey,
//           showUnselectedLabels: true,
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.white,
//           elevation: 0,
//           onTap: (index) {
//             setState(() => _currentNavIndex = index);
//             switch (index) {
//               case 0:
//                 break;
//               case 1:
//                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ServicesHomePage()));
//                 break;
//               case 2:
//                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OngoingProjects()));
//                 break;
//               case 3:
//                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ChatPage()));
//                 break;
//               case 4:
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => const BookingScreen(initialDesign: '', initialServiceType: '')));
//                 break;
//               case 5:
//                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const FeedbackInquiryScreen()));
//                 break;
//             }
//           },
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Services'),
//             BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Projects'),
//             BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
//             BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
//             BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/livechat.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';
import 'package:laphic_app/settings_screen.dart';

// AuthService to manage JWT token
class AuthService {
  static const storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'jwt_token');
  }

  static Future<void> deleteToken() async {
    await storage.delete(key: 'jwt_token');
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Brand colors
  final Color primaryColor = const Color(0xFF080F2B);
  final Color accentColor = const Color(0xFFFF9800);
  final Color bgColor = const Color(0xFFF8F9FC);
  final Color cardColor = Colors.white;

  int _currentNavIndex = 0;
  bool _isEditing = false;
  File? _imageFile;
  String? _profileImageUrl;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final String baseUrl = 'http://localhost:5000/auth'; // Adjust to your Flask server URL

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        Navigator.pushReplacementNamed(context, '/login');
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _nameController.text = data['user']['name'] ?? '';
          _emailController.text = data['user']['email'] ?? '';
          _phoneController.text = data['user']['phone'] ?? '';
          _profileImageUrl = data['user']['profile_image']; // Nullable
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load profile: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching profile: $e')),
      );
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
      await _uploadProfileImage();
    }
  }

  Future<void> _uploadProfileImage() async {
    if (_imageFile == null) return;

    try {
      final token = await AuthService.getToken();
      if (token == null) {
        Navigator.pushReplacementNamed(context, '/login');
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload-profile-image'),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        setState(() {
          _profileImageUrl = data['image_url'];
          _imageFile = null; // Clear local file after upload
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile image updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $responseBody')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    }
  }

  Future<void> _removeProfileImage() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        Navigator.pushReplacementNamed(context, '/login');
        return;
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/upload-profile-image'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _profileImageUrl = null;
          _imageFile = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile image removed successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to remove image: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error removing image: $e')),
      );
    }
  }

  void _showPasswordDialog() {
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();
    bool passwordVisible = false;
    bool confirmVisible = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(
              "Change Password",
              style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    labelText: "New Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setDialogState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmController,
                  obscureText: !confirmVisible,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                      icon: Icon(confirmVisible ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setDialogState(() {
                          confirmVisible = !confirmVisible;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text("Cancel", style: TextStyle(color: Colors.grey)),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Text("Update"),
                onPressed: () async {
                  if (passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Password cannot be empty")),
                    );
                    return;
                  }

                  if (passwordController.text != confirmController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Passwords do not match")),
                    );
                    return;
                  }

                  try {
                    final token = await AuthService.getToken();
                    final response = await http.put(
                      Uri.parse('$baseUrl/update-password'),
                      headers: {
                        'Authorization': 'Bearer $token',
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode({'password': passwordController.text}),
                    );

                    if (response.statusCode == 200) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: const [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 12),
                              Text("Password updated successfully"),
                            ],
                          ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to update password: ${response.body}')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error updating password: $e')),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      try {
        final token = await AuthService.getToken();
        if (token == null) {
          Navigator.pushReplacementNamed(context, '/login');
          return;
        }

        final response = await http.put(
          Uri.parse('$baseUrl/update'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'name': _nameController.text,
            'phone': _phoneController.text,
            'email': _emailController.text,
          }),
        );

        if (response.statusCode == 200) {
          setState(() => _isEditing = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12),
                  Text("Profile updated successfully"),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }

  Future<void> _logout() async {
    await AuthService.deleteToken();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        actions: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isEditing
                ? Row(
                    key: const ValueKey('editing'),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.save),
                        tooltip: 'Save Changes',
                        onPressed: _saveChanges,
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel),
                        tooltip: 'Cancel Editing',
                        onPressed: () => setState(() => _isEditing = false),
                      ),
                    ],
                  )
                : Row(
                    key: const ValueKey('not_editing'),
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        tooltip: 'Edit Profile',
                        onPressed: () => setState(() => _isEditing = true),
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout),
                        tooltip: 'Logout',
                        onPressed: _logout,
                      ),
                    ],
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildProfileForm(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: accentColor, width: 2),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : _profileImageUrl != null
                          ? NetworkImage('$baseUrl$_profileImageUrl')
                          : const AssetImage('assets/profile_avatar.png') as ImageProvider,
                ),
              ),
              if (_isEditing)
                Positioned(
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'upload') {
                        _pickImage();
                      } else if (value == 'remove') {
                        _removeProfileImage();
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      const PopupMenuItem(
                        value: 'upload',
                        child: Text('Upload Image'),
                      ),
                      if (_profileImageUrl != null || _imageFile != null)
                        const PopupMenuItem(
                          value: 'remove',
                          child: Text('Remove Image'),
                        ),
                    ],
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundColor: accentColor,
                        radius: 18,
                        child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _nameController.text.isNotEmpty ? _nameController.text : 'User',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _emailController.text.isNotEmpty ? _emailController.text : 'No email',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildProfileForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Info Section
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      "Full Name",
                      _nameController,
                      Icons.person_outline,
                      _isEditing,
                      (value) {
                        if (value == null || value.isEmpty) return 'Name is required';
                        return null;
                      },
                    ),
                    _buildTextField(
                      "Email",
                      _emailController,
                      Icons.email_outlined,
                      _isEditing,
                      (value) {
                        if (value == null || !value.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    _buildTextField(
                      "Phone",
                      _phoneController,
                      Icons.phone_outlined,
                      _isEditing,
                      (value) {
                        if (value == null || value.length < 10) return 'Enter valid phone number';
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Security Section
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Security",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      onTap: _isEditing ? _showPasswordDialog : null,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      tileColor: _isEditing ? Colors.grey[100] : null,
                      leading: Icon(Icons.lock_outline, color: _isEditing ? accentColor : Colors.grey),
                      title: Text(
                        "Change Password",
                        style: TextStyle(
                          color: _isEditing ? null : Colors.grey,
                        ),
                      ),
                      trailing: _isEditing
                          ? Icon(Icons.arrow_forward_ios, size: 16, color: accentColor)
                          : null,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Settings Section
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SettingsScreen(
                        onThemeChanged: (bool isDark) {},
                        isDarkMode: false,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.settings_outlined, color: accentColor),
                      const SizedBox(width: 16),
                      const Text(
                        "Account Settings",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon,
    bool editable,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        enabled: editable,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: editable ? accentColor : Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: accentColor, width: 2),
          ),
          filled: true,
          fillColor: editable ? Colors.white : Colors.grey.shade50,
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentNavIndex,
          selectedItemColor: accentColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          onTap: (index) {
            setState(() => _currentNavIndex = index);
            switch (index) {
              case 0:
                break;
              case 1:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ServicesHomePage()));
                break;
              case 2:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OngoingProjects()));
                break;
              case 3:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ChatPage()));
                break;
              case 4:
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const BookingScreen(initialDesign: '', initialServiceType: '')));
                break;
              case 5:
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const FeedbackInquiryScreen()));
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Services'),
            BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Projects'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
            BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
          ],
        ),
      ),
    );
  }
}