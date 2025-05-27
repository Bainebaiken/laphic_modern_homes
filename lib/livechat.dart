import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laphic_app/login_screen.dart'; // Import your login screen

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Color deepBlue = const Color(0xFF080F2B);
  final Color orange = Colors.orange;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Placeholder customer UID; replace with dynamic value in production
  final String customerUid = 'customer123';
  String? chatId;
  String? userRole;
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('ChatPage: initState called');
    }
    _initializeChat();
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print('ChatPage: dispose called');
    }
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeChat() async {
    if (kDebugMode) {
      print('ChatPage: _initializeChat started');
    }
    final user = _auth.currentUser;
    if (user == null) {
      if (kDebugMode) {
        print('ChatPage: User not authenticated, redirecting to login');
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      });
      setState(() {
        _isInitializing = false;
      });
      return;
    }

    if (kDebugMode) {
      print('ChatPage: User authenticated, UID: ${user.uid}');
    }
    // Determine user role (hardcoded for demo; fetch from Firestore in production)
    userRole = 'provider';
    // Generate chat ID by combining UIDs in a consistent order
    chatId = user.uid.compareTo(customerUid) < 0
        ? '${user.uid}_$customerUid'
        : '$customerUid${user.uid}';
    if (kDebugMode) {
      print('ChatPage: chatId set to $chatId');
    }
    setState(() {
      _isInitializing = false;
    });
    if (kDebugMode) {
      print('ChatPage: _initializeChat completed');
    }
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty || chatId == null || userRole == null) {
      if (kDebugMode) {
        print('ChatPage: Cannot send message, invalid state');
      }
      return;
    }

    final user = _auth.currentUser;
    if (user == null) {
      if (kDebugMode) {
        print('ChatPage: User not authenticated when sending message');
      }
      return;
    }

    final message = {
      'senderId': user.uid,
      'senderRole': userRole,
      'text': _messageController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      if (kDebugMode) {
        print('ChatPage: Sending message to Firestore');
      }
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(message);
      _messageController.clear();
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('ChatPage: Error sending message: $e');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending message: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print('ChatPage: build called, _isInitializing: $_isInitializing, chatId: $chatId');
    }
    if (_isInitializing || chatId == null) {
      if (kDebugMode) {
        print('ChatPage: Showing loading UI');
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: deepBlue,
          title: const Text('Live Chat', style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              if (kDebugMode) {
                print('ChatPage: Back button pressed');
              }
              Navigator.pop(context);
            },
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (kDebugMode) {
      print('ChatPage: Showing chat UI');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: deepBlue,
        title: const Text('Live Chat', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (kDebugMode) {
              print('ChatPage: Back button pressed');
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (kDebugMode) {
                  print('ChatPage: StreamBuilder builder called, connectionState: ${snapshot.connectionState}');
                }
                if (snapshot.hasError) {
                  if (kDebugMode) {
                    print('ChatPage: StreamBuilder error: ${snapshot.error}');
                  }
                  return const Center(child: Text('Error loading messages'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  if (kDebugMode) {
                    print('ChatPage: StreamBuilder waiting for data');
                  }
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;
                if (kDebugMode) {
                  print('ChatPage: StreamBuilder received ${messages.length} messages');
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients && messages.isNotEmpty) {
                    if (kDebugMode) {
                      print('ChatPage: Scrolling to bottom');
                    }
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                });

                if (messages.isEmpty) {
                  if (kDebugMode) {
                    print('ChatPage: No messages found');
                  }
                  return const Center(
                    child: Text(
                      'No messages yet. Start the conversation!',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index].data() as Map<String, dynamic>;
                    final isMe = message['senderId'] == _auth.currentUser?.uid;
                    final timestamp = (message['timestamp'] as Timestamp?)?.toDate();

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe ? orange : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              message['text'] ?? '',
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              timestamp != null
                                  ? DateFormat('HH:mm').format(timestamp)
                                  : 'Sending...',
                              style: TextStyle(
                                fontSize: 10,
                                color: isMe ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    if (kDebugMode) {
      print('ChatPage: Building message input');
    }
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey.shade100,
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
                fillColor: Colors.white,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: deepBlue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}


