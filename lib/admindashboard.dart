import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'package:permission_handler/permission_handler.dart'; 

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  String _activeSection = 'overview';
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _isSidebarExpanded = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  Map<String, dynamic> _dashboardStats = {};
  bool _isLoading = true;

  final List<Map<String, dynamic>> _sections = [
    {'name': 'overview', 'title': 'Overview', 'icon': Icons.dashboard_outlined},
    {'name': 'services', 'title': 'Services', 'icon': Icons.build_outlined},
    {'name': 'gallery', 'title': 'Gallery', 'icon': Icons.image_outlined},
    {'name': 'users', 'title': 'Users', 'icon': Icons.people_outline},
    {'name': 'bookings', 'title': 'Bookings', 'icon': Icons.event_outlined},
    {'name': 'providers', 'title': 'Providers', 'icon': Icons.work_outline},
    {'name': 'feedback', 'title': 'Feedback', 'icon': Icons.feedback_outlined},
    {'name': 'notifications', 'title': 'Notifications', 'icon': Icons.notifications_outlined},
    {'name': 'terms', 'title': 'Terms', 'icon': Icons.description_outlined},
    {'name': 'screens', 'title': 'Screens', 'icon': Icons.phone_android_outlined},
    {'name': 'chat', 'title': 'Live Chat', 'icon': Icons.chat_outlined},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      
      // Fetch summary statistics with null checks
      final usersSnapshot = await firestore.collection('users').count().get();
      final bookingsSnapshot = await firestore.collection('bookings').count().get();
      final providersSnapshot = await firestore.collection('providers').count().get();
      final servicesSnapshot = await firestore.collection('services').count().get();
      
      // Fetch recent activities
      final recentActivities = await firestore
          .collection('activities')
          .orderBy('timestamp', descending: true)
          .limit(5)
          .get();
          
      setState(() {
        _dashboardStats = {
          'users': usersSnapshot.count ?? 0, // Added null check
          'bookings': bookingsSnapshot.count ?? 0,
          'providers': providersSnapshot.count ?? 0,
          'services': servicesSnapshot.count ?? 0,
          'recentActivities': recentActivities.docs.map((doc) => doc.data()).toList(),
        };
        _isLoading = false;
      });
    } catch (e, stackTrace) {
      // Enhanced error logging
      if (kDebugMode) {
        print('Error loading dashboard data: $e, StackTrace: $stackTrace');
      }
      setState(() {
        _dashboardStats = {
          'users': 1250,
          'bookings': 328,
          'providers': 87,
          'services': 42,
          'recentActivities': [
            {
              'type': 'booking',
              'user': 'mariam',
              'timestamp': Timestamp.now(),
              'details': 'Booked a cleaning service'
            },
            {
              'type': 'new_user',
              'user': 'lumala',
              'timestamp': Timestamp.now(),
              'details': 'Created an account'
            },
            {
              'type': 'feedback',
              'user': 'henry',
              'timestamp': Timestamp.now(),
              'details': 'Left a 5-star review'
            },
          ],
        };
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load dashboard data: $e')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF080F2B),
        elevation: 0,
        leading: isDesktop
            ? IconButton(
                icon: Icon(_isSidebarExpanded ? Icons.menu_open : Icons.menu),
                onPressed: () {
                  setState(() {
                    _isSidebarExpanded = !_isSidebarExpanded;
                  });
                },
              )
            : IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
        title: Row(
          children: [
            Image.asset(
              'assets/sharif-removebg-preview.png',
              height: 32,
              errorBuilder: (context, error, stackTrace) => const Text(
                'Laphic',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Admin',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implement notifications
            },
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.white24,
            radius: 16,
            child: Text(
              authProvider.userType?.isNotEmpty == true
                  ? authProvider.userType![0].toUpperCase()
                  : 'A', // Added null check
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          PopupMenuButton<String>(
            offset: const Offset(0, 45),
            icon: const Icon(Icons.keyboard_arrow_down),
            onSelected: (value) async {
              if (value == 'logout') {
                try {
                  await authProvider.logout();
                  if (mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const SplashScreen()),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out successfully')),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logout failed: $e')),
                    );
                  }
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Text('Profile'),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: isDesktop ? null : _buildDrawer(authProvider),
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(authProvider),
          
          Expanded(
            child: Container(
              color: const Color(0xFFF5F7FA),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _buildSection(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(AuthProvider authProvider) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: _isSidebarExpanded ? 250 : 70,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 20),
          if (_isSidebarExpanded) ...[
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFF080F2B).withOpacity(0.1),
              child: Text(
                authProvider.userType?.isNotEmpty == true
                    ? authProvider.userType![0].toUpperCase()
                    : 'A', // Added null check
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF080F2B),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              authProvider.userType?.toUpperCase() ?? 'ADMIN',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              authProvider.email ?? 'admin@laphic.com',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const Divider(height: 30),
          ],
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _sections.length,
              itemBuilder: (context, index) {
                final section = _sections[index];
                final bool isActive = _activeSection == section['name'];
                
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: _isSidebarExpanded ? 8 : 4,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isActive
                        ? const Color(0xFF080F2B).withOpacity(0.1)
                        : Colors.transparent,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: _isSidebarExpanded ? 16 : 0,
                      vertical: 2,
                    ),
                    leading: Icon(
                      section['icon'] as IconData,
                      color: isActive
                          ? const Color(0xFF080F2B)
                          : Colors.grey[600],
                      size: 22,
                    ),
                    title: _isSidebarExpanded
                        ? Text(
                            section['title'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: isActive
                                  ? const Color(0xFF080F2B)
                                  : Colors.grey[800],
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          )
                        : null,
                    minLeadingWidth: 0,
                    horizontalTitleGap: 8,
                    onTap: () {
                      setState(() {
                        _activeSection = section['name'] as String;
                        _controller.reset();
                        _controller.forward();
                      });
                    },
                  ),
                );
              },
            ),
          ),
          if (_isSidebarExpanded) ...[
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_outlined, size: 22),
              title: const Text('Settings', style: TextStyle(fontSize: 14)),
              onTap: () {
                // TODO: Navigate to settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline, size: 22),
              title: const Text('Help', style: TextStyle(fontSize: 14)),
              onTap: () {
                // TODO: Navigate to help
              },
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }

  Widget _buildDrawer(AuthProvider authProvider) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF080F2B), Color(0xFF1A2A6C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                authProvider.userType?.isNotEmpty == true
                    ? authProvider.userType![0].toUpperCase()
                    : 'A', // Added null check
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF080F2B),
                ),
              ),
            ),
            accountName: Text(
              authProvider.userType?.toUpperCase() ?? 'ADMIN',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            accountEmail: Text(
              authProvider.userEmail ?? 'admin@laphic.com', 
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _sections.length,
              itemBuilder: (context, index) {
                final section = _sections[index];
                final bool isActive = _activeSection == section['name'];
                
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isActive
                        ? const Color(0xFF080F2B).withOpacity(0.1)
                        : Colors.transparent,
                  ),
                  child: ListTile(
                    leading: Icon(
                      section['icon'] as IconData,
                      color: isActive
                          ? const Color(0xFF080F2B)
                          : Colors.grey[600],
                    ),
                    title: Text(
                      section['title'] as String,
                      style: TextStyle(
                        color: isActive
                            ? const Color(0xFF080F2B)
                            : Colors.grey[800],
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
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
                  ),
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              try {
                await authProvider.logout();
                if (mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SplashScreen()),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logout failed: $e')),
                  );
                }
              }
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSection() {
    switch (_activeSection) {
      case 'overview':
        return OverviewSection(stats: _dashboardStats, isLoading: _isLoading);
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
  final Map<String, dynamic> stats;
  final bool isLoading;

  const OverviewSection({
    Key? key,
    required this.stats,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildStatsGrid(context),
          const SizedBox(height: 24),
          _buildChartsSection(),
          const SizedBox(height: 24),
          _buildRecentActivitiesCard(),
        ],
      ),
    );
  }

  // === HEADER SECTION ===
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildHeaderTitle(),
        _buildRefreshButton(),
      ],
    );
  }

  Widget _buildHeaderTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dashboard Overview',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now()),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildRefreshButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF080F2B),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      icon: const Icon(Icons.refresh),
      label: const Text('Refresh Data'),
      onPressed: null, // TODO: Implement refresh functionality
    );
  }

  // === STATS GRID SECTION ===
  Widget _buildStatsGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: _getGridCount(context),
          childAspectRatio: constraints.maxWidth > 1200 ? 1.5 : 1.3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: _getStatCards(),
        );
      },
    );
  }

  int _getGridCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 2;
    return 1;
  }

  List<Widget> _getStatCards() {
    return [
      _buildStatCard(
        title: 'Total Users',
        value: (stats['users'] as num?)?.toInt() ?? 0,
        icon: Icons.people,
        color: const Color(0xFF4A6FFF),
        trend: '+12%',
      ),
      _buildStatCard(
        title: 'Active Bookings',
        value: (stats['bookings'] as num?)?.toInt() ?? 0,
        icon: Icons.calendar_today,
        color: const Color(0xFF00C48C),
        trend: '+5%',
      ),
      _buildStatCard(
        title: 'Service Providers',
        value: (stats['providers'] as num?)?.toInt() ?? 0,
        icon: Icons.work,
        color: const Color(0xFFFFA26B),
        trend: '+8%',
      ),
      _buildStatCard(
        title: 'Total Services',
        value: (stats['services'] as num?)?.toInt() ?? 0,
        icon: Icons.category,
        color: const Color(0xFF7D5CF5),
        trend: '+3%',
      ),
    ];
  }

  Widget _buildStatCard({
    required String title,
    required int value,
    required IconData icon,
    required Color color,
    required String trend,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCardHeader(title, icon, color),
            const SizedBox(height: 16),
            _buildStatCardContent(value, trend),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCardHeader(String title, IconData icon, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCardContent(int value, String trend) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            trend,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // === CHARTS SECTION ===
  Widget _buildChartsSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildRevenueChart(constraints),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: _buildUserDistributionChart(constraints),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRevenueChart(BoxConstraints constraints) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRevenueChartHeader(),
            const SizedBox(height: 8),
            _buildLineChart(constraints),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueChartHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Revenue Overview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton<String>(
          value: 'Monthly',
          underline: const SizedBox(),
          items: const [
            DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
            DropdownMenuItem(value: 'Monthly', child: Text('Monthly')),
            DropdownMenuItem(value: 'Yearly', child: Text('Yearly')),
          ],
          onChanged: null, // TODO: Implement dropdown functionality
        ),
      ],
    );
  }

  Widget _buildLineChart(BoxConstraints constraints) {
    return SizedBox(
      height: (constraints.maxHeight * 0.3).clamp(150, 300),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: _getLineChartTitlesData(),
          borderData: FlBorderData(show: true),
          lineBarsData: _getLineChartBarsData(),
        ),
      ),
    );
  }

  FlTitlesData _getLineChartTitlesData() {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => Text('\$${value.toInt()}'),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) => Text('${value.toInt()}'),
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  List<LineChartBarData> _getLineChartBarsData() {
    return [
      LineChartBarData(
        spots: const [
          FlSpot(0, 3),
          FlSpot(1, 1),
          FlSpot(2, 4),
          FlSpot(3, 2),
          FlSpot(4, 5),
          FlSpot(5, 3),
        ],
        isCurved: true,
        color: const Color(0xFF4A6FFF),
        barWidth: 3,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: const Color(0xFF4A6FFF).withOpacity(0.1),
        ),
      ),
    ];
  }

  Widget _buildUserDistributionChart(BoxConstraints constraints) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Distribution',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPieChart(constraints),
            const SizedBox(height: 16),
            _buildChartLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(BoxConstraints constraints) {
    return SizedBox(
      height: (constraints.maxHeight * 0.25).clamp(120, 250),
      child: PieChart(
        PieChartData(
          sections: _getPieChartSections(),
          centerSpaceRadius: 40,
          sectionsSpace: 2,
        ),
      ),
    );
  }

  List<PieChartSectionData> _getPieChartSections() {
    const chartData = [
      ChartData('New Users', 40, Color(0xFF4A6FFF)),
      ChartData('Regular Users', 30, Color(0xFF00C48C)),
      ChartData('Premium Users', 15, Color(0xFFFFA26B)),
      ChartData('Business Users', 15, Color(0xFF7D5CF5)),
    ];

    return chartData.map((data) {
      return PieChartSectionData(
        color: data.color,
        value: data.value.toDouble(),
        title: '${data.value}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildChartLegend() {
    const legendItems = [
      ChartLegendItem('New Users', Color(0xFF4A6FFF), '40%'),
      ChartLegendItem('Regular Users', Color(0xFF00C48C), '30%'),
      ChartLegendItem('Premium Users', Color(0xFFFFA26B), '15%'),
      ChartLegendItem('Business Users', Color(0xFF7D5CF5), '15%'),
    ];

    return Column(
      children: legendItems.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: item.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item.label,
                style: const TextStyle(fontSize: 12),
              ),
              const Spacer(),
              Text(
                item.value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // === RECENT ACTIVITIES SECTION ===
  Widget _buildRecentActivitiesCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRecentActivitiesHeader(),
            const SizedBox(height: 16),
            _buildRecentActivitiesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitiesHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Activities',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'View All',
          style: TextStyle(
            color: Color(0xFF4A6FFF),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivitiesList() {
    final activities = stats['recentActivities'] as List? ?? [];

    if (activities.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No recent activities'),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) => _buildActivityListItem(activities[index]),
    );
  }

  Widget _buildActivityListItem(dynamic activityData) {
    final activity = activityData is Map 
        ? activityData as Map<String, dynamic> 
        : <String, dynamic>{};

    final activityInfo = _getActivityInfo(activity['type'] as String?);
    final timestamp = _formatTimestamp(activity['timestamp']);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: _buildActivityIcon(activityInfo.icon, activityInfo.color),
      title: Text(
        activity['user'] as String? ?? 'Unknown User',
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        activity['details'] as String? ?? 'Activity details not available',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      trailing: Text(
        timestamp,
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildActivityIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }

  ActivityInfo _getActivityInfo(String? type) {
    switch (type) {
      case 'booking':
        return ActivityInfo(Icons.calendar_today, const Color(0xFF4A6FFF));
      case 'new_user':
        return ActivityInfo(Icons.person_add, const Color(0xFF00C48C));
      case 'feedback':
        return ActivityInfo(Icons.star, const Color(0xFFFFA26B));
      default:
        return ActivityInfo(Icons.notifications, const Color(0xFF7D5CF5));
    }
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return DateFormat('h:mm a').format(timestamp.toDate());
    }
    return 'N/A';
  }
}

// === DATA CLASSES ===
class ChartLegendItem {
  final String label;
  final Color color;
  final String value;

  const ChartLegendItem(this.label, this.color, this.value);
}

class ChartData {
  final String label;
  final int value;
  final Color color;

  const ChartData(this.label, this.value, this.color);
}

class ActivityInfo {
  final IconData icon;
  final Color color;

  const ActivityInfo(this.icon, this.color);
}

class ServicesSection extends StatefulWidget {
  const ServicesSection({Key? key}) : super(key: key);

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  final _formKey = GlobalKey<FormState>();
  final _editFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  
  
  // Edit controllers
  final _editNameController = TextEditingController();
  final _editCategoryController = TextEditingController();
  
  List<Map<String, dynamic>> _services = [];
  File? _selectedImage;
  File? _editSelectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _editNameController.dispose();
    _editCategoryController.dispose();
    super.dispose();
  }

  Future<void> _pickImage({bool isEdit = false}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null) {
        setState(() {
          if (isEdit) {
            _editSelectedImage = File(image.path);
          } else {
            _selectedImage = File(image.path);
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  Future<void> _fetchServices() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final data = await authProvider.makeRequest(
        method: 'GET', 
        endpoint: '/api/v1/services/all'
      );
      
      if (data != null && data is List) {
        setState(() {
          _services = List<Map<String, dynamic>>.from(data);
        });
      } else {
        setState(() {
          _services = [];
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No services found')),
          );
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error fetching services: $e, StackTrace: $stackTrace');
      }
      setState(() {
        _services = [];
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching services: $e')),
        );
      }
    }
  }

  Future<String?> _uploadImage(File imageFile, AuthProvider authProvider) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${authProvider.baseUrl}/api/v1/upload/image'),
      );
      
      // Add authorization header if needed
      if (authProvider.token != null) {
        request.headers['Authorization'] = 'Bearer ${authProvider.token}';
      }
      
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      
      if (response.statusCode == 200) {
        // Parse response to get image URL
        // Adjust this based on your API response format
        final data = json.decode(responseData);
        return data['imageUrl'] ?? data['url']; // Adjust key based on your API
      }
      
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return null;
    }
  }

  Future<void> _addService() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    setState(() {
      _isUploading = true;
    });

    try {
      String? imageUrl;
      
      // Upload image if selected
      if (_selectedImage != null) {
        imageUrl = await _uploadImage(_selectedImage!, authProvider);
        if (imageUrl == null) {
          throw Exception('Failed to upload image');
        }
      }

      // Create service with image URL
      final data = await authProvider.makeRequest(
        method: 'POST',
        endpoint: '/api/v1/services/register',
        body: {
          'Name': _nameController.text,
          'Category': _categoryController.text,
          if (imageUrl != null) 'ImageUrl': imageUrl,
        },
      );

      if (data != null && mounted) {
        _clearForm();
        await _fetchServices();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Service added successfully')),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.error ?? 'Error adding service'),
          ),
        );
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error adding service: $e, StackTrace: $stackTrace');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _clearForm() {
    _nameController.clear();
    _categoryController.clear();
    
    setState(() {
      _selectedImage = null;
    });
  }

  void _clearEditForm() {
    _editNameController.clear();
    _editCategoryController.clear();
    
    setState(() {
      _editSelectedImage = null;
    });
  }

  Future<void> _updateService(Map<String, dynamic> service) async {
    if (!_editFormKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    setState(() {
      _isUploading = true;
    });

    try {
      String? imageUrl = service['ImageUrl']; // Keep existing image URL
      
      // Upload new image if selected
      if (_editSelectedImage != null) {
        final newImageUrl = await _uploadImage(_editSelectedImage!, authProvider);
        if (newImageUrl != null) {
          imageUrl = newImageUrl;
        }
      }

      final data = await authProvider.makeRequest(
        method: 'PUT',
        endpoint: '/api/v1/services/update/${service['Service_ID']}',
        body: {
          'Name': _editNameController.text,
          'Category': _editCategoryController.text,
          
          if (imageUrl != null) 'ImageUrl': imageUrl,
        },
      );

      if (data != null && mounted) {
        await _fetchServices();
        Navigator.pop(context);
        _clearEditForm();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Service updated successfully')),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.error ?? 'Error updating service'),
          ),
        );
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error updating service: $e, StackTrace: $stackTrace');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _deleteService(Map<String, dynamic> service) async {
    // Show confirmation dialog
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Service'),
        content: Text('Are you sure you want to delete "${service['Name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      final data = await authProvider.makeRequest(
        method: 'DELETE',
        endpoint: '/api/v1/services/<int:service_id>/${service['Service_ID']}',
      );

      if (data != null && mounted) {
        await _fetchServices();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Service deleted successfully')),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.error ?? 'Error deleting service'),
          ),
        );
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error deleting service: $e, StackTrace: $stackTrace');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
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
          Text(
            'Services Management',
            style: theme.textTheme.headlineLarge ?? 
                   const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // Add Service Form
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Add New Service',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    
                    // Image Selection
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _selectedImage != null
                          ? Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: FileImage(_selectedImage!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 16,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          _selectedImage = null;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : InkWell(
                              onTap: () => _pickImage(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: 48,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tap to select image',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Service Form Fields
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Service Name *',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.build),
                      ),
                      validator: (value) => value?.isEmpty == true ? 'Enter service name' : null,
                    ),
                    const SizedBox(height: 12),
                    
                    TextFormField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        labelText: 'Category *',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.category),
                      ),
                      validator: (value) => value?.isEmpty == true ? 'Enter category' : null,
                    ),
                    const SizedBox(height: 12),
                    
                
                    
                    ElevatedButton(
                      onPressed: (_isUploading || authProvider.isLoading) ? null : _addService,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isUploading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Add Service'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Services List
          Text(
            'Current Services',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          
          if (authProvider.isLoading) 
            const Center(child: CircularProgressIndicator()),
          
          if (authProvider.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red.shade600),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Error: ${authProvider.error}',
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
          if (_services.isEmpty && !authProvider.isLoading)
            Container(
              padding: const EdgeInsets.all(32),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Icon(
                    Icons.build_circle_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No services found',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start by adding your first service',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          
          // Services Grid/List
          ...(_services.asMap().entries.map((entry) {
            final index = entry.key;
            final service = entry.value;
            return _buildServiceCard(context, index, service);
          })),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, int index, Map<String, dynamic> service) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Service Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade100,
              ),
              child: service['ImageUrl'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        service['ImageUrl'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.build_circle,
                          size: 40,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.build_circle,
                      size: 40,
                      color: Colors.grey.shade400,
                    ),
            ),
            const SizedBox(width: 16),
            
            // Service Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['Name'] ?? 'N/A',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.category, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        service['Category'] ?? 'N/A',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  
                  
                ]
              ),
            ),
            
            // Action Buttons
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _showEditDialog(service),
                  icon: const Icon(Icons.edit),
                  color: Colors.blue,
                  tooltip: 'Edit Service',
                ),
                IconButton(
                  onPressed: () => _deleteService(service),
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  tooltip: 'Delete Service',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(Map<String, dynamic> service) {
    // Populate edit controllers
    _editNameController.text = service['Name'] ?? '';
    _editCategoryController.text = service['Category'] ?? '';
   
    _editSelectedImage = null;

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Edit Service'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Form(
              key: _editFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Current/New Image
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _editSelectedImage != null
                        ? Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: FileImage(_editSelectedImage!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 12,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      setState(() {
                                        _editSelectedImage = null;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : service['ImageUrl'] != null
                            ? Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(service['ImageUrl']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: FloatingActionButton.small(
                                      onPressed: () => _pickImage(isEdit: true),
                                      child: const Icon(Icons.edit),
                                    ),
                                  ),
                                ],
                              )
                            : InkWell(
                                onTap: () => _pickImage(isEdit: true),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate,
                                      size: 32,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Tap to select image',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _editNameController,
                    decoration: const InputDecoration(
                      labelText: 'Service Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value?.isEmpty == true ? 'Enter service name' : null,
                  ),
                  const SizedBox(height: 12),
                  
                  TextFormField(
                    controller: _editCategoryController,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value?.isEmpty == true ? 'Enter category' : null,
                  ),
                  
                 
                  
                  
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _clearEditForm();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: _isUploading
                ? null
                : () async {
                    await _updateService(service);
                  },
            child: _isUploading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
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
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  List<Map<String, dynamic>> _gallery = [];
  bool _isUploading = false;
  String? _selectedFilePath;
  String? _selectedFileName;
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    _fetchGalleryItems();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _fetchGalleryItems() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/gallery/all');
      if (data != null && data is List) {
        setState(() {
          _gallery = List<Map<String, dynamic>>.from(data);
        });
      } else {
        setState(() {
          _gallery = [];
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No gallery items found')),
          );
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error fetching gallery items: $e, StackTrace: $stackTrace');
      }
      setState(() {
        _gallery = [];
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching gallery items: $e')),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      // Request storage permission
      final status = await Permission.storage.request();
      if (status.isDenied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Storage permission denied')),
          );
        }
        return;
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFilePath = result.files.single.path;
          _selectedFileName = result.files.single.name;
          _selectedFile = File(_selectedFilePath!);
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No image selected')),
          );
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error picking image: $e, StackTrace: $stackTrace');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedFile == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image first')),
        );
      }
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      // Validate file size (limit to 5MB)
      final fileBytes = await _selectedFile!.readAsBytes();
      if (fileBytes.length > 5 * 1024 * 1024) {
        throw Exception('Image size exceeds 5MB');
      }
      
      String base64Image = base64Encode(fileBytes);
      
      final data = await authProvider.makeRequest(
        method: 'POST',
        endpoint: '/api/v1/gallery/upload',
        body: {
          'title': _titleController.text,
          'description': _descriptionController.text,
          'category': _categoryController.text,
          'image': base64Image,
          'filename': _selectedFileName,
        },
      );
      
      if (data != null && mounted) {
        setState(() {
          _titleController.clear();
          _descriptionController.clear();
          _categoryController.clear();
          _selectedFile = null;
          _selectedFileName = null;
          _selectedFilePath = null;
        });
        await _fetchGalleryItems();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded successfully')),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProvider.error ?? 'Error uploading image')),
        );
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error uploading image: $e, StackTrace: $stackTrace');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gallery Management',
            style: theme.textTheme.headlineLarge ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload New Image',
                      style: theme.textTheme.titleLarge ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Image Title',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.title),
                      ),
                      validator: (value) => value?.isEmpty == true ? 'Enter image title' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.category),
                      ),
                      validator: (value) => value?.isEmpty == true ? 'Enter image category' : null,
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _selectedFile != null
                              ? Row(
                                  children: [
                                    const Icon(Icons.check_circle, color: Colors.green),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _selectedFileName ?? 'Selected image',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          _selectedFile = null;
                                          _selectedFileName = null;
                                          _selectedFilePath = null;
                                        });
                                      },
                                    ),
                                  ],
                                )
                              : OutlinedButton.icon(
                                  onPressed: _pickImage,
                                  icon: const Icon(Icons.add_photo_alternate),
                                  label: const Text('Select Image'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: _isUploading || authProvider.isLoading || _selectedFile == null
                              ? null
                              : _uploadImage,
                          icon: _isUploading
                              ? Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(2.0),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Icon(Icons.cloud_upload),
                          label: const Text('Upload Image'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF080F2B),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                    if (_selectedFile != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          image: _selectedFile != null
                              ? DecorationImage(
                                  image: FileImage(_selectedFile!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _selectedFile == null
                            ? const Center(child: Icon(Icons.image, size: 48))
                            : null,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            'Gallery Items',
            style: theme.textTheme.titleLarge ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search gallery...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) {
                    // TODO: Implement search filtering
                  },
                ),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: 'All Categories',
                items: [
                  'All Categories',
                  'Services',
                  'Portfolio',
                  'Testimonials',
                  'Events',
                ].map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  // TODO: Implement category filtering
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          if (authProvider.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_gallery.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.photo_library_outlined, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No gallery items found',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Upload your first image to get started',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 3 : (screenWidth > 600 ? 2 : 1),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isDesktop ? 1 : 1.2,
              ),
              itemCount: _gallery.length,
              itemBuilder: (context, index) {
                final item = _gallery[index];
                return _buildGalleryItem(context, item);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildGalleryItem(BuildContext context, Map<String, dynamic> item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: item['imageUrl'] != null
                ? Image.network(
                    item['imageUrl'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(Icons.broken_image, size: 48, color: Colors.grey[500]),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey[500]),
                    ),
                  ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? 'Untitled',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item['category'] != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      item['category'] as String,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Row(
              children: [
                Material(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: () => _showEditDialog(context, item),
                    tooltip: 'Edit',
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white, size: 20),
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: () => _showDeleteConfirmation(context, item),
                    tooltip: 'Delete',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, Map<String, dynamic> item) {
    final titleController = TextEditingController(text: item['title'] ?? '');
    final descriptionController = TextEditingController(text: item['description'] ?? '');
    final categoryController = TextEditingController(text: item['category'] ?? '');
    
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Edit Gallery Item'),
        content: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) => value?.isEmpty == true ? 'Enter title' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                  validator: (value) => value?.isEmpty == true ? 'Enter category' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description (Optional)'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: item['imageUrl'] != null
                        ? DecorationImage(
                            image: NetworkImage(item['imageUrl'] as String),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.grey[200],
                  ),
                  child: item['imageUrl'] == null
                      ? Center(
                          child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey[500]),
                        )
                      : null,
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
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              try {
                final data = await authProvider.makeRequest(
                  method: 'PUT',
                  endpoint: '/api/v1/gallery/update/<int:image_id>/${item['id']}',
                  body: {
                    'title': titleController.text,
                    'description': descriptionController.text,
                    'category': categoryController.text,
                  },
                );
                
                if (data != null && mounted) {
                  await _fetchGalleryItems();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gallery item updated')),
                  );
                } else if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(authProvider.error ?? 'Error updating gallery item')),
                  );
                }
              } catch (e, stackTrace) {
                if (kDebugMode) {
                  print('Error updating gallery item: $e, StackTrace: $stackTrace');
                }
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete "${item['title'] ?? 'this item'}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () async {
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              try {
                final data = await authProvider.makeRequest(
                  method: 'DELETE',
                  endpoint: '/api/v1/gallery/<int:image_id>/${item['id']}',
                );
                
                if (data != null && mounted) {
                  await _fetchGalleryItems();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gallery item deleted')),
                  );
                } else if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(authProvider.error ?? 'Error deleting gallery item')),
                  );
                }
              } catch (e, stackTrace) {
                print('Error deleting gallery item: $e, StackTrace: $stackTrace');
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              }
            },
            child: const Text('Delete'),
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
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/auth/all');
      if (data != null && data is List) {
        setState(() {
          _users = List<Map<String, dynamic>>.from(data);
        });
      } else {
        setState(() {
          _users = [];
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No users found')),
          );
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error fetching users: $e, StackTrace: $stackTrace');
      }
      setState(() {
        _users = [];
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching users: $e')),
        );
      }
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
          Text(
            'Users',
            style: theme.textTheme.headlineLarge ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
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
                  Text(
                    user['name'] ?? 'N/A',
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold) ??
                        const TextStyle(fontWeight: FontWeight.bold),
                  ),
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
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/booking/all');
      if (data != null && data is List) {
        setState(() {
          _bookings = List<Map<String, dynamic>>.from(data);
        });
      } else {
        setState(() {
          _bookings = [];
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No bookings found')),
          );
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error fetching bookings: $e, StackTrace: $stackTrace');
      }
      setState(() {
        _bookings = [];
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching bookings: $e')),
        );
      }
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
          Text(
            'Bookings',
            style: theme.textTheme.headlineLarge ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
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
                  Text(
                    'Booking #${booking['id'] ?? 'N/A'}',
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold) ??
                        const TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                    endpoint: '/api/v1/booking/<int:id>/${booking['id']}',
                  );
                  if (data != null && mounted) {
                    await _fetchBookings();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Booking deleted')),
                    );
                  } else if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(authProvider.error ?? 'Error deleting booking'),
                      ),
                    );
                  }
                } catch (e, stackTrace) {
                  if (kDebugMode) {
                    print('Error deleting booking: $e, StackTrace: $stackTrace');
                  }
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
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
        final providersData = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/providers/all');
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
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/feedback/all');
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
      final data = await authProvider.makeRequest(method: 'GET', endpoint: '/api/v1/notifications/all');
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
                                    endpoint: '/api/v1/notifications/create',
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
                                    endpoint: '/api/v1/notifications/update/${notification['id']}',
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
                        endpoint: '/api/v1/notifications/delete/<int:notification_id>/${notification['id']}',
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

class _ChatSectionState extends State<ChatSection> with TickerProviderStateMixin {
  String? _selectedUserId;
  String? _selectedUserName;
  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _recentChats = [];
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isLoadingUsers = false;
  bool _isLoadingChats = false;
  bool _isSendingMessage = false;
  String? _searchQuery;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _selectedTab = 0; // 0 = All Users, 1 = Recent Chats
  Map<String, dynamic>? _chatStats;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _fetchUsers();
    _fetchRecentChats();
    _fetchChatStats();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _fetchUsers() async {
    if (!mounted) return;
    
    setState(() {
      _isLoadingUsers = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final response = await authProvider.makeRequest(
        method: 'GET', 
        endpoint: '/api/messages/admin/users'
      );
      
      if (mounted) {
        if (response != null && response['success'] == true) {
          setState(() {
            _users = List<Map<String, dynamic>>.from(response['users']);
            _isLoadingUsers = false;
          });
        } else {
          setState(() {
            _users = [];
            _isLoadingUsers = false;
          });
          _showSnackBar('Failed to load users', isError: true);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingUsers = false;
        });
        _showSnackBar('Error fetching users: $e', isError: true);
      }
    }
  }

  Future<void> _fetchRecentChats() async {
    if (!mounted) return;
    
    setState(() {
      _isLoadingChats = true;
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final response = await authProvider.makeRequest(
        method: 'GET', 
        endpoint: '/api/messages/admin/chats'
      );
      
      if (mounted) {
        if (response != null && response['success'] == true) {
          setState(() {
            _recentChats = List<Map<String, dynamic>>.from(response['chats']);
            _isLoadingChats = false;
          });
        } else {
          setState(() {
            _recentChats = [];
            _isLoadingChats = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingChats = false;
        });
        _showSnackBar('Error fetching chats: $e', isError: true);
      }
    }
  }

  Future<void> _fetchChatStats() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final response = await authProvider.makeRequest(
        method: 'GET', 
        endpoint: '/api/messages/admin/stats'
      );
      
      if (mounted && response != null && response['success'] == true) {
        setState(() {
          _chatStats = response['stats'];
        });
      }
    } catch (e) {
      // Silent fail for stats
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  String _getChatId(String adminId, String userId) {
    return adminId.compareTo(userId) < 0 ? '${adminId}_$userId' : '${userId}_$adminId';
  }

  List<Map<String, dynamic>> get _filteredUsers {
    if (_searchQuery == null || _searchQuery!.isEmpty) {
      return _users;
    }
    return _users.where((user) {
      final name = (user['name'] ?? '').toString().toLowerCase();
      final email = (user['email'] ?? '').toString().toLowerCase();
      final query = _searchQuery!.toLowerCase();
      return name.contains(query) || email.contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> get _filteredChats {
    if (_searchQuery == null || _searchQuery!.isEmpty) {
      return _recentChats;
    }
    return _recentChats.where((chat) {
      final otherUser = chat['other_user'] ?? {};
      final name = (otherUser['username'] ?? '').toString().toLowerCase();
      final email = (otherUser['email'] ?? '').toString().toLowerCase();
      final query = _searchQuery!.toLowerCase();
      return name.contains(query) || email.contains(query);
    }).toList();
  }

  void _selectUser(Map<String, dynamic> user) {
    setState(() {
      _selectedUserId = user['id']?.toString();
      _selectedUserName = user['name']?.toString() ?? user['username']?.toString() ?? 'Unknown User';
    });
    _animationController.forward();
  }

  void _selectUserFromChat(Map<String, dynamic> chat) {
    final otherUser = chat['other_user'] ?? {};
    setState(() {
      _selectedUserId = otherUser['id']?.toString();
      _selectedUserName = otherUser['username']?.toString() ?? 'Unknown User';
    });
    _animationController.forward();
  }

  Future<void> _refreshData() async {
    await Future.wait([
      _fetchUsers(),
      _fetchRecentChats(),
      _fetchChatStats(),
    ]);
  }

  String _formatChatTime(dynamic timestamp) {
    try {
      if (timestamp == null) return '';
      
      DateTime messageTime;
      if (timestamp is Timestamp) {
        messageTime = timestamp.toDate();
      } else if (timestamp is String) {
        messageTime = DateTime.parse(timestamp);
      } else {
        return '';
      }

      final now = DateTime.now();
      final difference = now.difference(messageTime);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return '';
    }
  }

  Future<void> _sendMessage(String chatId, String adminId, String userId) async {
    final messageText = _messageController.text.trim();
    if (messageText.isEmpty || _isSendingMessage) return;

    setState(() {
      _isSendingMessage = true;
    });

    try {
      // Add message to Firestore
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'content': messageText,
        'senderId': adminId,
        'receiverId': userId,
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'text',
        'isRead': false,
      });

      // Update chat metadata
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .set({
        'lastMessage': messageText,
        'lastMessageTime': FieldValue.serverTimestamp(),
        'participants': [adminId, userId],
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Clear message input
      _messageController.clear();
      
      // Scroll to bottom
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }

      _showSnackBar('Message sent successfully');
    } catch (e) {
      _showSnackBar('Failed to send message: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isSendingMessage = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);

    if (authProvider.userType == 'provider') {
      return _buildAccessRestricted();
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Row(
        children: [
          // Users List Panel
          Container(
            width: 380,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(2, 0),
                ),
              ],
            ),
            child: _buildUsersPanel(theme),
          ),
          // Chat Interface
          Expanded(
            child: _selectedUserId != null && authProvider.userId != null
                ? FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildChatInterface(
                      context, 
                      authProvider.userId!, 
                      _selectedUserId!,
                      _selectedUserName!,
                    ),
                  )
                : _buildWelcomeScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessRestricted() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.block_rounded,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          const Text(
            'Access Restricted',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This feature is only available to administrators.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersPanel(ThemeData theme) {
    return Column(
      children: [
        // Header with Stats
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFF080F2B),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Admin Chat',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage user conversations',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
              if (_chatStats != null) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Active Chats', 
                        _chatStats!['active_chats']?.toString() ?? '0',
                        Icons.chat_bubble,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        'Unread', 
                        _chatStats!['total_unread']?.toString() ?? '0',
                        Icons.mark_chat_unread,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        
        // Tabs
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedTab = 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedTab == 0 ? const Color(0xFF080F2B) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'All Users',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _selectedTab == 0 ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedTab = 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _selectedTab == 1 ? const Color(0xFF080F2B) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Recent Chats',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _selectedTab == 1 ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: _selectedTab == 0 ? 'Search users...' : 'Search chats...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
        ),
        
        // Refresh Button
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: (_isLoadingUsers || _isLoadingChats) ? null : _refreshData,
              icon: (_isLoadingUsers || _isLoadingChats) 
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh),
              label: Text((_isLoadingUsers || _isLoadingChats) ? 'Loading...' : 'Refresh'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF080F2B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        
        // Content List
        Expanded(
          child: _selectedTab == 0 ? _buildUsersList() : _buildChatsList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersList() {
    if (_isLoadingUsers) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading users...'),
          ],
        ),
      );
    }

    final filteredUsers = _filteredUsers;

    if (filteredUsers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery?.isNotEmpty == true 
                  ? 'No users found matching your search'
                  : 'No users available',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        final isSelected = _selectedUserId == user['id']?.toString();
        
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isSelected 
                  ? const Color(0xFF080F2B) 
                  : const Color(0xFF080F2B).withOpacity(0.1),
              child: Icon(
                Icons.person,
                color: isSelected ? Colors.white : const Color(0xFF080F2B),
              ),
            ),
            title: Text(
              user['name'] ?? user['username'] ?? 'N/A',
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user['email'] ?? 'N/A'),
                Text(
                  user['user_type'] ?? 'user',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            selected: isSelected,
            selectedTileColor: const Color(0xFF080F2B).withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () => _selectUser(user),
          ),
        );
      },
    );
  }

  Widget _buildChatsList() {
    if (_isLoadingChats) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading chats...'),
          ],
        ),
      );
    }

    final filteredChats = _filteredChats;

    if (filteredChats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery?.isNotEmpty == true 
                  ? 'No chats found matching your search'
                  : 'No recent chats',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredChats.length,
      itemBuilder: (context, index) {
        final chat = filteredChats[index];
        final otherUser = chat['other_user'] ?? {};
        final isSelected = _selectedUserId == otherUser['id']?.toString();
        final unreadCount = chat['unread_count'] ?? 0;
        
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: isSelected 
                      ? const Color(0xFF080F2B) 
                      : const Color(0xFF080F2B).withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    color: isSelected ? Colors.white : const Color(0xFF080F2B),
                  ),
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unreadCount > 9 ? '9+' : unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(
              otherUser['username'] ?? 'Unknown User',
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(otherUser['email'] ?? 'N/A'),
                if (chat['last_message'] != null)
                  Text(
                    chat['last_message']['content']?.toString() ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
            trailing: chat['last_message_time'] != null 
                ? Text(
                    _formatChatTime(chat['last_message_time']),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  )
                : null,
            selected: isSelected,
            selectedTileColor: const Color(0xFF080F2B).withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () => _selectUserFromChat(chat),
          ),
        );
      },
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.admin_panel_settings,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            'Admin Chat Center',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Select a user to start or continue a conversation',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          if (_chatStats != null) ...[
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        _chatStats!['total_messages']?.toString() ?? '0',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF080F2B),
                        ),
                      ),
                      Text(
                        'Total Messages',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        _chatStats!['active_chats']?.toString() ?? '0',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF080F2B),
                        ),
                      ),
                      Text(
                        'Active Chats',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        _chatStats!['total_unread']?.toString() ?? '0',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Unread Messages',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChatInterface(BuildContext context, String adminId, String userId, String userName) {
    final theme = Theme.of(context);
    final chatId = _getChatId(adminId, userId);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Chat Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF080F2B),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'ID: $userId',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Chat Actions
                IconButton(
                  onPressed: () {
                    // TODO: Show user info dialog
                  },
                  icon: const Icon(Icons.info_outline, color: Colors.white),
                  tooltip: 'User Info',
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedUserId = null;
                      _selectedUserName = null;
                    });
                    _animationController.reset();
                  },
                  icon: const Icon(Icons.close, color: Colors.white),
                  tooltip: 'Close Chat',
                ),
              ],
            ),
          ),
          // Messages Area
          Expanded(
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
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                        const SizedBox(height: 16),
                                                Text(
                          'Error loading messages: ${snapshot.error}',
                          style: TextStyle(color: Colors.red[600]),
                        ),
                      ],
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No messages yet',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index].data() as Map<String, dynamic>;
                    final isAdmin = message['senderId'] == adminId;
                    final messageTime = message['timestamp'] != null
                        ? _formatChatTime(message['timestamp'])
                        : '';

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: isAdmin
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!isAdmin)
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: Icon(
                                Icons.person,
                                color: Colors.grey[600],
                              ),
                            ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isAdmin
                                    ? const Color(0xFF080F2B)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: isAdmin
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message['content']?.toString() ?? '',
                                    style: TextStyle(
                                      color: isAdmin ? Colors.white : Colors.black87,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    messageTime,
                                    style: TextStyle(
                                      color: isAdmin
                                          ? Colors.white.withOpacity(0.7)
                                          : Colors.grey[600],
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (isAdmin)
                            CircleAvatar(
                              backgroundColor: const Color(0xFF080F2B),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    minLines: 1,
                    maxLines: 4,
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: _isSendingMessage
                      ? null
                      : () => _sendMessage(chatId, adminId, userId),
                  icon: _isSendingMessage
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send, color: Color(0xFF080F2B)),
                  tooltip: 'Send Message',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}