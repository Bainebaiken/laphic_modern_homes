





// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'payment_screen.dart';

// // class BookingScreen extends StatefulWidget {
// //   const BookingScreen({super.key});

// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _BookingScreenState createState() => _BookingScreenState();
// // }

// // class _BookingScreenState extends State<BookingScreen> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _phoneController = TextEditingController();
// //   final TextEditingController _addressController = TextEditingController();
// //   DateTime? _selectedDate;
// //   String _selectedService = "Basic Service";
// //   final double _distance = 10.0; // Example distance
// //   final double _serviceCost = 50.0; // Example cost

// //   final List<String> _services = ["Basic Service", "Premium Service", "VIP Service"];

// //   void _selectDate(BuildContext context) async {
// //     final DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: DateTime.now(),
// //       firstDate: DateTime.now(),
// //       lastDate: DateTime(2101),
// //     );

// //     if (picked != null && picked != _selectedDate) {
// //       setState(() {
// //         _selectedDate = picked;
// //       });
// //     }
// //   }

// //   void _proceedToPayment() {
// //     if (_formKey.currentState!.validate() && _selectedDate != null) {
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => PaymentScreen(
// //             name: _nameController.text,
// //             phoneNumber: _phoneController.text,
// //             address: _addressController.text,
// //             selectedService: _selectedService,
// //             selectedDate: _selectedDate!,
// //             distance: _distance,
// //             cost: _serviceCost,
// //           ),
// //         ),
// //       );
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Please complete all fields")),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Book a Service"), backgroundColor: Colors.orange),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               TextFormField(
// //                 controller: _nameController,
// //                 decoration: const InputDecoration(labelText: "Name"),
// //                 validator: (value) => value!.isEmpty ? "Enter your name" : null,
// //               ),
// //               TextFormField(
// //                 controller: _phoneController,
// //                 decoration: const InputDecoration(labelText: "Phone Number"),
// //                 keyboardType: TextInputType.phone,
// //                 validator: (value) => value!.isEmpty ? "Enter your phone number" : null,
// //               ),
// //               TextFormField(
// //                 controller: _addressController,
// //                 decoration: const InputDecoration(labelText: "Address"),
// //                 validator: (value) => value!.isEmpty ? "Enter your address" : null,
// //               ),
// //               const SizedBox(height: 10),
// //               DropdownButtonFormField<String>(
// //                 value: _selectedService,
// //                 decoration: const InputDecoration(labelText: "Select Service"),
// //                 items: _services.map((service) {
// //                   return DropdownMenuItem(value: service, child: Text(service));
// //                 }).toList(),
// //                 onChanged: (value) {
// //                   setState(() {
// //                     _selectedService = value!;
// //                   });
// //                 },
// //               ),
// //               const SizedBox(height: 10),
// //               Row(
// //                 children: [
// //                   ElevatedButton(
// //                     onPressed: () => _selectDate(context),
// //                     child: const Text("Select Date"),
// //                   ),
// //                   const SizedBox(width: 10),
// //                   if (_selectedDate != null)
// //                     Text(DateFormat('EEE, MMM d, yyyy').format(_selectedDate!)),
// //                 ],
// //               ),
// //               const Spacer(),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: _proceedToPayment,
// //                   style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
// //                   child: const Text("Proceed to Payment"),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // below is the  booking screen showing how 

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:laphic_app/login_screen.dart'; // Assuming this exists
// import 'package:laphic_app/services.dart'; // Assuming ServicesPage exists
// import 'payment_screen.dart'; // Already provided

// void main() {
//   runApp(const MaterialApp(home: BookingScreen()));
// }

// class BookingScreen extends StatefulWidget {
//   final String? token; // Optional token for authenticated pages
//   const BookingScreen({Key? key, this.token}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _BookingScreenState createState() => _BookingScreenState();
// }

// class _BookingScreenState extends State<BookingScreen> {
//   int _selectedIndex = 3; // Default to "Booking" tab (index 3)
//   final storage = const FlutterSecureStorage();
//   String? _token;
//   bool _isLoading = true;

//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   DateTime? _selectedDate;
//   String _selectedServiceType = "Painting";
//   String _selectedServicePackage = "Basic Service";
//   final double _distance = 10.0; // Example distance
//   final double _serviceCost = 50.0; // Example cost

//   // Service types
//   final List<String> _serviceTypes = [
//     "Painting",
//     "Compound Design",
//     "Gypsum Work",
//     "Aluminum Works",
//     "Renovation",
//     "Interior Design"
//   ];

//   // Service packages
//   final List<String> _servicePackages = ["Basic Service", "Premium Service", "VIP Service"];

//   @override
//   void initState() {
//     super.initState();
//     _checkToken();
//   }

//   Future<void> _checkToken() async {
//     setState(() => _isLoading = true);
//     String? token = widget.token ?? await storage.read(key: 'auth_token');
//     if (kDebugMode) {
//       print('Token retrieved: $token');
//     } // Debug log

//     setState(() {
//       _token = token;
//       _isLoading = false;
//     });

//     if (token == null && mounted) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     }
//   }

//   // Pages for navigation
//   List<Widget> get _pages => [
//         const Center(child: Text("Feedback Screen Placeholder")), // Replace with FeedbackInquiryScreen
//         _token != null
//             ? ServicesHomePage()
//             : const Center(child: CircularProgressIndicator()),
//         const Center(child: Text("Projects Screen Placeholder")), // Replace with OngoingProjects
//         _buildBookingContent(), // Booking form content
//       ];

//   void _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );

//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   void _proceedToPayment() {
//     if (_formKey.currentState!.validate() && _selectedDate != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PaymentScreen(
//             name: _nameController.text,
//             phoneNumber: _phoneController.text,
//             address: _addressController.text,
//             selectedServiceType: _selectedServiceType,
//             selectedServicePackage: _selectedServicePackage,
//             selectedDate: _selectedDate!,
//             distance: _distance,
//             cost: _serviceCost,
//             selectedService: '',
//           ),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please complete all fields")),
//       );
//     }
//   }

//   void _onItemTapped(int index) {
//     if (index < _pages.length) {
//       setState(() => _selectedIndex = index);
//       if (kDebugMode) {
//         print("Tab switched to: $_selectedIndex");
//       } // Debug log
//     }
//   }

//   // Booking form content
//   Widget _buildBookingContent() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: "Name"),
//                 validator: (value) => value!.isEmpty ? "Enter your name" : null,
//               ),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: const InputDecoration(labelText: "Phone Number"),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) => value!.isEmpty ? "Enter your phone number" : null,
//               ),
//               TextFormField(
//                 controller: _addressController,
//                 decoration: const InputDecoration(labelText: "Address"),
//                 validator: (value) => value!.isEmpty ? "Enter your address" : null,
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Service Type",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               DropdownButtonFormField<String>(
//                 value: _selectedServiceType,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 ),
//                 items: _serviceTypes.map((service) {
//                   return DropdownMenuItem(value: service, child: Text(service));
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedServiceType = value!;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Service Package",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               DropdownButtonFormField<String>(
//                 value: _selectedServicePackage,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 ),
//                 items: _servicePackages.map((service) {
//                   return DropdownMenuItem(value: service, child: Text(service));
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedServicePackage = value!;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 "Select Date",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => _selectDate(context),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange.shade200,
//                     ),
//                     child: const Text("Choose Date"),
//                   ),
//                   const SizedBox(width: 10),
//                   if (_selectedDate != null)
//                     Text(DateFormat('EEE, MMM d, yyyy').format(_selectedDate!)),
//                 ],
//               ),
//               const SizedBox(height: 40),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _proceedToPayment,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                   ),
//                   child: const Text(
//                     "Proceed to Payment",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     if (_token == null) {
//       return const LoginScreen(); // Redirect to login if no token
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Laphic App"), // Generic title, adjust as needed
//         backgroundColor: Colors.orange,
//       ),
//       body: _pages[_selectedIndex], // Display the selected page
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: Colors.orange,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.feedback), label: "Feedback"),
//           BottomNavigationBarItem(icon: Icon(Icons.home_repair_service), label: "Services"),
//           BottomNavigationBarItem(icon: Icon(Icons.construction), label: "Projects"),
//           BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Booking"),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }
// }





// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:intl/intl.dart';

// void main() {
//   runApp(const MaterialApp(home: BookingScreen()));
// }

// class BookingScreen extends StatefulWidget {
//   final String? token;
//   const BookingScreen({Key? key, this.token}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _BookingScreenState createState() => _BookingScreenState();
// }

// class _BookingScreenState extends State<BookingScreen> {
//   final int _selectedIndex = 3;
//   final storage = const FlutterSecureStorage();
//   bool _isLoading = true;

//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   DateTime? _selectedDate;
//   String _selectedServiceType = "Painting";
//   String _selectedServicePackage = "Basic Service";

//   // Suppose each KM costs $10 for simplicity
//   final double costPerKm = 10.0;
//   final double distance = 15.0; // Example distance, you can change

//   final List<String> _serviceTypes = [
//     "Painting",
//     "Compound Design",
//     "Gypsum Work",
//     "Aluminum Works",
//     "Renovation",
//     "Interior Design",
//   ];

//   final List<String> _servicePackages = [
//     "Basic Service",
//     "Premium Service",
//     "VIP Service",
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _checkToken();
//   }

//   Future<void> _checkToken() async {
//     setState(() => _isLoading = true);
//     String? token = widget.token ?? await storage.read(key: 'auth_token');
//     if (kDebugMode) {
//       print('Token retrieved: $token');
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   void _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );

//     if (picked != null) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   double _calculateTotalCost() {
//     return distance * costPerKm;
//   }

//   void _showPaymentOptions() {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       builder: (context) => Padding(
//         padding: const EdgeInsets.all(20),
//         child: Wrap(
//           children: [
//             const Text(
//               "Select Payment Method",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             ListTile(
//               leading: const Icon(Icons.phone_android),
//               title: const Text("Mobile Money"),
//               onTap: () => _proceedToPayment("Mobile Money"),
//             ),
//             ListTile(
//               leading: const Icon(Icons.account_balance),
//               title: const Text("Bank Transfer"),
//               onTap: () => _proceedToPayment("Bank Transfer"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _proceedToPayment(String paymentMethod) {
//     double totalAmount = _calculateTotalCost();

//     Navigator.pop(context); // Close the bottom sheet
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PaymentScreen(
//           name: _nameController.text,
//           phoneNumber: _phoneController.text,
//           address: _addressController.text,
//           selectedServiceType: _selectedServiceType,
//           selectedServicePackage: _selectedServicePackage,
//           selectedDate: _selectedDate!,
//           distance: distance,
//           cost: totalAmount,
//           paymentMethod: paymentMethod,
//         ),
//       ),
//     );

//     // Clear the form after successful booking
//     _formKey.currentState!.reset();
//     _nameController.clear();
//     _phoneController.clear();
//     _addressController.clear();
//     setState(() {
//       _selectedDate = null;
//       _selectedServiceType = _serviceTypes[0];
//       _selectedServicePackage = _servicePackages[0];
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Booking successful!')),
//     );
//   }

//   Widget _buildBookingContent() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "book service for survey ",
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 223, 127, 18)),
//               ),
//               const SizedBox(height: 20),
//               _buildTextField(
//                 controller: _nameController,
//                 label: "Full Name",
//                 icon: Icons.person,
//               ),
//               const SizedBox(height: 15),
//               _buildTextField(
//                 controller: _phoneController,
//                 label: "Phone Number",
//                 icon: Icons.phone,
//                 inputType: TextInputType.phone,
//               ),
//               const SizedBox(height: 15),
//               _buildTextField(
//                 controller: _addressController,
//                 label: "Address",
//                 icon: Icons.home,
//               ),
//               const SizedBox(height: 25),
//               _buildDropdownField(
//                 label: "Select Service Type",
//                 icon: Icons.home_repair_service,
//                 value: _selectedServiceType,
//                 items: _serviceTypes,
//                 onChanged: (val) => setState(() => _selectedServiceType = val!),
//               ),
//               const SizedBox(height: 25),
//               _buildDropdownField(
//                 label: "Select Service Package",
//                 icon: Icons.card_membership,
//                 value: _selectedServicePackage,
//                 items: _servicePackages,
//                 onChanged: (val) => setState(() => _selectedServicePackage = val!),
//               ),
//               const SizedBox(height: 25),
//               const Text(
//                 "Select Appointment Date",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _selectDate(context),
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
//                     icon: const Icon(Icons.calendar_today_outlined),
//                     label: const Text("Choose Date"),
//                   ),
//                   const SizedBox(width: 15),
//                   if (_selectedDate != null)
//                     Text(
//                       DateFormat('EEE, MMM d, yyyy').format(_selectedDate!),
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 40),
//               Center( // Center the button
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate() && _selectedDate != null) {
//                       _showPaymentOptions();
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Please complete all fields')),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromRGBO(255, 152, 34, 1),
//                     padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     "Proceed to Payment",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType inputType = TextInputType.text,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: inputType,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon),
//         labelText: label,
//         filled: true,
//         fillColor: Colors.orange.shade50,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       validator: (value) => value!.isEmpty ? "Please enter your $label" : null,
//     );
//   }

//   Widget _buildDropdownField({
//     required String label,
//     required IconData icon,
//     required String value,
//     required List<String> items,
//     required Function(String?) onChanged,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon),
//         filled: true,
//         fillColor: Colors.orange.shade50,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
//       onChanged: onChanged,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Booking"),
//         backgroundColor: Colors.orange,
//       ),
//       body: _buildBookingContent(),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }
// }

// // Simple Payment Screen Placeholder
// class PaymentScreen extends StatelessWidget {
//   final String name;
//   final String phoneNumber;
//   final String address;
//   final String selectedServiceType;
//   final String selectedServicePackage;
//   final DateTime selectedDate;
//   final double distance;
//   final double cost;
//   final String paymentMethod;

//   const PaymentScreen({
//     Key? key,
//     required this.name,
//     required this.phoneNumber,
//     required this.address,
//     required this.selectedServiceType,
//     required this.selectedServicePackage,
//     required this.selectedDate,
//     required this.distance,
//     required this.cost,
//     required this.paymentMethod,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Confirm Payment"),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Hello, $name", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             Text("Service: $selectedServiceType - $selectedServicePackage"),
//             Text("Address: $address"),
//             Text("Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
//             const Divider(height: 30),
//             Text("Distance: ${distance.toStringAsFixed(2)} km"),
//             Text("Amount to Pay: \$${cost.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 20),
//             Text("Payment Method: $paymentMethod"),
//             const SizedBox(height: 30),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Do Payment Logic Here
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Payment Successful!')),
//                   );
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                 ),
//                 child: const Text("Pay Now", style: TextStyle(fontSize: 18)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(home: BookingScreen()));
}

class BookingScreen extends StatefulWidget {
  final String? token;
  const BookingScreen({Key? key, this.token}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final int _selectedIndex = 3;
  final storage = const FlutterSecureStorage();
  bool _isLoading = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _selectedServiceType = "Painting";
  String _selectedServicePackage = "Basic Service";

  final double costPerKm = 10.0;
  final double distance = 15.0;
  final String apiUrl = "http://10.0.2.2:5000/api/bookings"; // Update for deployed URL

  final List<String> _serviceTypes = [
    "Painting",
    "Compound Design",
    "Gypsum Work",
    "Aluminum Works",
    "Renovation",
    "Interior Design",
  ];

  final List<String> _servicePackages = [
    "Basic Service",
    "Premium Service",
    "VIP Service",
  ];

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    setState(() => _isLoading = true);
    String? token = widget.token ?? await storage.read(key: 'auth_token');
    if (kDebugMode) {
      print('Token retrieved: $token');
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final now = DateTime.now();
      if (picked.isBefore(DateTime(now.year, now.month, now.day))) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a future date')),
        );
        return;
      }
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  double _calculateTotalCost() {
    return distance * costPerKm;
  }

  Future<bool> _createBooking(String paymentMethod) async {
    final totalAmount = _calculateTotalCost();
    final bookingData = {
      'name': _nameController.text,
      'phoneNumber': _phoneController.text,
      'address': _addressController.text,
      'selectedServiceType': _selectedServiceType,
      'selectedServicePackage': _selectedServicePackage,
      'selectedDate': DateFormat('yyyy-MM-dd').format(_selectedDate!),
      'selectedTime': _selectedTime!.format(context),
      'distance': distance,
      'cost': totalAmount,
      'paymentMethod': paymentMethod,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bookingData),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        if (kDebugMode) {
          print('Failed to create booking: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating booking: $e');
      }
      return false;
    }
  }

  void _showPaymentOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
            const Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.phone_android),
              title: const Text("Mobile Money"),
              onTap: () => _proceedToPayment("Mobile Money"),
            ),
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text("Bank Transfer"),
              onTap: () => _proceedToPayment("Bank Transfer"),
            ),
          ],
        ),
      ),
    );
  }

  void _proceedToPayment(String paymentMethod) async {
    Navigator.pop(context); // Close the bottom sheet

    final success = await _createBooking(paymentMethod);

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            name: _nameController.text,
            phoneNumber: _phoneController.text,
            address: _addressController.text,
            selectedServiceType: _selectedServiceType,
            selectedServicePackage: _selectedServicePackage,
            selectedDate: _selectedDate!,
            selectedTime: _selectedTime!,
            distance: distance,
            cost: _calculateTotalCost(),
            paymentMethod: paymentMethod,
          ),
        ),
      );

      // Clear the form
      _formKey.currentState!.reset();
      _nameController.clear();
      _phoneController.clear();
      _addressController.clear();
      setState(() {
        _selectedDate = null;
        _selectedTime = null;
        _selectedServiceType = _serviceTypes[0];
        _selectedServicePackage = _servicePackages[0];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking successful!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create booking')),
      );
    }
  }

  void _onNavBarTap(int index) {
    setState(() {
      // Add navigation logic here
    });
  }

  Widget _buildBookingContent() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Book Service for Survey",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 223, 127, 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _nameController,
                    label: "Full Name",
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    controller: _phoneController,
                    label: "Phone Number",
                    icon: Icons.phone,
                    inputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                    controller: _addressController,
                    label: "Address",
                    icon: Icons.home,
                  ),
                  const SizedBox(height: 25),
                  _buildDropdownField(
                    label: "Select Service Type",
                    icon: Icons.home_repair_service,
                    value: _selectedServiceType,
                    items: _serviceTypes,
                    onChanged: (val) => setState(() => _selectedServiceType = val!),
                  ),
                  const SizedBox(height: 25),
                  _buildDropdownField(
                    label: "Select Service Package",
                    icon: Icons.card_membership,
                    value: _selectedServicePackage,
                    items: _servicePackages,
                    onChanged: (val) => setState(() => _selectedServicePackage = val!),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Select Appointment Date and Time",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _selectDate(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.calendar_today_outlined),
                        label: const Text("Choose Date"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () => _selectTime(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.access_time),
                        label: const Text("Choose Time"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (_selectedDate != null)
                        Text(
                          DateFormat('EEE, MMM d, yyyy').format(_selectedDate!),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      const SizedBox(width: 10),
                      if (_selectedTime != null)
                        Text(
                          _selectedTime!.format(context),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && _selectedDate != null && _selectedTime != null) {
                          _showPaymentOptions();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please complete all fields, including date and time')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 152, 34, 1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Proceed to Payment",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.orange.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
      validator: (value) => value!.isEmpty ? "Please enter your $label" : null,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.orange.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: _buildBookingContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: _onNavBarTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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

class PaymentScreen extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String address;
  final String selectedServiceType;
  final String selectedServicePackage;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final double distance;
  final double cost;
  final String paymentMethod;

  const PaymentScreen({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.selectedServiceType,
    required this.selectedServicePackage,
    required this.selectedDate,
    required this.selectedTime,
    required this.distance,
    required this.cost,
    required this.paymentMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Payment"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello, $name", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Service: $selectedServiceType - $selectedServicePackage"),
            Text("Address: $address"),
            Text("Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
            Text("Time: ${selectedTime.format(context)}"),
            const Divider(height: 30),
            Text("Distance: ${distance.toStringAsFixed(2)} km"),
            Text("Amount to Pay: \$${cost.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text("Payment Method: $paymentMethod"),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment Successful!')),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text("Pay Now", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}