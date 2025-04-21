import 'package:flutter/foundation.dart' show kDebugMode; // For debug logging
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String address;
  final String selectedService;
  final DateTime selectedDate;
  final double distance;
  final double cost;

  const PaymentScreen({
    Key? key, // Updated from super.key
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.selectedService,
    required this.selectedDate,
    required this.distance,
    required this.cost, required String selectedServiceType, required String selectedServicePackage,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _paymentMethod = 'Credit Card';
  bool _isProcessingPayment = false;
  bool _showMobileMoneyFields = false;

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _nameOnCardController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  late String _reference;

  final List<String> _paymentMethods = [
    'Credit Card',
    'Mobile Money',
    'Bank Transfer',
  ];

  @override
  void initState() {
    super.initState();
    _reference = "SURVEY-${DateTime.now().millisecondsSinceEpoch}";
    if (kDebugMode) print('PaymentScreen initialized with reference: $_reference');
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _nameOnCardController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessingPayment = true;
      });
      if (kDebugMode) print('Processing payment with method: $_paymentMethod');

      await Future.delayed(const Duration(seconds: 2)); // Simulate payment

      setState(() {
        _isProcessingPayment = false;
      });

      if (mounted) {
        _showPaymentSuccessDialog();
      }
    } else {
      if (kDebugMode) print('Payment form validation failed');
    }
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Payment Successful"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 70),
              const SizedBox(height: 20),
              const Text(
                "Your payment has been processed successfully!",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "A survey agent will visit your location on ${DateFormat('EEEE, MMMM d, yyyy').format(widget.selectedDate)} at ${DateFormat('h:mm a').format(widget.selectedDate)}",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCreditCardFields() {
    return Column(
      children: [
        TextFormField(
          controller: _nameOnCardController,
          decoration: const InputDecoration(labelText: "Name on Card"),
          validator: (value) => value!.isEmpty ? "Enter name on card" : null,
        ),
        TextFormField(
          controller: _cardNumberController,
          decoration: const InputDecoration(labelText: "Card Number"),
          keyboardType: TextInputType.number,
          validator: (value) => value!.length < 16 ? "Enter a valid card number" : null,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(labelText: "MM/YY"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.length < 5 ? "Enter valid expiry date" : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(labelText: "CVV"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.length < 3 ? "Enter valid CVV" : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileMoneyFields() {
    return Column(
      children: [
        TextFormField(
          controller: _mobileNumberController,
          decoration: const InputDecoration(labelText: "Mobile Money Number"),
          keyboardType: TextInputType.phone,
          validator: (value) => value!.length < 10 ? "Enter a valid phone number" : null,
        ),
      ],
    );
  }

  Widget _buildBankTransferFields() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Bank Transfer Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              const Text("Bank Name: Laphic Bank"),
              const Text("Account Name: Laphic Modern Homes Ltd"),
              const Text("Account Number: 1234567890"),
              const Text("Branch: Main Branch"),
              Text("Reference: $_reference"),
              const SizedBox(height: 10),
              const Text(
                "Please upload your payment receipt below after making the transfer",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Upload functionality to be implemented")),
            );
          },
          icon: const Icon(Icons.upload_file),
          label: const Text("Upload Payment Receipt"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment"), backgroundColor: Colors.orange),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Booking Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildSummaryRow("Name", widget.name),
                      _buildSummaryRow("Phone", widget.phoneNumber),
                      _buildSummaryRow("Service", widget.selectedService),
                      _buildSummaryRow("Address", widget.address),
                      _buildSummaryRow(
                        "Appointment",
                        "${DateFormat('EEE, MMM d, yyyy').format(widget.selectedDate)} at ${DateFormat('h:mm a').format(widget.selectedDate)}",
                      ),
                      _buildSummaryRow("Distance", "${widget.distance} km"),
                      _buildSummaryRow("Amount", "\$${widget.cost.toStringAsFixed(2)}"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text("Payment Method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: _paymentMethods.map((method) => RadioListTile<String>(
                    title: Text(method),
                    value: method,
                    groupValue: _paymentMethod,
                    activeColor: Colors.orange,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _paymentMethod = value;
                          _showMobileMoneyFields = value == 'Mobile Money';
                        });
                      }
                    },
                  )).toList(),
                ),
              ),
              const SizedBox(height: 24),
              if (_paymentMethod == 'Credit Card') _buildCreditCardFields(),
              if (_paymentMethod == 'Mobile Money') _buildMobileMoneyFields(),
              if (_paymentMethod == 'Bank Transfer') _buildBankTransferFields(),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isProcessingPayment ? null : _processPayment,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                  child: _isProcessingPayment
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text("Pay \$${widget.cost.toStringAsFixed(2)}", style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          Flexible(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}