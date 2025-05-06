// below is the code for settings screen 

import 'package:flutter/material.dart';
// Import to access ThemeProvider

class SettingScreen extends StatefulWidget {
  final bool isDarkMode;
  const SettingScreen({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SettingScreen> {
  late bool _isDarkMode;
  late ThemeProvider _themeProvider;

  // @override
  // void initState() {
  //   super.initState();
  //   _isDarkMode = widget.isDarkMode;
    
  //   // Get ThemeProvider from the widget tree
  //   // You'll need to either pass it as a parameter or use Provider package
  //   // For now we'll create a local instance
  //   _themeProvider = ThemeProvider(initialDarkMode: _isDarkMode);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0E4647),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color.fromARGB(255, 35, 53, 38)),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF023C3E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0E4647),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white70),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        sliderTheme: SliderThemeData(
          thumbColor: Colors.white,
          activeTrackColor: Colors.white.withOpacity(0.7),
          inactiveTrackColor: Colors.white.withOpacity(0.3),
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SettingsScreen(
        onThemeChanged: (isDark) {
          setState(() {
            _isDarkMode = isDark;
          });
          _themeProvider.setDarkMode(isDark);
        }, 
        isDarkMode: _isDarkMode
      ),
    );
  }
}

class ThemeProvider {
  void setDarkMode(bool isDark) {}
}

class SettingsScreen extends StatefulWidget {
  final void Function(bool isDark) onThemeChanged;
  final bool isDarkMode;
  const SettingsScreen({Key? key, required this.onThemeChanged, required this.isDarkMode, }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  double _fontSize = 16.0;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark 
        ? Colors.white.withOpacity(0.7) 
        : Colors.black.withOpacity(0.6);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildSectionTitle('PREFERENCES'),
          SwitchListTile(
            title: Text('Dark Mode', style: TextStyle(color: textColor)),
            subtitle: Text('Enable dark theme', style: TextStyle(color: subtitleColor)),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
              widget.onThemeChanged(value);
            },
          ),
          SwitchListTile(
            title: Text('Notifications', style: TextStyle(color: textColor)),
            subtitle: Text('Enable push notifications', style: TextStyle(color: subtitleColor)),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          ListTile(
            title: Text('Language', style: TextStyle(color: textColor)),
            subtitle: DropdownButton<String>(
              value: _selectedLanguage,
              dropdownColor: isDark ? const Color(0xFF0E4647) : Colors.white,
              // Fixed extra parenthesis in items mapping
              items: ['English', 'French', 'Spanish', 'German']
                  .map((lang) => DropdownMenuItem(
                      value: lang, 
                      child: Text(
                        lang, 
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black
                        )
                      )
                    )
                  ).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                }
              },
            ),
            leading: Icon(Icons.language, color: textColor),
          ),
          ListTile(
            title: Text('Font Size', style: TextStyle(color: textColor)),
            subtitle: Slider(
              value: _fontSize,
              min: 12,
              max: 24,
              divisions: 6,
              label: "${_fontSize.round()}",
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),
            leading: Icon(Icons.text_fields, color: textColor),
          ),
          _buildSectionTitle('ACCOUNT'),
          _buildListTile('Manage Account', Icons.account_circle, const AccountScreen()),
          _buildListTile('Privacy Policy', Icons.privacy_tip, const PrivacyPolicyScreen()),
          _buildListTile('Terms & Conditions', Icons.article, const TermsConditionsScreen()),

          _buildSectionTitle('FEEDBACK'),
          _buildListTile('Rate App', Icons.star, null),
          _buildListTile('Send Feedback', Icons.feedback, null),

          _buildSectionTitle('OTHERS'),
          ListTile(
            title: const Text('Log Out', style: TextStyle(color: Colors.red)),
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LogoutScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, Widget? screen) {
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    
    return ListTile(
      title: Text(title, style: TextStyle(color: textColor)),
      leading: Icon(icon, color: textColor),
      onTap: screen != null
          ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen))
          : () {},
    );
  }

  Widget _buildSectionTitle(String title) {
    final sectionColor = Theme.of(context).brightness == Brightness.dark 
        ? Colors.white.withOpacity(0.7) 
        : Colors.black.withOpacity(0.6);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: Text(
        title, 
        style: TextStyle(
          color: sectionColor, 
          fontWeight: FontWeight.bold
        )
      ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const  AccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    
    return Scaffold(
      appBar: AppBar(title: const Text('Account Settings')),
      body: Center(
        child: Text(
          'Account settings details go here', 
          style: TextStyle(color: textColor)
        )
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Your privacy is important to us. We collect minimal data to enhance your experience with our app.',
          textAlign: TextAlign.justify,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    final headerColor = Theme.of(context).brightness == Brightness.dark 
        ? Colors.white 
        : const Color(0xFF53653D);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Terms & Conditions', 
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold, 
                color: headerColor
              )
            ),
            const SizedBox(height: 10),
            Text(
              '1. Users must be at least 13 years old to use this app.', 
              style: TextStyle(color: textColor)
            ),
            Text(
              '2. Content is for personal use only; redistribution is prohibited.', 
              style: TextStyle(color: textColor)
            ),
            Text(
              '3. Unauthorized access or modification of the app is not allowed.', 
              style: TextStyle(color: textColor)
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutScreen extends StatelessWidget {
 const LogoutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Out')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Log Out', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
