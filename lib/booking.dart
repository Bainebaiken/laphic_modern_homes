





// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'payment_screen.dart';

// class BookingScreen extends StatefulWidget {
//   const BookingScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _BookingScreenState createState() => _BookingScreenState();
// }

// class _BookingScreenState extends State<BookingScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   DateTime? _selectedDate;
//   String _selectedService = "Basic Service";
//   final double _distance = 10.0; // Example distance
//   final double _serviceCost = 50.0; // Example cost

//   final List<String> _services = ["Basic Service", "Premium Service", "VIP Service"];

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
//             selectedService: _selectedService,
//             selectedDate: _selectedDate!,
//             distance: _distance,
//             cost: _serviceCost,
//           ),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please complete all fields")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Book a Service"), backgroundColor: Colors.orange),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
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
//               const SizedBox(height: 10),
//               DropdownButtonFormField<String>(
//                 value: _selectedService,
//                 decoration: const InputDecoration(labelText: "Select Service"),
//                 items: _services.map((service) {
//                   return DropdownMenuItem(value: service, child: Text(service));
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedService = value!;
//                   });
//                 },
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => _selectDate(context),
//                     child: const Text("Select Date"),
//                   ),
//                   const SizedBox(width: 10),
//                   if (_selectedDate != null)
//                     Text(DateFormat('EEE, MMM d, yyyy').format(_selectedDate!)),
//                 ],
//               ),
//               const Spacer(),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _proceedToPayment,
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
//                   child: const Text("Proceed to Payment"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'payment_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedServiceType = "Painting";
  String _selectedServicePackage = "Basic Service";
  final double _distance = 10.0; // Example distance
  final double _serviceCost = 50.0; // Example cost

  // Service types
  final List<String> _serviceTypes = [
    "Painting", 
    "Compound Design", 
    "Gypsum Work", 
    "Aluminum Works", 
    "Renovation", 
    "Interior Design"
  ];

  // Service packages
  final List<String> _servicePackages = ["Basic Service", "Premium Service", "VIP Service"];

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _proceedToPayment() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
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
            distance: _distance,
            cost: _serviceCost, selectedService: '',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book a Service"), backgroundColor: Colors.orange),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) => value!.isEmpty ? "Enter your name" : null,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: "Phone Number"),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.isEmpty ? "Enter your phone number" : null,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: "Address"),
                  validator: (value) => value!.isEmpty ? "Enter your address" : null,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Service Type",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedServiceType,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: _serviceTypes.map((service) {
                    return DropdownMenuItem(value: service, child: Text(service));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedServiceType = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Service Package",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedServicePackage,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: _servicePackages.map((service) {
                    return DropdownMenuItem(value: service, child: Text(service));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedServicePackage = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Select Date",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade200,
                      ),
                      child: const Text("Choose Date"),
                    ),
                    const SizedBox(width: 10),
                    if (_selectedDate != null)
                      Text(DateFormat('EEE, MMM d, yyyy').format(_selectedDate!)),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _proceedToPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, 
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "Proceed to Payment",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}