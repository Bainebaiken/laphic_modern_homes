import 'package:flutter/material.dart';

class TermsAndPrivacyScreen extends StatefulWidget {
  const TermsAndPrivacyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TermsAndPrivacyScreenState createState() => _TermsAndPrivacyScreenState();
}

class _TermsAndPrivacyScreenState extends State<TermsAndPrivacyScreen> {
  bool _isChecked = false; // Tracks user agreement

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Privacy Policy"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Terms and Conditions",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "By using this app, you agree to the following terms: \n"
                      "1. You must use the app lawfully.\n"
                      "2. You are responsible for maintaining account security.\n"
                      "3. Misuse of the app may lead to account termination.\n"
                      "4. Payments are securely processed via third-party services.\n",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "Privacy Policy",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "We take your privacy seriously. We collect and store personal data to improve our services.\n"
                      "1. Data collected: Name, email, location.\n"
                      "2. Your data will not be sold to third parties.\n"
                      "3. You can request data deletion at any time.\n"
                      "4. We use encryption to protect your information.\n",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _isChecked = newValue ?? false;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text("I agree to the Terms & Privacy Policy."),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isChecked ? Colors.green : Colors.grey,
              ),
              onPressed: _isChecked
                  ? () {
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text("Agree & Continue", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
