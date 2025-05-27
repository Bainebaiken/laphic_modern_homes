
import 'dart:async';
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/profile_screen.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';
import 'package:laphic_app/livechat.dart';

class FeedbackInquiryScreen extends StatefulWidget {
  const FeedbackInquiryScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FeedbackInquiryScreenState createState() => _FeedbackInquiryScreenState();
}

class _FeedbackInquiryScreenState extends State<FeedbackInquiryScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  int _rating = 0;
  bool _isLoading = false;
  File? _image;
  PlatformFile? _webImage;
  final ImagePicker _picker = ImagePicker();
  final Completer<GoogleMapController> _mapController = Completer();
  int _selectedIndex = 5; // Feedback screen index

  static const LatLng _laphicLocation = LatLng(0.347596, 32.582520);
  static const String _backendUrl = 'http://10.0.2.2:5000';

  static const String _mapStyle = '''
    [
      {
        "featureType": "administrative",
        "elementType": "geometry",
        "stylers": [{"visibility": "on"}]
      },
      {
        "featureType": "poi",
        "stylers": [{"visibility": "on"}]
      },
      {
        "featureType": "road",
        "elementType": "geometry",
        "stylers": [{"color": "#ffffff"}, {"weight": 1.5}]
      },
      {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [{"color": "#76C8DA"}]
      },
      {
        "featureType": "landscape",
        "elementType": "geometry",
        "stylers": [{"color": "#F5F5F5"}]
      }
    ]
  ''';

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> _feedbackTypes = [
    'General Feedback',
    'Service Inquiry',
    'Support Request',
    'Suggestion'
  ];
  String _selectedFeedbackType = 'General Feedback';
  final _formKey = GlobalKey<FormState>();
  bool _isMapLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeMap();
    });
  }

  Future<void> _initializeMap() async {
    if (_mapController.isCompleted) return;
    setState(() {
      _isMapLoading = true;
    });
    if (kDebugMode) {
      print('Initializing Google Map');
    }
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _emailController.text = user.email ?? '';
      _nameController.text = user.displayName ?? '';
      if (kDebugMode) {
        print('Loaded user data: email=${user.email}, name=${user.displayName}');
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _commentsController.dispose();
    _subjectController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _pickImage() async {
    if (kDebugMode) {
      print('Picking image...');
    }
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() => _webImage = result.files.first);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image selected successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        if (kDebugMode) {
          print('Web image selected: ${_webImage!.name}');
        }
      }
    } else {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() => _image = File(image.path));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image selected successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        if (kDebugMode) {
          print('Mobile image selected: ${image.path}');
        }
      }
    }
  }

  Future<String?> _uploadImage() async {
    if (kIsWeb && _webImage != null) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) throw Exception('User not logged in');
        final filename = '${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final ref = FirebaseStorage.instance
            .ref()
            .child('feedback_images')
            .child(filename);
        await ref.putData(
          _webImage!.bytes!,
          SettableMetadata(contentType: 'image/jpeg'),
        );
        final url = await ref.getDownloadURL();
        if (kDebugMode) {
          print('Web image uploaded: $url');
        }
        return url;
      } catch (e) {
        if (kDebugMode) print('Image upload error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload image: ${e.toString().split(']').last}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
        return null;
      }
    } else if (_image != null) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) throw Exception('User not logged in');
        final filename = '${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final ref = FirebaseStorage.instance
            .ref()
            .child('feedback_images')
            .child(filename);
        await ref.putFile(
          _image!,
          SettableMetadata(contentType: 'image/jpeg'),
        );
        final url = await ref.getDownloadURL();
        if (kDebugMode) {
          print('Mobile image uploaded: $url');
        }
        return url;
      } catch (e) {
        if (kDebugMode) print('Image upload error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload image: ${e.toString().split(']').last}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
        return null;
      }
    }
    return null;
  }

  bool _validateFirstPage() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> _submitFeedback() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    if (_commentsController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide your feedback or inquiry'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    if (_commentsController.text.trim().length > 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Comments must be 500 characters or less'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    if (_nameController.text.trim().length > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name must be 100 characters or less'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    if (_emailController.text.trim().length > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email must be 100 characters or less'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    if (_subjectController.text.trim().length > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Subject must be 100 characters or less'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      String? imageUrl = await _uploadImage();
      User? user = FirebaseAuth.instance.currentUser;

      final response = await http.post(
        Uri.parse('$_backendUrl/api/v1/feedback/submit'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': user?.uid ?? '',
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'subject': _subjectController.text.trim(),
          'comment': _commentsController.text.trim(),
          'rating': _rating,
          'imageUrl': imageUrl,
          'feedbackType': _selectedFeedbackType,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Feedback submitted successfully');
        }
        _showSuccessDialog();
        _clearForm();
      } else {
        final error = jsonDecode(response.body)['error'] ?? 'Failed to submit feedback';
        if (kDebugMode) {
          print('Feedback submission failed: $error');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) print('Feedback submission error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection error: ${e.toString().split(']').last}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _nextPage() {
    if (_currentPage < 2) {
      if (_currentPage == 0 && !_validateFirstPage()) {
        return;
      }
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitFeedback();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _commentsController.clear();
    _subjectController.clear();
    setState(() {
      _rating = 0;
      _image = null;
      _webImage = null;
      _selectedFeedbackType = 'General Feedback';
      _currentPage = 0;
      _pageController.jumpToPage(0);
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 10),
            Text('Thank You!', style: TextStyle(color: Colors.orange))
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Your feedback has been submitted successfully.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            const Text(
              'We appreciate your input and will get back to you if needed.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainScreen(initialIndex: 1),
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text('Back to Services'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.orange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text('Stay Here'),
          ),
        ],
      ),
    );
  }

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ServicesHomePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OngoingProjects()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChatPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const BookingScreen(
              initialDesign: '',
              initialServiceType: '',
            ),
          ),
        );
        break;
      case 5:
        // Already on FeedbackInquiryScreen
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isWide = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text(
          'Feedback & Inquiries',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildProgressIndicator(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isWide ? 24.0 : 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.7,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildPersonalInfoPage(isWide),
                          _buildFeedbackDetailsPage(isWide),
                          _buildLocationContactPage(isWide),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildNavigationButtons(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onNavBarTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildProgressStep(1, "Personal Info", _currentPage >= 0),
          _buildProgressLine(_currentPage >= 1),
          _buildProgressStep(2, "Your Feedback", _currentPage >= 1),
          _buildProgressLine(_currentPage >= 2),
          _buildProgressStep(3, "Location", _currentPage >= 2),
        ],
      ),
    );
  }

  Widget _buildProgressStep(int step, String label, bool isActive) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Colors.orange : Colors.grey.shade300,
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.orange : Colors.grey.shade600,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressLine(bool isActive) {
    return Container(
      width: 20,
      height: 2,
      color: isActive ? Colors.orange : Colors.grey.shade300,
    );
  }

  Widget _buildPersonalInfoPage(bool isWide) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tell us about yourself',
            style: TextStyle(
              fontSize: isWide ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              prefixIcon: const Icon(Icons.person, color: Colors.orange),
              labelStyle: const TextStyle(color: Colors.black54),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.orange, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
            style: const TextStyle(color: Colors.black87),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              if (value.trim().length > 100) {
                return 'Name must be 100 characters or less';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email Address',
              hintText: 'Enter your email address',
              prefixIcon: const Icon(Icons.email, color: Colors.orange),
              labelStyle: const TextStyle(color: Colors.black54),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.orange, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
            style: const TextStyle(color: Colors.black87),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }
              if (!_isValidEmail(value.trim())) {
                return 'Please enter a valid email address';
              }
              if (value.trim().length > 100) {
                return 'Email must be 100 characters or less';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _subjectController,
            decoration: InputDecoration(
              labelText: 'Subject',
              hintText: 'What is your feedback about?',
              prefixIcon: const Icon(Icons.subject, color: Colors.orange),
              labelStyle: const TextStyle(color: Colors.black54),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.orange, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
            style: const TextStyle(color: Colors.black87),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a subject';
              }
              if (value.trim().length > 100) {
                return 'Subject must be 100 characters or less';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Feedback Type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value:    	    
                _selectedFeedbackType,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.orange),
                items: _feedbackTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedFeedbackType = newValue;
                    });
                  }
                },
                style: const TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackDetailsPage(bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Share Your Thoughts',
          style: TextStyle(
            fontSize: isWide ? 24 : 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _commentsController,
          maxLines: 5,
          maxLength: 500,
          decoration: InputDecoration(
            labelText: 'Your Feedback',
            hintText: 'Please provide your detailed feedback or inquiry...',
            alignLabelWithHint: true,
            labelStyle: const TextStyle(color: Colors.black54),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.orange, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
          style: const TextStyle(color: Colors.black87),
        ),
        const SizedBox(height: 20),
        _buildRatingSection(),
        const SizedBox(height: 20),
        _buildImageUpload(),
      ],
    );
  }

  Widget _buildLocationContactPage(bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Location',
          style: TextStyle(
            fontSize: isWide ? 24 : 20,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    _mapController.complete(controller);
                    controller.setMapStyle(_mapStyle).catchError((e) {
                      if (kDebugMode) print('Error setting map style: $e');
                    });
                    setState(() {
                      _isMapLoading = false;
                    });
                    if (kDebugMode) {
                      print('Map created successfully');
                    }
                  },
                  initialCameraPosition: const CameraPosition(
                    target: _laphicLocation,
                    zoom: 15,
                  ),
                  markers: {
                    const Marker(
                      markerId: MarkerId('laphic'),
                      position: _laphicLocation,
                      infoWindow: InfoWindow(title: 'Laphic Modern Homes'),
                    ),
                  },
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: false,
                  compassEnabled: true,
                  mapToolbarEnabled: true,
                ),
                if (_isMapLoading)
                  Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildContactInfo(),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            _buildContactRow(
              Icons.location_on,
              'Kitende, Entebbe Road, Kampala, Uganda',
              Colors.orange,
            ),
            const Divider(height: 24),
            _buildContactRow(
              Icons.phone,
              '+256 705029291',
              Colors.orange,
            ),
            const Divider(height: 24),
            _buildContactRow(
              Icons.email,
              'laphicmodernhomes@gmail.com',
              Colors.orange,
            ),
            const SizedBox(height: 16),
            const Text(
              'Business Hours: Monday - Friday, 8:00 AM - 6:00 PM',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    String ratingText;
    switch (_rating) {
      case 1:
        ratingText = 'Poor';
        break;
      case 2:
        ratingText = 'Fair';
        break;
      case 3:
        ratingText = 'Good';
        break;
      case 4:
        ratingText = 'Very Good';
        break;
      case 5:
        ratingText = 'Excellent';
        break;
      default:
        ratingText = 'No Rating';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rate Your Experience',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => setState(() => _rating = index + 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.orange,
                  size: 40,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            ratingText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildImageUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Image (Optional)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.grey[300]!),
          ),
          child: Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: _image != null || _webImage != null
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: kIsWeb && _webImage != null
                            ? Image.memory(
                                _webImage!.bytes!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 134,
                              )
                            : Image.file(
                                _image!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 134,
                              ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _image = null;
                              _webImage = null;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Image removed'),
                                backgroundColor: Colors.orange,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.grey[400],
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No Image Selected',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: ElevatedButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.upload),
            label: const Text('Pick Image'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentPage > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: _previousPage,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.orange,
                side: const BorderSide(color: Colors.orange),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Previous',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          )
        else
          const Spacer(),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    _currentPage == 2 ? 'Submit' : 'Next',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
          ),
        ),
      ],
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({Key? key, required this.initialIndex}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ServicesHomePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OngoingProjects()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ChatPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const BookingScreen(
              initialDesign: '',
              initialServiceType: '',
            ),
          ),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FeedbackInquiryScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laphic Modern Homes'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Welcome to ${_selectedIndex == 1 ? 'Services' : 'Home'}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onNavBarTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Projects'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
        ],
      ),
    );
  }
}