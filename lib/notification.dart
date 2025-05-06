import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color deepBlue = const Color(0xFF080F2B);
    final Color orange = Colors.orange;

    // Placeholder notifications
    final List<Map<String, String>> notifications = [
      {
        'title': 'Booking Confirmed',
        'description': 'Your construction booking for 2025-04-25 is confirmed.',
        'time': '2 hours ago',
      },
      {
        'title': 'New Message',
        'description': 'You have a new message from the support team.',
        'time': '1 day ago',
      },
      {
        'title': 'Offer Expiring',
        'description': '40% off painting services expires tomorrow!',
        'time': '3 days ago',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepBlue,
        title: const Text('Notifications', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: notifications.isEmpty
          ? const Center(child: Text('No notifications', style: TextStyle(fontSize: 18)))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: orange,
                      child: Icon(
                        notification['title']!.contains('Booking')
                            ? Icons.book
                            : notification['title']!.contains('Message')
                                ? Icons.message
                                : Icons.local_offer,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      notification['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(notification['description']!),
                    trailing: Text(
                      notification['time']!,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    onTap: () {
                      // Handle notification tap (e.g., navigate to related screen)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tapped: ${notification['title']}')),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}