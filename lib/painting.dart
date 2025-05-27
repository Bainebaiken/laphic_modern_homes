import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:laphic_app/booking.dart';
import 'package:laphic_app/livechat.dart';
import 'package:laphic_app/painting_details.dart'; // Assuming PaintingDetailsScreen is here
import 'package:laphic_app/profile_screen.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';

// GalleryItem model (shared across screens)
class GalleryItem {
  final int id;
  final int serviceId;
  final String imageName;
  final String imageDescription;
  final String imagePath;
  final double minCost;
  final double maxCost;
  final double? minSquareMeters;
  final double? maxSquareMeters;
  final String? category;

  GalleryItem({
    required this.id,
    required this.serviceId,
    required this.imageName,
    required this.imageDescription,
    required this.imagePath,
    required this.minCost,
    required this.maxCost,
    this.minSquareMeters,
    this.maxSquareMeters,
    this.category,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      id: json['id'],
      serviceId: json['Service_ID'],
      imageName: json['Image_Name'],
      imageDescription: json['Image_Description'] ?? '',
      imagePath: json['Image_Path'],
      minCost: (json['Min_Cost'] as num?)?.toDouble() ?? 0.0,
      maxCost: (json['Max_Cost'] as num?)?.toDouble() ?? 0.0,
      minSquareMeters: json['Min_Square_Meters']?.toDouble(),
      maxSquareMeters: json['Max_Square_Meters']?.toDouble(),
      category: json['Category'],
    );
  }

  Map<String, String> toMap() {
    return {
      'title': imageName,
      'price': '${minCost.toInt()} UGX',
      'image': imagePath,
      'description': imageDescription,
    };
  }
}

class PaintingPage extends StatefulWidget {
  const PaintingPage({Key? key}) : super(key: key);

  @override
  _PaintingPageState createState() => _PaintingPageState();
}

class _PaintingPageState extends State<PaintingPage> {
  int _currentImageIndex = 0;
  Timer? _imageTimer;
  final PageController _pageController = PageController();
  int _navIndex = 1; // Painting is index 1 (adjust based on your navigation)
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredPaintingWorks = [];
  List<GalleryItem> _galleryItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  // Replace with your Flask backend URL
  final String _baseUrl = 'http://your-backend-url:5000/api/gallery';
  final int _serviceId = 2; // Painting Service_ID

  @override
  void initState() {
    super.initState();
    _fetchGalleryItems();
    _searchController.addListener(_filterPaintingWorks);
  }

  Future<void> _fetchGalleryItems() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(Uri.parse('$_baseUrl/service/$_serviceId'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _galleryItems = data.map((json) => GalleryItem.fromJson(json)).toList();
          _filteredPaintingWorks = _galleryItems.map((item) => item.toMap()).toList();
          _isLoading = false;
          _startTimer();
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load painting works';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _uploadImage({
    required int serviceId,
    required String imageName,
    required String imageDescription,
    required File imageFile,
    required double minCost,
    required double maxCost,
    double? minSquareMeters,
    double? maxSquareMeters,
    String? category,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl/upload'),
      );

      request.fields['Service_ID'] = serviceId.toString();
      request.fields['Image_Name'] = imageName;
      request.fields['Image_Description'] = imageDescription;
      request.fields['Min_Cost'] = minCost.toString();
      request.fields['Max_Cost'] = maxCost.toString();
      if (minSquareMeters != null) request.fields['Min_Square_Meters'] = minSquareMeters.toString();
      if (maxSquareMeters != null) request.fields['Max_Square_Meters'] = maxSquareMeters.toString();
      if (category != null) request.fields['Category'] = category;

      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded successfully')),
        );
        await _fetchGalleryItems();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload image')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _filterPaintingWorks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredPaintingWorks = _galleryItems.map((item) => item.toMap()).toList();
      } else {
        _filteredPaintingWorks = _galleryItems
            .where((item) =>
                item.imageName.toLowerCase().contains(query) ||
                item.imageDescription.toLowerCase().contains(query))
            .map((item) => item.toMap())
            .toList();
      }
    });
  }

  void _startTimer() {
    if (_galleryItems.isEmpty) return;
    _imageTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted && _pageController.hasClients) {
        setState(() {
          _currentImageIndex = (_currentImageIndex + 1) % _galleryItems.length;
          _pageController.animateToPage(
            _currentImageIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _imageTimer?.cancel();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == _navIndex) return;
    setState(() {
      _navIndex = index;
    });
    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const ServicesHomePage();
        break;
      case 1:
        nextScreen = const PaintingPage();
        break;
      case 2:
        nextScreen = const OngoingProjects();
        break;
      case 3:
        nextScreen = const BookingScreen(initialDesign: '', initialServiceType: '');
        break;
      case 4:
        nextScreen = const ProfilePage();
        break;
      case 5:
        nextScreen = const ChatPage();
        break;
      default:
        return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.grey.shade50,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black87),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search painting works...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                  ),
                  autofocus: true,
                )
              : const Text(
                  'Painting Services',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search,
                  color: Colors.black87),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchController.clear();
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.black87),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
              },
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.orange))
            : _errorMessage != null
                ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)))
                : RefreshIndicator(
                    color: Colors.orange,
                    onRefresh: _fetchGalleryItems,
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: _buildCarousel(),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          sliver: SliverToBoxAdapter(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Our Painting Works",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                TextButton.icon(
                                  icon: const Icon(Icons.filter_list, color: Colors.orange),
                                  label: const Text(
                                    "Filter",
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  onPressed: () {
                                    _showFilterBottomSheet(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: _filteredPaintingWorks.isEmpty
                              ? SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.search_off,
                                              size: 48, color: Colors.grey.shade400),
                                          const SizedBox(height: 16),
                                          Text(
                                            'No results found',
                                            style: TextStyle(color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : SliverGrid(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.7,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      final work = _filteredPaintingWorks[index];
                                      final String image = work['image'] ?? '';
                                      final String title = work['title'] ?? 'Unknown Work';
                                      final String price = work['price'] ?? 'N/A';

                                      return Semantics(
                                        label: 'Painting work: $title, Price: $price',
                                        child: Hero(
                                          tag: 'painting_work_$index',
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (_, animation, __) =>
                                                        FadeTransition(
                                                      opacity: animation,
                                                      child: PaintingDetailsScreen(
                                                          design: work),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                elevation: 4,
                                                shadowColor: Colors.black12,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.stretch,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Stack(
                                                        fit: StackFit.expand,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .vertical(
                                                                    top:
                                                                        Radius.circular(
                                                                            16)),
                                                            child: Image.network(
                                                              '$_baseUrl/images/$image',
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) {
                                                                return Container(
                                                                  color: Colors
                                                                      .grey.shade200,
                                                                  child: const Center(
                                                                    child: Icon(
                                                                        Icons
                                                                            .broken_image,
                                                                        size: 32,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                );
                                                              },
                                                              loadingBuilder: (context,
                                                                  child,
                                                                  loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null)
                                                                  return child;
                                                                return const Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 8,
                                                            right: 8,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors.white
                                                                    .withOpacity(
                                                                        0.7),
                                                                shape:
                                                                    BoxShape.circle,
                                                              ),
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    size: 20),
                                                                color: Colors.red,
                                                                onPressed: () {
                                                                  ScaffoldMessenger
                                                                          .of(context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content: Text(
                                                                          'Added $title to favorites'),
                                                                      duration:
                                                                          const Duration(
                                                                              seconds:
                                                                                  1),
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                12.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              title,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                              maxLines: 1,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                            Text(
                                                              price,
                                                              style: TextStyle(
                                                                color: Colors.orange
                                                                    .shade800,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.star,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .amber
                                                                        .shade700),
                                                                Icon(Icons.star,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .amber
                                                                        .shade700),
                                                                Icon(Icons.star,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .amber
                                                                        .shade700),
                                                                Icon(Icons.star,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .amber
                                                                        .shade700),
                                                                Icon(
                                                                    Icons.star_half,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .amber
                                                                        .shade700),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    childCount: _filteredPaintingWorks.length,
                                  ),
                                ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: 20),
                        ),
                      ],
                    ),
                  ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingScreen(
                      initialDesign: '',
                      initialServiceType: 'Painting',
                    ),
                  ),
                );
              },
              tooltip: 'Make a booking',
              child: const Icon(Icons.add_shopping_cart),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  await _uploadImage(
                    serviceId: _serviceId,
                    imageName: 'New Painting Design',
                    imageDescription: 'Custom painting design',
                    imageFile: File(pickedFile.path),
                    minCost: 500000,
                    maxCost: 500000,
                    category: 'Interior', // Optional
                  );
                }
              },
              tooltip: 'Upload new painting design',
              child: const Icon(Icons.upload),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _navIndex,
          onTap: _onNavTap,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey.shade600,
          backgroundColor: Colors.white,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.brush), label: 'Painting'),
            BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Projects'),
            BottomNavigationBarItem(icon: Icon(Icons.book_online), label: 'Booking'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter Painting Works',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Price Range',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RangeSlider(
                    values: const RangeValues(100000, 1000000),
                    min: 100000,
                    max: 2000000,
                    divisions: 19,
                    labels: const RangeLabels('100K UGX', '1M UGX'),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _filteredPaintingWorks = _galleryItems
                            .where((item) =>
                                item.minCost >= values.start &&
                                item.maxCost <= values.end)
                            .map((item) => item.toMap())
                            .toList();
                      });
                    },
                    activeColor: Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('Interior'),
                        selected: true,
                        onSelected: (bool selected) {
                          // Implement category filtering via API
                        },
                        selectedColor: Colors.orange.withOpacity(0.2),
                        checkmarkColor: Colors.orange,
                      ),
                      FilterChip(
                        label: const Text('Exterior'),
                        selected: false,
                        onSelected: (bool selected) {},
                      ),
                      FilterChip(
                        label: const Text('Accent Walls'),
                        selected: false,
                        onSelected: (bool selected) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Colors.orange),
                          ),
                          onPressed: () {
                            setState(() {
                              _filteredPaintingWorks =
                                  _galleryItems.map((item) => item.toMap()).toList();
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Reset',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCarousel() {
    if (_galleryItems.isEmpty) {
      return const SizedBox(
        height: 160,
        child: Center(child: Text('No images available', style: TextStyle(color: Colors.grey))),
      );
    }
    return Container(
      height: 200,
      margin: const EdgeInsets.only(top: 8),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
              _imageTimer?.cancel();
              _startTimer();
            },
            itemCount: _galleryItems.length,
            itemBuilder: (context, index) {
              final item = _galleryItems[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        '$_baseUrl/images/${item.imagePath}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 32, color: Colors.grey),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(color: Colors.orange),
                          );
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.imageName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.imageDescription,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _galleryItems.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentImageIndex == index ? 20 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentImageIndex == index
                        ? Colors.orange
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}