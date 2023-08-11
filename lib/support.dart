import 'package:flutter/material.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we Help you?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tell Us Your Problems we will try to solve',
              style: TextStyle(fontSize: 16),
            ),
            
            SizedBox(height: 16),
            Text(
              'Do not forget to Give Us Your Feedback!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            Center(
              child: buildSupportButton(context, 'Contact Support'),
            ),
            SizedBox(height: 16),
            Center(
              child: buildSupportButton(context, 'Report an Issue'),
            ),
            SizedBox(height: 16),
            Center(
              child: buildSupportButton(context, 'Give Feedback'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSupportButton(BuildContext context, String buttonText) {
    return ElevatedButton(
      onPressed: () {
        _showMessageDialog(context, buttonText);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(buttonText),
    );
  }

  void _showMessageDialog(BuildContext context, String messageTitle) {
    TextEditingController messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(messageTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: messageController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    hintText: 'Enter your message here...',
                  ),
                ),
              ],
            ),
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
                String message = messageController.text;

                if (message.isNotEmpty) {
                  Navigator.pop(context);
                  _showSuccessDialog(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Message Error'),
                        content: Text('Please enter a valid message.'),
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
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Send Message'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message Sent'),
          content: Text('Your message has been sent successfully.'),
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
}
