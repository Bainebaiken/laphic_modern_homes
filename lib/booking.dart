import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _phoneNumber;
  String? _address; // Fixed address field
  String? _selectedService;
  DateTime? _selectedDate;

  final List<String> _services = [
    "Compound Design",
    "Construction",
    "Painting",
    "Interior Design",
    "Metal Fabrication",
    "Gypsum Works",
    "Furniture Works",
  ];

  void _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _proceedToPayment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            name: _name!,
            phoneNumber: _phoneNumber!,
            address: _address!,
            selectedService: _selectedService!,
            selectedDate: _selectedDate!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Please enter your name" : null,
                onSaved: (value) => _name = value,
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Please enter your address" : null,
                onSaved: (value) => _address = value, // Fixed saving address correctly
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => (value!.isEmpty || value.length < 10) ? "Enter a valid phone number" : null,
                onSaved: (value) => _phoneNumber = value,
              ),
              const SizedBox(height: 16.0),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Select Service",
                  border: OutlineInputBorder(),
                ),
                items: _services.map((service) => DropdownMenuItem(value: service, child: Text(service))).toList(),
                validator: (value) => value == null ? "Please select a service" : null,
                onChanged: (value) => setState(() => _selectedService = value),
              ),
              const SizedBox(height: 16.0),

              GestureDetector(
                onTap: () => _pickDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    _selectedDate == null ? "Select Date" : "Date: ${_selectedDate!.toLocal()}".split(' ')[0],
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _selectedDate == null ? null : _proceedToPayment, // Disable if date is missing
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, 
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0)),
                  child: const Text("Proceed to  survey Payment", style: TextStyle(fontSize: 16.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String address;
  final String selectedService;
  final DateTime selectedDate;

  const PaymentScreen({super.key, 
  required this.name, 
  required this.phoneNumber, 
  required this.address,
  required this.selectedService, 
  required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text("Payment"),
       backgroundColor: Colors.orange),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name: $name", 
            style: const TextStyle(fontSize: 18.0)),
            const SizedBox(height: 8.0),

            Text("Phone: $phoneNumber", 
            style: const TextStyle(fontSize: 18.0)),

            Text("Address: $address", 
            style: const TextStyle(fontSize: 18.0)),
            const SizedBox(height: 8.0),
            Text("Service: $selectedService", 
            style: const TextStyle(fontSize: 18.0)),
            const SizedBox(height: 8.0),
            Text("Date: ${selectedDate.toLocal()}".split(' ')[0],
            style: const TextStyle(fontSize: 18.0)),
            const SizedBox(height: 16.0),
            
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Payment Successful"),
                  content: const Text("Thank you for your payment!"),
                  actions: [
                    TextButton(onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')), child: const Text("OK")),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0)),
              child: const Text("Pay Now", style: TextStyle(fontSize: 16.0)),
            ),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';

// class BookingScreen extends StatefulWidget {
//   const BookingScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _BookingScreenState createState() => _BookingScreenState();
// }

// class _BookingScreenState extends State<BookingScreen> {
//   final _formKey = GlobalKey<FormState>();

//   String? _name;
//   // ignore: unused_field
//   String? _phoneNumber;
//   String? _selectedService;
//   DateTime? _selectedDate;

//   final List<String> _services = [
//     "Compound Design",
//     "Construction",
//     "Painting",
//     "Interior Design",
//     "Metal Fabrication",
//     "Gypsum Works",
//     "Furniture Works",
//   ];

//   // Function to show the date picker
//   void _pickDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//     if (pickedDate != null && pickedDate != _selectedDate) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   // Function to handle booking confirmation
//   void _confirmBooking() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       // Display a confirmation message or navigate to another screen
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text("Booking Confirmed"),
//           content: Text(
//             "Thank you, $_name! Your booking for $_selectedService on ${_selectedDate!.toLocal()} has been confirmed.",
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("OK"),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Name Input Field
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: "Name",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter your name";
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _name = value;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               // Name Input Field
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: "Adress",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter your Adress";
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _name = value;
//                 },
//               ),
//               const SizedBox(height: 16.0),

//               // Phone Number Input Field
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: "Phone Number",
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter your phone number";
//                   }
//                   if (value.length < 10) {
//                     return "Enter a valid phone number";
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _phoneNumber = value;
//                 },
//               ),
//               const SizedBox(height: 16.0),

//               // Service Dropdown
//               DropdownButtonFormField<String>(
//                 decoration: const InputDecoration(
//                   labelText: "Select Service",
//                   border: OutlineInputBorder(),
//                 ),
//                 items: _services
//                     .map(
//                       (service) => DropdownMenuItem(
//                         value: service,
//                         child: Text(service),
//                       ),
//                     )
//                     .toList(),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please select a service";
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedService = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16.0),

//               // Date Picker
//               GestureDetector(
//                 onTap: () => _pickDate(context),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12.0,
//                     vertical: 16.0,
//                   ),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     _selectedDate == null
//                         ? "Select Date"
//                         : "Date: ${_selectedDate!.toLocal()}".split(' ')[0],
//                     style: const TextStyle(fontSize: 16.0),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16.0),

//               // Confirm Booking Button
//               Center(
//                 child: ElevatedButton(
//                   onPressed: _confirmBooking,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 32.0,
//                       vertical: 16.0,
//                     ),
//                   ),
//                   child: const Text(
//                     "Confirm Booking",
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
