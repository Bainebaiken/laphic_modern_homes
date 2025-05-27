
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:laphic_app/profile_screen.dart';
import 'package:laphic_app/projects_designn.dart';
import 'package:laphic_app/services.dart';
import 'package:laphic_app/livechat.dart';
import 'package:laphic_app/feedback.dart';
import 'package:laphic_app/payment_screen.dart';

void main() {
  // Note: For production, consider using MainScreen or a login screen as the entry point
  runApp(const MaterialApp(home: BookingScreen(initialDesign: '', initialServiceType: '')));
}

class BookingScreen extends StatefulWidget {
  final String? token;
  final String initialDesign;
  final String initialServiceType;
  const BookingScreen({Key? key, this.token, required this.initialDesign, required this.initialServiceType}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _selectedIndex = 4; // Booking tab
  final storage = const FlutterSecureStorage();
  bool _isLoading = true;
  int _currentStep = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _selectedServiceType = "Painting";
  double distance = 15.0; // Default distance, updated based on address

  final double costPerKm = 5000.0; // UGX 5,000 per km
  final String apiUrl = "http://10.0.2.2:5000/api/bookings";

  // Service base prices in Ugandan Shillings (UGX)
  final Map<String, double> _serviceBasePrices = {
    "Painting": 50000.0, // UGX 50,000
    "Compound Design": 70000.0, // UGX 70,000
    "Gypsum Work": 60000.0, // UGX 60,000
    "Aluminum Works": 90000.0, // UGX 90,000
    "furnture": 100000.0, // UGX 100,000
    "Interior Design": 120000.0, // UGX 120,000
    "contruction": 120000.0,
  };

  // Service type multipliers
  final Map<String, double> _serviceTypeMultipliers = {
    "Painting": 1.0,
    "Compound Design": 1.2,
    "Gypsum Work": 1.3,
    "Aluminum Works": 1.5,
    "furniture": 1.8,
    "Interior Design": 2.0,
    "construction":3.0
  };

  final List<String> _serviceTypes = [
    "Painting",
    "Compound Design",
    "Gypsum Work",
    "Aluminum Works",
    "furniture",
    "Interior Design",
    "construction",
  ];

  // Service descriptions
  final Map<String, String> _serviceDescriptions = {
    "Painting": "Professional painting services for interior and exterior surfaces with quality paint finishes.",
    "Compound Design": "Creating beautiful and functional outdoor spaces with modern compound design concepts.",
    "Gypsum Work": "Expert gypsum installation including ceiling designs, partitions, and decorative elements.",
    "Aluminum Works": "Custom aluminum fixtures, windows, doors, and structural elements with premium materials.",
    "furniture": "Complete home renovation services for transforming your space with modern upgrades.",
    "Interior Design": "Full-service interior design including space planning, material selection, and styling.",
  };

  @override
  void initState() {
    super.initState();
    _checkToken();
    
    // Initialize with valid service type or default to first option
    if (widget.initialServiceType.isNotEmpty && _serviceTypes.contains(widget.initialServiceType)) {
      _selectedServiceType = widget.initialServiceType;
    }
  }

  Future<void> _checkToken() async {
    setState(() => _isLoading = true);
    String? token = widget.token ?? await storage.read(key: 'auth_token');
    if (kDebugMode) {
      print('Token retrieved: $token');
    }
    if (token == null) {
      if (kDebugMode) {
        print('Warning: No authentication token found');
      }
      // Optionally redirect to login screen
    }
    setState(() => _isLoading = false);
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orange,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final now = DateTime.now();
      if (picked.isBefore(DateTime(now.year, now.month, now.day))) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a future date')),
        );
        return;
      }
      setState(() => _selectedDate = picked);
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orange,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Validate business hours (9 AM to 6 PM)
      if (picked.hour < 9 || picked.hour >= 18) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a time between 9 AM and 6 PM')),
        );
        return;
      }
      setState(() => _selectedTime = picked);
    }
  }

  double _calculateDistanceFromAddress(String address) {
    // Placeholder: Simulate distance calculation
    final mockDistance = (address.length % 40) + 10.0; // Returns 10–50 km
    if (kDebugMode) {
      print('Calculated distance for address "$address": $mockDistance km');
    }
    return mockDistance.clamp(0.1, 100.0);
  }

  double _calculateTotalCost() {
    double basePrice = _serviceBasePrices[_selectedServiceType] ?? 50000.0;
    double serviceMultiplier = _serviceTypeMultipliers[_selectedServiceType] ?? 1.0;
    double transportationCost = distance * costPerKm;
    return (basePrice * serviceMultiplier) + transportationCost;
  }

  Future<bool> _createBooking(String paymentMethod) async {
    final totalAmount = _calculateTotalCost();
    final bookingData = {
      'name': _nameController.text,
      'phoneNumber': _phoneController.text,
      'address': _addressController.text,
      'selectedServiceType': _selectedServiceType,
      'selectedDate': DateFormat('yyyy-MM-dd').format(_selectedDate!),
      'selectedTime': _selectedTime!.format(context),
      'distance': distance,
      'cost': totalAmount,
      'paymentMethod': paymentMethod,
    };

    try {
      String? token = widget.token ?? await storage.read(key: 'auth_token');
      if (token == null) {
        if (kDebugMode) {
          print('No token found, cannot create booking');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please log in to create a booking'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return false;
      }

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(bookingData),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) { // Updated to handle 201 status
        final responseData = jsonDecode(response.body);
        if (kDebugMode) {
          print('Booking created: ${responseData['booking']['id']}');
        }
        return true;
      } else {
        final error = jsonDecode(response.body)['error'] ?? 'Failed to create booking';
        if (kDebugMode) {
          print('Failed to create booking: $error');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create booking: $error'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating booking: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
  }

  void _showBookingSummary() {
    if (kDebugMode) {
      print('Validating form: name=${_nameController.text}, phone=${_phoneController.text}, '
            'address=${_addressController.text}, date=$_selectedDate, time=$_selectedTime');
    }

    if (_formKey.currentState!.validate() && _selectedDate != null && _selectedTime != null) {
      distance = _calculateDistanceFromAddress(_addressController.text);
      if (kDebugMode) {
        print('Distance calculated: $distance km');
      }

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          final totalCost = _calculateTotalCost();
          final basePrice = _serviceBasePrices[_selectedServiceType] ?? 50000.0;
          final serviceMultiplier = _serviceTypeMultipliers[_selectedServiceType] ?? 1.0;
          final serviceCost = basePrice * serviceMultiplier;
          final transportCost = distance * costPerKm;

          return Container(
            padding: const EdgeInsets.all(24),
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Booking Summary",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(thickness: 1.5),
                const SizedBox(height: 16),
                _buildSummaryItem("Name", _nameController.text),
                _buildSummaryItem("Phone", _phoneController.text),
                _buildSummaryItem("Address", _addressController.text),
                _buildSummaryItem(
                  "Appointment",
                  "${DateFormat('EEE, MMM d, yyyy').format(_selectedDate!)} at ${_selectedTime!.format(context)}",
                ),
                const SizedBox(height: 16),
                _buildServiceSummary(
                  _selectedServiceType,
                  _serviceDescriptions[_selectedServiceType] ?? "",
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Cost Breakdown",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildCostItem("Service Cost", "UGX ${serviceCost.toStringAsFixed(0)}"),
                        _buildCostItem("Distance", "${distance.toStringAsFixed(1)} km"),
                        _buildCostItem("Transportation", "UGX ${transportCost.toStringAsFixed(0)}"),
                        const Divider(thickness: 1),
                        _buildCostItem(
                          "Total Amount",
                          "UGX ${totalCost.toStringAsFixed(0)}",
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print('Proceeding to payment options');
                      }
                      Navigator.pop(context);
                      _showPaymentOptions();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Proceed to Payment",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      if (kDebugMode) {
        print('Validation failed: '
              'formValid=${_formKey.currentState?.validate()}, '
              'date=${_selectedDate != null}, time=${_selectedTime != null}');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all fields, including date and time'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSummary(String service, String serviceDesc) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              service,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              serviceDesc,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostItem(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isBold ? 18 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold ? 18 : 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.orange : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentOptions() {
    if (kDebugMode) {
      print('Showing payment options');
    }
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Total: UGX ${_calculateTotalCost().toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 24),
            _buildPaymentOption(
              icon: Icons.phone_android,
              title: "Mobile Money",
              subtitle: "Pay using MTN, Airtel, or other mobile money services",
              onTap: () => _proceedToPayment("Mobile Money"),
            ),
            const Divider(height: 1),
            _buildPaymentOption(
              icon: Icons.account_balance,
              title: "Bank Transfer",
              subtitle: "Pay using bank transfer or deposit",
              onTap: () => _proceedToPayment("Bank Transfer"),
            ),
            const Divider(height: 1),
            _buildPaymentOption(
              icon: Icons.credit_card,
              title: "Credit Card",
              subtitle: "Pay using Visa, Mastercard, or other credit cards",
              onTap: () => _proceedToPayment("Credit Card"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Function() onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.orange, size: 28),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _proceedToPayment(String paymentMethod) async {
    Navigator.pop(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Colors.orange),
      ),
    );

    final success = await _createBooking(paymentMethod);

    Navigator.pop(context);

    if (success) {
      if (kDebugMode) {
        print("Navigating to PaymentScreen with paymentMethod: $paymentMethod");
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            name: _nameController.text,
            phoneNumber: _phoneController.text,
            address: _addressController.text,
            selectedServiceType: _selectedServiceType,
            selectedServicePackage: '',
            selectedDate: _selectedDate!,
            selectedTime: _selectedTime!,
            distance: distance,
            cost: _calculateTotalCost(),
            paymentMethod: paymentMethod,
          ),
        ),
      );

      _formKey.currentState!.reset();
      _nameController.clear();
      _phoneController.clear();
      _addressController.clear();
      setState(() {
        _selectedDate = null;
        _selectedTime = null;
        _selectedServiceType = _serviceTypes[0];
        distance = 15.0;
        _currentStep = 0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking successful!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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
        // Already on BookingScreen
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FeedbackInquiryScreen()),
        );
        break;
    }
  }

  Widget _buildBookingContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Center(
                child: Text(
                  "Book Service for Survey",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[800],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  "Fill in your details to book a service",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: Colors.orange,
                      ),
                ),
                child: Stepper(
                  physics: const ClampingScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => setState(() => _currentStep = step),
                  onStepContinue: () {
                    if (_currentStep < 1) {
                      bool canContinue = true;
                      if (_currentStep == 0) {
                        if (_nameController.text.isEmpty ||
                            _phoneController.text.isEmpty ||
                            _addressController.text.isEmpty) {
                          canContinue = false;
                        }
                      }
                      if (canContinue) {
                        setState(() => _currentStep += 1);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please complete all fields in this step'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    } else {
                      _showBookingSummary();
                    }
                  },
                  onStepCancel: () {
                    if (_currentStep > 0) {
                      setState(() => _currentStep -= 1);
                    }
                  },
                  controlsBuilder: (context, details) {
                    return Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: details.onStepContinue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              _currentStep == 1 ? "Review Booking" : "Continue",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        if (_currentStep > 0) ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: details.onStepCancel,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.orange,
                                side: BorderSide(color: Colors.orange),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Back"),
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                  steps: [
                    Step(
                      title: const Text("Personal Details"),
                      content: Column(
                        children: [
                          _buildTextField(
                            controller: _nameController,
                            label: "Full Name",
                            icon: Icons.person,
                            hint: "Enter your full name",
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _phoneController,
                            label: "Phone Number",
                            icon: Icons.phone,
                            inputType: TextInputType.phone,
                            hint: "Enter your phone number (e.g., +256123456789)",
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: _addressController,
                            label: "Address",
                            icon: Icons.home,
                            hint: "Enter your full address",
                            helperText: "Distance will be calculated based on address",
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                    ),
                    Step(
                      title: const Text("Schedule & Service"),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "When would you like us to visit?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => _selectDate(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange.shade50,
                                    foregroundColor: Colors.orange,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(color: Colors.orange.shade300),
                                    ),
                                  ),
                                  icon: const Icon(Icons.calendar_today),
                                  label: const Text("Select Date"),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => _selectTime(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange.shade50,
                                    foregroundColor: Colors.orange,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(color: Colors.orange.shade300),
                                    ),
                                  ),
                                  icon: const Icon(Icons.access_time),
                                  label: const Text("Select Time"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          if (_selectedDate != null || _selectedTime != null)
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.orange.shade200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Selected Schedule:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      if (_selectedDate != null) ...[
                                        const Icon(Icons.event, color: Colors.orange, size: 20),
                                        const SizedBox(width: 8),
                                        Text(
                                          DateFormat('EEE, MMM d, yyyy').format(_selectedDate!),
                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(width: 16),
                                      ],
                                      if (_selectedTime != null) ...[
                                        const Icon(Icons.access_time, color: Colors.orange, size: 20),
                                        const SizedBox(width: 8),
                                        Text(
                                          _selectedTime!.format(context),
                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 16),
                          const Text(
                            "Business Hours: 9:00 AM - 6:00 PM",
                            style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildServiceTypeSelector(),
                        ],
                      ),
                      isActive: _currentStep >= 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              if (_currentStep == 1)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _showBookingSummary,
                    icon: const Icon(Icons.receipt_long),
                    label: const Text("Review Booking Summary"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Service Type",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _serviceTypes.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final serviceType = _serviceTypes[index];
              final isSelected = _selectedServiceType == serviceType;
              return RadioListTile<String>(
                title: Text(
                  serviceType,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  _serviceDescriptions[serviceType] ?? "",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                value: serviceType,
                groupValue: _selectedServiceType,
                activeColor: Colors.orange,
                onChanged: (value) {
                  setState(() => _selectedServiceType = value!);
                },
                secondary: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.orange.shade50 : Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getServiceIcon(serviceType),
                    color: isSelected ? Colors.orange : Colors.grey,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _getServiceIcon(String serviceType) {
    switch (serviceType) {
      case "Painting":
        return Icons.format_paint;
      case "Compound Design":
        return Icons.landscape;
      case "Gypsum Work":
        return Icons.architecture;
      case "Aluminum Works":
        return Icons.window;
      case "Renovation":
        return Icons.home_work;
      case "Interior Design":
        return Icons.chair;
      default:
        return Icons.handyman;
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    String? hint,
    String? helperText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.orange),
        labelText: label,
        hintText: hint,
        helperText: helperText,
        labelStyle: TextStyle(color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $label";
        }
        if (label == "Phone Number" && !RegExp(r'^\+?\d{9,15}$').hasMatch(value)) {
          return "Please enter a valid phone number (e.g., +256123456789)";
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.orange),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Book Service",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: _buildBookingContent(),
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

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}