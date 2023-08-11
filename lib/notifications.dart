import 'package:flutter/material.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool _receivePushNotifications = true;
  bool _dndEnabled = false;
  bool _vibrationEnabled = false;
  int _selectedFrequency = 1;
  bool _inAppNotificationsEnabled = true;

  void _toggleReceivePushNotifications(bool value) {
    setState(() {
      _receivePushNotifications = value;
    });
  }

  void _toggleDND(bool value) {
    setState(() {
      _dndEnabled = value;
    });
  }

  void _toggleVibration(bool value) {
    setState(() {
      _vibrationEnabled = value;
    });
  }

  void _setSelectedFrequency(int value) {
    setState(() {
      _selectedFrequency = value;
    });
  }

  void _toggleInAppNotifications(bool value) {
    setState(() {
      _inAppNotificationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            SwitchListTile(
              title: Text('Receive Push Notifications'),
              subtitle: Text('Turn on or off push notifications.'),
              value: _receivePushNotifications,
              onChanged: _toggleReceivePushNotifications,
            ),
            Divider(),
            ListTile(
              title: Text('DND'),
              subtitle: Text('Make to not disturb you'),
              trailing: Switch(
                value: _dndEnabled,
                onChanged: _toggleDND,
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Vibration'),
              subtitle: Text('Configure vibration settings.'),
              trailing: Switch(
                value: _vibrationEnabled,
                onChanged: _toggleVibration,
              ),
            ),
            Divider(),
            ListTile(
              title: Text('In-App Notifications'),
              subtitle: Text('Enable in-app notifications.'),
              trailing: Switch(
                value: _inAppNotificationsEnabled,
                onChanged: _toggleInAppNotifications,
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Notification Frequency'),
              subtitle: Text('Set the frequency of notifications.'),
              trailing: DropdownButton<int>(
                value: _selectedFrequency,
                onChanged: (int? newValue) {
                  _setSelectedFrequency(newValue ?? 1);
                },
                items: [
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text('Daily'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text('Weekly'),
                  ),
                  DropdownMenuItem<int>(
                    value: 3,
                    child: Text('Monthly'),
                  ),
                  DropdownMenuItem<int>(
                    value: 3,
                    child: Text('Yearly'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
