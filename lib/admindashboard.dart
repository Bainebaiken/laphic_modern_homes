




import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  String _activeSection = 'overview';
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _sections = [
    {'name': 'overview', 'title': 'Overview', 'icon': Icons.dashboard},
    {'name': 'services', 'title': 'Services', 'icon': Icons.build},
    {'name': 'gallery', 'title': 'Gallery', 'icon': Icons.image},
    {'name': 'users', 'title': 'Users', 'icon': Icons.people},
    {'name': 'bookings', 'title': 'Bookings', 'icon': Icons.event},
    {'name': 'providers', 'title': 'Providers', 'icon': Icons.work},
    {'name': 'feedback', 'title': 'Feedback', 'icon': Icons.feedback},
    {'name': 'notifications', 'title': 'Notifications', 'icon': Icons.notifications},
    {'name': 'terms', 'title': 'Terms', 'icon': Icons.description},
    {'name': 'screens', 'title': 'Screens', 'icon': Icons.phone_android},
    {'name': 'chat', 'title': 'Live Chat', 'icon': Icons.chat},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF080F2B),
        title: const Text('Admin Dashboard', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () async {
              await authProvider.logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SplashScreen()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out.')),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF080F2B), Color(0xFF1A2A6C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Laphic Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'User: ${authProvider.userType?.toUpperCase() ?? 'Admin'}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _sections.length,
                itemBuilder: (context, index) {
                  final section = _sections[index];
                  return ListTile(
                    leading: Icon(
                      section['icon'] as IconData,
                      color: _activeSection == section['name'] ? const Color(0xFF080F2B) : Colors.grey,
                    ),
                    title: Text(
                      section['title'] as String,
                      style: TextStyle(
                        color: _activeSection == section['name'] ? const Color(0xFF080F2B) : Colors.black87,
                        fontWeight: _activeSection == section['name'] ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _activeSection = section['name'] as String;
                        _controller.reset();
                        _controller.forward();
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _buildSection(),
      ),
    );
  }

  Widget _buildSection() {
    switch (_activeSection) {
      case 'overview':
        return const OverviewSection();
      case 'services':
        return const ServicesSection();
      case 'gallery':
        return const GallerySection();
      case 'users':
        return const UsersSection();
      case 'bookings':
        return const BookingsSection();
      case 'providers':
        return const ProvidersSection();
      case 'feedback':
        return const FeedbackSection();
      case 'notifications':
        return const NotificationsSection();
      case 'terms':
        return const TermsSection();
      case 'screens':
        return const ScreensSection();
      case 'chat':
        return const ChatSection();
      default:
        return const Center(child: Text('Select a section'));
    }
  }
}

class OverviewSection extends StatelessWidget {
  const OverviewSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overview', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 16),
          if (authProvider.isLoading) const Center(child: CircularProgressIndicator()),
          if (authProvider.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Error: ${authProvider.error}', style: const TextStyle(color: Colors.red)),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildOverviewCard(
                context,
                icon: Icons.people,
                title: 'Users',
                value: '1,234',
                color: Colors.blueAccent,
              ),
              _buildOverviewCard(
                context,
                icon: Icons.event,
                title: 'Bookings',
                value: '56',
                color: Colors.green,
              ),
              _buildOverviewCard(
                context,
                icon: Icons.work,
                title: 'Providers',
                value: '10',
                color: Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Recent Activity', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 8),
          _buildActivityCard(context, 'New user registered', 'John Doe joined the platform', Icons.person_add),
          _buildActivityCard(context, 'Booking created', 'Booking #123 for Metal Fabrication', Icons.event_available),
          _buildActivityCard(context, 'Feedback received', '5-star rating from Jane Smith', Icons.star),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context, {required IconData icon, required String title, required String value, required Color color}) {
    final theme = Theme.of(context);
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(title, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 4),
              Text(value, style: theme.textTheme.headlineMedium?.copyWith(color: color)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, String title, String subtitle, IconData icon) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF080F2B).withOpacity(0.1),
          child: Icon(icon, color: const Color(0xFF080F2B)),
        ),
        title: Text(title, style: theme.textTheme.bodyLarge),
        subtitle: Text(subtitle, style: theme.textTheme.bodyMedium),
        trailing: const Text('2h ago', style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class ServicesSection extends StatefulWidget {
  const ServicesSection({Key? key}) : super(key: key);

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  List<Map<String, dynamic>> _services = [];

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _costController.dispose();
    super.dispose();
  }

  Future<void> _fetchServices() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/services/services');
      if (data != null && data is List) {
        setState(() {
          _services = List<Map<String, dynamic>>.from(data);
        });
      } else {
        setState(() {
          _services = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load services')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching services: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Services', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Service Name',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.build),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter service name' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.category),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter category' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description (Optional)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.description),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _costController,
                      decoration: InputDecoration(
                        labelText: 'Cost',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.attach_money),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Enter cost' : double.tryParse(value) == null ? 'Enter valid number' : null,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: authProvider.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final data = await authProvider.makeRequest(
                                    method: 'POST',
                                    endpoint: '/api/v1/services/register',
                                    body: {
                                      'Name': _nameController.text,
                                      'Category': _categoryController.text,
                                      'Description': _descriptionController.text,
                                      'Cost': double.parse(_costController.text),
                                    },
                                  );
                                  if (data != null) {
                                    _nameController.clear();
                                    _categoryController.clear();
                                    _descriptionController.clear();
                                    _costController.clear();
                                    await _fetchServices();
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Service added')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(authProvider.error ?? 'Error adding service')));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                                }
                              }
                            },
                      child: const Text('Add Service'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (authProvider.isLoading) const Center(child: CircularProgressIndicator()),
          if (authProvider.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Error: ${authProvider.error}', style: const TextStyle(color: Colors.red)),
            ),
          ..._services.asMap().entries.map((entry) {
            final index = entry.key;
            final service = entry.value;
            return _buildServiceCard(context, index, service);
          }),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, int index, Map<String, dynamic> service) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF080F2B).withOpacity(0.1),
              child: const Icon(Icons.build, color: Color(0xFF080F2B)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service['Name'] ?? 'N/A', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Category: ${service['Category'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                  Text('Cost: \$${service['Cost']?.toString() ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    _nameController.text = service['Name'] ?? '';
                    _categoryController.text = service['Category'] ?? '';
                    _descriptionController.text = service['Description'] ?? '';
                    _costController.text = service['Cost']?.toString() ?? '';
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Edit Service'),
                        content: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(labelText: 'Service Name'),
                                  validator: (value) => value!.isEmpty ? 'Enter service name' : null,
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _categoryController,
                                  decoration: const InputDecoration(labelText: 'Category'),
                                  validator: (value) => value!.isEmpty ? 'Enter category' : null,
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _descriptionController,
                                  decoration: const InputDecoration(labelText: 'Description (Optional)'),
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _costController,
                                  decoration: const InputDecoration(labelText: 'Cost'),
                                  keyboardType: TextInputType.number,
                                  validator: (value) =>
                                      value!.isEmpty ? 'Enter cost' : double.tryParse(value) == null ? 'Enter valid number' : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final authProvider = Provider.of<AuthProvider>(context, listen: false);
                                  final data = await authProvider.makeRequest(
                                    method: 'PUT',
                                    endpoint: '/api/v1/services/services/${service['Service_ID']}',
                                    body: {
                                      'Name': _nameController.text,
                                      'Category': _categoryController.text,
                                      'Description': _descriptionController.text,
                                      'Cost': double.parse(_costController.text),
                                    },
                                  );
                                  if (data != null) {
                                    await _fetchServices();
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Service updated')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(authProvider.error ?? 'Error updating service')));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                                }
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () async {
                    try {
                      final authProvider = Provider.of<AuthProvider>(context, listen: false);
                      final data = await authProvider.makeRequest(
                        method: 'DELETE',
                        endpoint: '/api/v1/services/services/${service['Service_ID']}',
                      );
                      if (data != null) {
                        await _fetchServices();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Service deleted')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(authProvider.error ?? 'Error deleting service')));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GallerySection extends StatefulWidget {
  const GallerySection({Key? key}) : super(key: key);

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedServiceId;
  File? _selectedFile;
  List<Map<String, dynamic>> _services = [];
  List<Map<String, dynamic>> _images = [];

  @override
  void initState() {
    super.initState();
    _fetchServices();
    _fetchImages();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _fetchServices() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/services/services');
      if (data != null && data is List) {
        setState(() {
          _services = List<Map<String, dynamic>>.from(data);
        });
      } else {
        setState(() {
          _services = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No services available')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching services: $e')));
    }
  }

  Future<void> _fetchImages() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/gallery/all');
      if (data != null && data is List) {
        setState(() {
          _images = List<Map<String, dynamic>>.from(data);
        });
      } else {
        setState(() {
          _images = [];
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching images: $e')));
    }
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);
      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error picking file: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gallery', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Image Name',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.image),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter image name' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description (Optional)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.description),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedServiceId,
                      decoration: InputDecoration(
                        labelText: 'Service',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.build),
                      ),
                      items: _services.isEmpty
                          ? [
                              const DropdownMenuItem<String>(
                                value: null,
                                child: Text('No services available'),
                              ),
                            ]
                          : _services.map((service) {
                              return DropdownMenuItem<String>(
                                value: service['Service_ID']?.toString(),
                                child: Text(service['Name'] ?? 'N/A'),
                              );
                            }).toList(),
                      onChanged: _services.isEmpty ? null : (value) => setState(() => _selectedServiceId = value),
                      validator: (value) => value == null ? 'Select a service' : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedFile != null ? _selectedFile!.path.split('/').last : 'No file selected',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _pickFile,
                          child: const Text('Pick Image'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: authProvider.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate() && _selectedFile != null) {
                                try {
                                  final data = await authProvider.makeRequest(
                                    method: 'POST',
                                    endpoint: '/gallery/add',
                                    headers: {'Content-Type': 'multipart/form-data'},
                                    fields: {
                                      'name': _nameController.text,
                                      'description': _descriptionController.text,
                                      'service_id': _selectedServiceId!,
                                    },
                                    file: _selectedFile!,
                                  );
                                  if (data != null) {
                                    _nameController.clear();
                                    _descriptionController.clear();
                                    _selectedServiceId = null;
                                    _selectedFile = null;
                                    await _fetchImages();
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Image added')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(authProvider.error ?? 'Error uploading image')));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                                }
                              } else if (_selectedFile == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(content: Text('Please select an image')));
                              }
                            },
                      child: const Text('Upload Image'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (authProvider.isLoading) const Center(child: CircularProgressIndicator()),
          if (authProvider.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Error: ${authProvider.error}', style: const TextStyle(color: Colors.red)),
            ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: _images.length,
            itemBuilder: (BuildContext context, int index) {
              final image = _images[index];
              return _buildGalleryCard(context, index, image);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGalleryCard(BuildContext context, int index, Map<String, dynamic> image) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: image['path'] != null && image['path'].isNotEmpty
                  ? Image.network(
                      '${authProvider.baseUrl}/${image['path']}',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 50),
                    )
                  : const Center(child: Icon(Icons.image_not_supported, size: 50)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  image['name'] ?? 'N/A',
                  style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Service ID: ${image['service_id']?.toString() ?? 'N/A'}',
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  'Description: ${image['description'] ?? 'None'}',
                  style: theme.textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        _nameController.text = image['name'] ?? '';
                        _descriptionController.text = image['description'] ?? '';
                        _selectedServiceId = image['service_id']?.toString();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Edit Image'),
                            content: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(labelText: 'Image Name'),
                                      validator: (value) => value!.isEmpty ? 'Enter image name' : null,
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _descriptionController,
                                      decoration: const InputDecoration(labelText: 'Description (Optional)'),
                                      maxLines: 3,
                                    ),
                                    const SizedBox(height: 8),
                                    DropdownButtonFormField<String>(
                                      value: _selectedServiceId,
                                      decoration: const InputDecoration(labelText: 'Service'),
                                      items: _services.isEmpty
                                          ? [
                                              const DropdownMenuItem<String>(
                                                value: null,
                                                child: Text('No services available'),
                                              ),
                                            ]
                                          : _services.map((service) {
                                              return DropdownMenuItem<String>(
                                                value: service['Service_ID']?.toString(),
                                                child: Text(service['Name'] ?? 'N/A'),
                                              );
                                            }).toList(),
                                      onChanged: _services.isEmpty ? null : (value) => setState(() => _selectedServiceId = value),
                                      validator: (value) => value == null ? 'Select a service' : null,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      final authProvider = Provider.of<AuthProvider>(context, listen: false);
                                      final data = await authProvider.makeRequest(
                                        method: 'PUT',
                                        endpoint: '/gallery/update/${image['id']}',
                                        body: {
                                          'name': _nameController.text,
                                          'description': _descriptionController.text,
                                          'service_id': int.parse(_selectedServiceId!),
                                        },
                                      );
                                      if (data != null) {
                                        await _fetchImages();
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(content: Text('Image updated')));
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(authProvider.error ?? 'Error updating image')));
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                                    }
                                  }
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          final data = await authProvider.makeRequest(
                            method: 'DELETE',
                            endpoint: '/gallery/delete/${image['id']}',
                          );
                          if (data != null) {
                            await _fetchImages();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Image deleted')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(authProvider.error ?? 'Error deleting image')));
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UsersSection extends StatefulWidget {
  const UsersSection({Key? key}) : super(key: key);

  @override
  State<UsersSection> createState() => _UsersSectionState();
}

class _UsersSectionState extends State<UsersSection> {
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/users');
      if (data != null && data is List) {
        setState(() {
          _users = List<Map<String, dynamic>>.from(data);
        });
      } else {
        setState(() {
          _users = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load users')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching users: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Users', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 16),
          if (authProvider.isLoading) const Center(child: CircularProgressIndicator()),
          if (authProvider.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Error: ${authProvider.error}', style: const TextStyle(color: Colors.red)),
            ),
          if (_users.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No users available'),
              ),
            ),
          ..._users.asMap().entries.map((entry) {
            final index = entry.key;
            final user = entry.value;
            return _buildUserCard(context, index, user);
          }),
        ],
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, int index, Map<String, dynamic> user) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF080F2B).withOpacity(0.1),
              child: const Icon(Icons.person, color: Color(0xFF080F2B)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user['name'] ?? 'N/A', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Email: ${user['email'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                  Text('Joined: ${user['created_at'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingsSection extends StatefulWidget {
  const BookingsSection({Key? key}) : super(key: key);

  @override
  State<BookingsSection> createState() => _BookingsSectionState();
}

class _BookingsSectionState extends State<BookingsSection> {
  List<Map<String, dynamic>> _bookings = [];

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/bookings');
      if (data != null && data is List) {
        setState(() {
          _bookings = List<Map<String, dynamic>>.from(data);
        });
      } else {
        setState(() {
          _bookings = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load bookings')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching bookings: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bookings', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 16),
          if (authProvider.isLoading) const Center(child: CircularProgressIndicator()),
          if (authProvider.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Error: ${authProvider.error}', style: const TextStyle(color: Colors.red)),
            ),
          if (_bookings.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No bookings available'),
              ),
            ),
          ..._bookings.asMap().entries.map((entry) {
            final index = entry.key;
            final booking = entry.value;
            return _buildBookingCard(context, index, booking);
          }),
        ],
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, int index, Map<String, dynamic> booking) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF080F2B).withOpacity(0.1),
              child: const Icon(Icons.event, color: Color(0xFF080F2B)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Booking #${booking['id'] ?? 'N/A'}', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Date: ${booking['date'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                  Text('Time: ${booking['time'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                  Text('Service: ${booking['service_name'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                  Text('Status: ${booking['status'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                try {
                  final data = await authProvider.makeRequest(
                    method: 'DELETE',
                    endpoint: '/api/v1/bookings/${booking['id']}',
                  );
                  if (data != null) {
                    await _fetchBookings();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Booking deleted')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(authProvider.error ?? 'Error deleting booking')));
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class ProvidersSection extends StatefulWidget {
  const ProvidersSection({Key? key}) : super(key: key);

  @override
  State<ProvidersSection> createState() => _ProvidersSectionState();
}

class _ProvidersSectionState extends State<ProvidersSection> {
  List<Map<String, dynamic>> _providers = [];
  List<Map<String, dynamic>> _activityLogs = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      if (authProvider.userType == 'super_admin') {
        final providersData = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/providers');
        if (providersData != null && providersData is List) {
          setState(() {
            _providers = List<Map<String, dynamic>>.from(providersData);
          });
        } else {
          setState(() {
            _providers = [];
          });
        }
      }
      String endpoint;
      if (authProvider.userType == 'super_admin') {
        endpoint = '/api/v1/providers/activity';
      } else if (authProvider.userId != null) {
        endpoint = '/api/v1/providers/activity/${authProvider.userId}';
      } else {
        setState(() {
          _activityLogs = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User ID not available')));
        return;
      }
      final activityData = await authProvider.makeRequest(method: 'GET', endpoint: endpoint);
      if (activityData != null && activityData is List) {
        setState(() {
          _activityLogs = List<Map<String, dynamic>>.from(activityData);
        });
      } else {
        setState(() {
          _activityLogs = [];
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching data: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Providers', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 16),
          if (authProvider.isLoading) const Center(child: CircularProgressIndicator()),
          if (authProvider.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Error: ${authProvider.error}', style: const TextStyle(color: Colors.red)),
            ),
          if (authProvider.userType == 'super_admin') ...[
            const Text('All Providers', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (_providers.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('No providers available'),
                ),
              ),
            ..._providers.asMap().entries.map((entry) {
              final index = entry.key;
              final provider = entry.value;
              return _buildProviderCard(context, index, provider);
            }),
            const SizedBox(height: 16),
          ],
          const Text('Activity Logs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (_activityLogs.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No activity logs available'),
              ),
            ),
          ..._activityLogs.asMap().entries.map((entry) {
            final index = entry.key;
            final log = entry.value;
            return _buildActivityCard(context, index, log);
          }),
        ],
      ),
    );
  }

  Widget _buildProviderCard(BuildContext context, int index, Map<String, dynamic> provider) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF080F2B).withOpacity(0.1),
              child: const Icon(Icons.work, color: Color(0xFF080F2B)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(provider['name'] ?? 'N/A', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('ID: ${provider['id'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                  Text('Email: ${provider['email'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, int index, Map<String, dynamic> log) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF080F2B).withOpacity(0.1),
              child: Icon(log['action'] == 'login' ? Icons.login : Icons.logout, color: const Color(0xFF080F2B)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    log['action'] == 'login' ? 'Login' : 'Logout',
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('Provider ID: ${log['provider_id'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                  Text('Time: ${log['timestamp'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackSection extends StatefulWidget {
  const FeedbackSection({Key? key}) : super(key: key);

  @override
  State<FeedbackSection> createState() => _FeedbackSectionState();
}

class _FeedbackSectionState extends State<FeedbackSection> {
  List<Map<String, dynamic>> _feedbacks = [];

  @override
  void initState() {
    super.initState();
    _fetchFeedbacks();
  }

  Future<void> _fetchFeedbacks() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/feedback');
      if (data != null && data is List) {
        setState(() {
          _feedbacks = List<Map<String, dynamic>>.from(data);
        });
      } else {
        setState(() {
          _feedbacks = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load feedback')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching feedback: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Feedback', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 16),
          if (authProvider.isLoading) const Center(child: CircularProgressIndicator()),
          if (authProvider.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Error: ${authProvider.error}', style: const TextStyle(color: Colors.red)),
            ),
          if (_feedbacks.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No feedback available'),
              ),
            ),
          ..._feedbacks.asMap().entries.map((entry) {
            final index = entry.key;
            final feedback = entry.value;
            return _buildFeedbackCard(context, index, feedback);
          }),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard(BuildContext context, int index, Map<String, dynamic> feedback) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF080F2B).withOpacity(0.1),
              child: const Icon(Icons.feedback, color: Color(0xFF080F2B)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Feedback #${feedback['id'] ?? 'N/A'}', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Rating: ${feedback['rating'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                  Text('Comment: ${feedback['comment'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                  Text('Submitted: ${feedback['created_at'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsSection extends StatefulWidget {
  const NotificationsSection({Key? key}) : super(key: key);

  @override
  State<NotificationsSection> createState() => _NotificationsSectionState();
}

class _NotificationsSectionState extends State<NotificationsSection> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  List<Map<String, dynamic>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _fetchNotifications() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/notifications');
      if (data != null && data is List) {
        setState(() {
          _notifications = List<Map<String, dynamic>>.from(data);
        });
      } else {
        setState(() {
          _notifications = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load notifications')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching notifications: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notifications', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Notification Title',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.title),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter title' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.message),
                      ),
                      maxLines: 3,
                      validator: (value) => value!.isEmpty ? 'Enter message' : null,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: authProvider.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final data = await authProvider.makeRequest(
                                    method: 'POST',
                                    endpoint: '/api/v1/notifications',
                                    body: {
                                      'title': _titleController.text,
                                      'message': _messageController.text,
                                    },
                                  );
                                  if (data != null) {
                                    _titleController.clear();
                                    _messageController.clear();
                                    await _fetchNotifications();
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification added')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(authProvider.error ?? 'Error adding notification')));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                                }
                              }
                            },
                      child: const Text('Add Notification'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (authProvider.isLoading) const Center(child: CircularProgressIndicator()),
          if (authProvider.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Error: ${authProvider.error}', style: const TextStyle(color: Colors.red)),
            ),
          ..._notifications.asMap().entries.map((entry) {
            final index = entry.key;
            final notification = entry.value;
            return _buildNotificationCard(context, index, notification);
          }),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, int index, Map<String, dynamic> notification) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF080F2B).withOpacity(0.1),
              child: const Icon(Icons.notifications, color: Color(0xFF080F2B)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification['title'] ?? 'N/A', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(notification['message'] ?? 'N/A', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    _titleController.text = notification['title'] ?? '';
                    _messageController.text = notification['message'] ?? '';
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Edit Notification'),
                        content: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(labelText: 'Notification Title'),
                                  validator: (value) => value!.isEmpty ? 'Enter title' : null,
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _messageController,
                                  decoration: const InputDecoration(labelText: 'Message'),
                                  maxLines: 3,
                                  validator: (value) => value!.isEmpty ? 'Enter message' : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final data = await authProvider.makeRequest(
                                    method: 'PUT',
                                    endpoint: '/api/v1/notifications/${notification['id']}',
                                    body: {
                                      'title': _titleController.text,
                                      'message': _messageController.text,
                                    },
                                  );
                                  if (data != null) {
                                    await _fetchNotifications();
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification updated')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(authProvider.error ?? 'Error updating notification')));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                                }
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () async {
                    try {
                      final data = await authProvider.makeRequest(
                        method: 'DELETE',
                        endpoint: '/api/v1/notifications/${notification['id']}',
                      );
                      if (data != null) {
                        await _fetchNotifications();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification deleted')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(authProvider.error ?? 'Error deleting notification')));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TermsSection extends StatefulWidget {
  const TermsSection({Key? key}) : super(key: key);

  @override
  State<TermsSection> createState() => _TermsSectionState();
}

class _TermsSectionState extends State<TermsSection> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTerms();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _fetchTerms() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/terms');
      if (data != null && data is Map<String, dynamic>) {
        setState(() {
          _contentController.text = data['content'] ?? '';
        });
      } else {
        setState(() {
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load terms')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching terms: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Terms', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _contentController,
                      decoration: InputDecoration(
                        labelText: 'Terms Content',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.description),
                      ),
                      maxLines: 10,
                      validator: (value) => value!.isEmpty ? 'Enter terms content' : null,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: authProvider.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final data = await authProvider.makeRequest(
                                    method: 'PUT',
                                    endpoint: '/api/v1/terms',
                                    body: {
                                      'content': _contentController.text,
                                    },
                                  );
                                  if (data != null) {
                                    await _fetchTerms();
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Terms updated')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(authProvider.error ?? 'Error updating terms')));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                                }
                              }
                            },
                      child: const Text('Update Terms'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (authProvider.isLoading) const Center(child: CircularProgressIndicator()),
          if (authProvider.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Error: ${authProvider.error}', style: const TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }
}

class ScreensSection extends StatefulWidget {
  const ScreensSection({Key? key}) : super(key: key);

  @override
  State<ScreensSection> createState() => _ScreensSectionState();
}

class _ScreensSectionState extends State<ScreensSection> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _selectedImage;
  List<Map<String, dynamic>> _screens = [];
  int? _editingIndex;

  @override
  void initState() {
    super.initState();
    _loadScreens();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadScreens() async {
    final prefs = await SharedPreferences.getInstance();
    final screensJson = prefs.getString('onboarding_screens') ?? '[]';
    setState(() {
      _screens = List<Map<String, dynamic>>.from(jsonDecode(screensJson));
    });
  }

  Future<void> _saveScreens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('onboarding_screens', jsonEncode(_screens));
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);
      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedImage = File(result.files.single.path!);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    if (authProvider.userType != 'super_admin') {
      return const Center(child: Text('Access restricted to super admins'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Onboarding Screens', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Screen Title',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.title),
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter title' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.description),
                      ),
                      maxLines: 3,
                      validator: (value) => value!.isEmpty ? 'Enter description' : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedImage != null ? _selectedImage!.path.split('/').last : 'No image selected',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('Pick Image'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() && _selectedImage != null) {
                          final screen = {
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'image_path': _selectedImage!.path,
                          };
                          setState(() {
                            if (_editingIndex != null) {
                              _screens[_editingIndex!] = screen;
                              _editingIndex = null;
                            } else {
                              _screens.add(screen);
                            }
                          });
                          await _saveScreens();
                          _titleController.clear();
                          _descriptionController.clear();
                          _selectedImage = null;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(_editingIndex == null ? 'Screen added' : 'Screen updated')));
                        } else if (_selectedImage == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text('Please select an image')));
                        }
                      },
                      child: Text(_editingIndex == null ? 'Add Screen' : 'Update Screen'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ..._screens.asMap().entries.map((entry) {
            final index = entry.key;
            final screen = entry.value;
            return _buildScreenCard(context, index, screen);
          }),
        ],
      ),
    );
  }

  Widget _buildScreenCard(BuildContext context, int index, Map<String, dynamic> screen) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF080F2B).withOpacity(0.1),
              child: const Icon(Icons.phone_android, color: Color(0xFF080F2B)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(screen['title'] ?? 'N/A', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Description: ${screen['description'] ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                  Text('Image: ${screen['image_path']?.split('/').last ?? 'N/A'}', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _editingIndex = index;
                      _titleController.text = screen['title'] ?? '';
                      _descriptionController.text = screen['description'] ?? '';
                      _selectedImage = File(screen['image_path']);
                    });
                  },
                  icon: const Icon(Icons.edit, color: Colors.blue),
                ),
                IconButton(
                  onPressed: () async {
                    setState(() {
                      _screens.removeAt(index);
                    });
                    await _saveScreens();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Screen deleted')));
                  },
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatSection extends StatefulWidget {
  const ChatSection({Key? key}) : super(key: key);

  @override
  State<ChatSection> createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection> {
  String? _selectedUserId;
  List<Map<String, dynamic>> _users = [];
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _fetchUsers() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/users');
      if (data != null && data is List) {
        setState(() {
          _users = List<Map<String, dynamic>>.from(data);
        });
      } else {
        setState(() {
          _users = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load users')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching users: $e')));
    }
  }

  String _getChatId(String adminId, String userId) {
    return adminId.compareTo(userId) < 0 ? '${adminId}_$userId' : '${userId}_$adminId';
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    if (authProvider.userType == 'provider') {
      return const Center(
        child: Text('Access restricted to admins.', style: TextStyle(color: Colors.red, fontSize: 18)),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Live Chat', style: theme.textTheme.headlineLarge),
          const SizedBox(height: 16),
          if (authProvider.isLoading) const Center(child: CircularProgressIndicator()),
          if (authProvider.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Error: ${authProvider.error}', style: const TextStyle(color: Colors.red)),
            ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select User to Chat', style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  if (_users.isEmpty)
                    const Text('No users available', style: TextStyle(color: Colors.grey)),
                  ..._users.map((user) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFF080F2B).withOpacity(0.1),
                          child: const Icon(Icons.person, color: Color(0xFF080F2B)),
                        ),
                        title: Text(user['name'] ?? 'N/A', style: theme.textTheme.bodyLarge),
                        subtitle: Text(user['email'] ?? 'N/A', style: theme.textTheme.bodyMedium),
                        selected: _selectedUserId == user['id']?.toString(),
                        selectedTileColor: const Color(0xFF080F2B).withOpacity(0.1),
                        onTap: () {
                          setState(() {
                            _selectedUserId = user['id']?.toString();
                          });
                        },
                      )),
                ],
              ),
            ),
          ),
          if (_selectedUserId != null && authProvider.userId != null) ...[
            const SizedBox(height: 16),
            _buildChatInterface(context, authProvider.userId!, _selectedUserId!),
          ],
        ],
      ),
    );
  }

  Widget _buildChatInterface(BuildContext context, String adminId, String userId) {
    final theme = Theme.of(context);
    final chatId = _getChatId(adminId, userId);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chat with User', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 8),
            Container(
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('chats')
                    .doc(chatId)
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No messages yet', style: TextStyle(color: Colors.grey)));
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index].data() as Map<String, dynamic>;
                      final isAdmin = message['senderId'] == adminId;

                      return Align(
                        alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isAdmin ? const Color(0xFF080F2B) : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                isAdmin ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['text'] ?? '',
                                style: TextStyle(
                                  color: isAdmin ? Colors.white : Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _formatTimestamp(message['timestamp']),
                                style: TextStyle(
                                  color: isAdmin ? Colors.white70 : Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Type a message',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      prefixIcon: const Icon(Icons.message),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    if (_messageController.text.trim().isEmpty) return;

                    try {
                      await FirebaseFirestore.instance
                          .collection('chats')
                          .doc(chatId)
                          .collection('messages')
                          .add({
                        'senderId': adminId,
                        'receiverId': userId,
                        'text': _messageController.text.trim(),
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      _messageController.clear();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error sending message: $e')),
                      );
                    }
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      final dateTime = timestamp.toDate();
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
    return 'N/A';
  }
}



