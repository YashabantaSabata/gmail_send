import 'package:flutter/material.dart';

class PrivacySecurity extends StatelessWidget {
  const PrivacySecurity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Security'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Privacy Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            PrivacySettingsSection(),
            Divider(),
            Text(
              'Security Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SecuritySettingsSection(),
          ],
        ),
      ),
    );
  }
}

class PrivacySettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.lock, color: Colors.white),
          ),
          title: Text('Profile Visibility'),
          subtitle: Text('Manage the visibility of your profile.'),
          onTap: () {
            
          },
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.schedule, color: Colors.white),
          ),
          title: Text('Show Activity Status'),
          subtitle: Text('Display when you were last active.'),
          onTap: () {
            _showActivityStatusDialog(context);
          },
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(Icons.block, color: Colors.white),
          ),
          title: Text('Blocked Users'),
          subtitle: Text('Manage users you have blocked.'),
          onTap: () {
            
          },
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(Icons.location_on, color: Colors.white),
          ),
          title: Text('Location Privacy'),
          subtitle: Text('Control who can see your location information.'),
          onTap: () {
            
          },
        ),
      ],
    );
  }
}

class SecuritySettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            child: Icon(Icons.privacy_tip, color: Colors.white),
          ),
          title: Text('Two-Factor Authentication'),
          subtitle: Text('Enable extra layer of security with 2FA.'),
          onTap: () {
            
          },
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.lock, color: Colors.white),
          ),
          title: Text('Password Reset'),
          subtitle: Text('Manage your password reset options.'),
          onTap: () {
            _showPasswordResetDialog(context);
          },
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.teal,
            child: Icon(Icons.devices, color: Colors.white),
          ),
          title: Text('Manage Devices'),
          subtitle: Text('View and manage devices that are logged in.'),
          onTap: () {
            
          },
        ),
      ],
    );
  }
}

void _showActivityStatusDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Activity Status Details'),
        content: Text('You were last active 1 hour ago.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

void _showPasswordResetDialog(BuildContext context) {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Password Reset Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: currentPasswordController,
              decoration: InputDecoration(labelText: 'Current Password'),
            ),
            TextFormField(
              controller: newPasswordController,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm New Password'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              String currentPassword = currentPasswordController.text;
              String newPassword = newPasswordController.text;
              String confirmPassword = confirmPasswordController.text;

              if (currentPassword.isNotEmpty &&
                  newPassword.isNotEmpty &&
                  confirmPassword.isNotEmpty &&
                  newPassword == confirmPassword) {
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Password Reset Error'),
                      content: Text('Invalid input. Please check your entries.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Text('Reset Password'),
          ),
        ],
      );
    },
  );
}
