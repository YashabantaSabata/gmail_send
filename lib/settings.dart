import 'package:flutter/material.dart';
import 'package:gmail_send/notifications.dart';
import 'package:gmail_send/privacy.dart';
import 'package:gmail_send/profile.dart';
import 'package:gmail_send/support.dart';
import 'package:gmail_send/themechange.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MySettings(),
    );
  }
}

class MySettings extends StatelessWidget {
  const MySettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SizedBox(height: 16),
          SettingsOptionCard(
            icon: Icons.account_circle,
            title: 'Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          SizedBox(height: 16),
          SettingsOptionCard(
            icon: Icons.color_lens,
            title: 'Change Theme',
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ThemeSelectionDialog();
                },
              );
            },
          ),
          SizedBox(height: 16),
          SettingsOptionCard(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationSettings()),
              );
            },
          ),
          SizedBox(height: 16),
          SettingsOptionCard(
            icon: Icons.security,
            title: 'Privacy & Security',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacySecurity()),
              );
            },
          ),
          SizedBox(height: 16),
          SettingsOptionCard(
            icon: Icons.help,
            title: 'Support',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpSupport()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SettingsOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsOptionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> avatarColors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.red,
    ];

    Color iconColor = Colors.white;

    int colorIndex = icon.hashCode % avatarColors.length;
    Color avatarColor = avatarColors[colorIndex];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        leading: CircleAvatar(
          backgroundColor: avatarColor,
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
      ),
    );
  }
}

class ThemeSelectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Select Theme'),
      children: [
        ThemeOption(
          icon: Icons.dark_mode,
          title: 'Dark Mode',
          onTap: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .setTheme(ThemeData.dark());
            Navigator.pop(context);
          },
        ),
        ThemeOption(
          icon: Icons.light_mode,
          title: 'Light Mode',
          onTap: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .setTheme(ThemeData.light());
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class ThemeOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ThemeOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> avatarColors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.red,
    ];

    Color iconColor = Colors.white;

    int colorIndex = icon.hashCode % avatarColors.length;
    Color avatarColor = avatarColors[colorIndex];

    return SimpleDialogOption(
      onPressed: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: avatarColor,
            child: Icon(icon, color: iconColor),
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
