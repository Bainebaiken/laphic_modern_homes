// import 'dart:convert';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationsScreen extends StatefulWidget {
  final String token; // JWT token for authentication
  const NotificationsScreen({Key? key, required this.token}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late Future<List<Map<String, dynamic>>> _notificationsFuture;
  static const String baseUrl = 'http://your-backend-url.com'; // Replace with your Flask backend URL
  static const String notificationsEndpoint = '/notifications/get';
  static const String updateNotificationEndpoint = '/notifications/update';

  @override
  void initState() {
    super.initState();
    _notificationsFuture = _fetchNotifications();
  }

  // Fetch notifications for the logged-in user
  Future<List<Map<String, dynamic>>> _fetchNotifications() async {
    final response = await http.get(
      Uri.parse('$baseUrl$notificationsEndpoint'),
      headers: {
        'Authorization': 'Bearer ${widget.token}', // JWT token for authentication
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> notificationsJson = jsonDecode(response.body);
      return notificationsJson.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load notifications: ${response.statusCode}');
    }
  }

  // Mark a notification as read
  Future<void> _markNotificationAsRead(int notificationId, bool read) async {
    final response = await http.put(
      Uri.parse('$baseUrl$updateNotificationEndpoint/$notificationId'),
      headers: {
        'Authorization': 'Bearer ${widget.token}', // JWT token for authentication
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'read': read}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update notification: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color deepBlue = const Color(0xFF080F2B);
    final Color orange = Colors.orange;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepBlue,
        title: const Text('Notifications', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _notificationsFuture = _fetchNotifications();
          });
        },
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _notificationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No notifications', style: TextStyle(fontSize: 18)));
            }

            final notifications = snapshot.data!;

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final bool isRead = notification['read'] ?? false;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: isRead ? Colors.grey.shade100 : Colors.white, // Highlight unread notifications
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: orange,
                      child: Icon(
                        notification['message'].contains('Booking')
                            ? Icons.book
                            : notification['message'].contains('Message')
                                ? Icons.message
                                : Icons.local_offer,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      notification['message'].split(':').first.trim(), // Extract title from message
                      style: TextStyle(
                        fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(notification['message']),
                    trailing: Text(
                      _formatTime(notification['created_at']),
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                    onTap: () async {
                      if (!isRead) {
                        try {
                          await _markNotificationAsRead(notification['id'], true);
                          setState(() {
                            _notificationsFuture = _fetchNotifications();
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error marking notification as read: $e')),
                          );
                        }
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tapped: ${notification['message']}')),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Helper method to format the timestamp
  String _formatTime(String createdAt) {
    final dateTime = DateTime.parse(createdAt);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    }
  }
}