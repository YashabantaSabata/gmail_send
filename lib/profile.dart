import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEmailValid(String email) {
    //validation for email
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }

  bool _isPhoneNumberValid(String phone) {
    //validation for mobile
    final phoneRegExp = RegExp(r'^[6-9]\d{9}$');
    return phoneRegExp.hasMatch(phone);
  }

  String generateOTP() {
    var random = Random();
    return (100000 + random.nextInt(900000)).toString();
  }

  Future<bool> sendOTP(String email, String otp) async {
    //give the email & password of sender
    final smtpServer = gmail('me.yashz1998@gmail.com', 'cbkflozriptobwws');
    final smtpMessage = Message()
      ..from = Address('me.yashz1998@gmail.com', 'Yashabanta Sabata')
      ..recipients.add(email)
      ..subject = 'OTP for Email Verification'
      ..text = 'Your OTP is: $otp';

    try {
      await send(smtpMessage, smtpServer);
      return true;
    } catch (e) {
      print('Error sending OTP: $e');
      return false;
    }
  }

  Future<String?> showOtpDialog({String? errorMessage}) async {
    String? enteredOTP;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter OTP'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (errorMessage != null) Text(errorMessage, style: TextStyle(color: Colors.red)),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) => enteredOTP = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, enteredOTP),
              child: Text('Verify'),
            ),
          ],
        );
      },
    );
    return enteredOTP;
  }

  
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogIn()),
      );
    } catch (e) {
      print('Error during logout: $e');
      // Handle any errors that might occur during logout
    }
  }

  void handleSave() async {
    final newEmail = emailController.text;
    final newPhone = phoneController.text;

    if (_isEmailValid(newEmail) && _isPhoneNumberValid(newPhone)) {
      final String otp = generateOTP();
      bool otpSent = await sendOTP(newEmail, otp);

      if (otpSent) {
        String? enteredOTP = await showOtpDialog();

        if (enteredOTP == otp) {
          setState(() {
            name = nameController.text;
            vendorName = vendorNameController.text;
            email = newEmail;
            phone = newPhone;
            address = addressController.text;
            editMode = false;
          });
        } else {
          setState(() {
            isEmailValid = true;
            isPhoneNumberValid = true;
          });
          await showOtpDialog(errorMessage: 'Invalid OTP, Enter again.');
        }
      } else {
        print('Failed to send OTP.');
      }
    } else {
      setState(() {
        isEmailValid = _isEmailValid(newEmail);
        isPhoneNumberValid = _isPhoneNumberValid(newPhone);
      });
    }
  }

  String name = "Namma Shop";
  String vendorName = "Viswas EnterPrises Pvt. Ltd.";
  String email = "me.yashz1998@gmail.com";
  String phone = "7381314007";
  String address = "Berhampur, Odisha";

  TextEditingController nameController = TextEditingController();
  TextEditingController vendorNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  File? imageFile;
  bool editMode = false;
  bool isEmailValid = true;
  bool isPhoneNumberValid = true;

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = name;
    vendorNameController.text = vendorName;
    emailController.text = email;
    phoneController.text = phone;
    addressController.text = address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            //Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(editMode ? Icons.done : Icons.edit),
            onPressed: () {
              if (editMode) {
                handleSave();
              } else {
                setState(() {
                  editMode = !editMode;
                });
              }
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('img/1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80),
                  InkWell(
                    onTap: () => pickImage(ImageSource.gallery),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: 130,
                        height: 130,
                        child: Center(
                          child: imageFile != null
                              ? Image.file(
                                  imageFile!,
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'img/wtch.jpg',
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  buildProfileField("Shop Name", Icons.shop, nameController),
                  SizedBox(height: 10),
                  buildProfileField("Vendor Name", Icons.person, vendorNameController),
                  SizedBox(height: 10),
                  buildProfileField("Email", Icons.email, emailController),
                  //error message for email
                  if (!isEmailValid)
                    Padding(
                      padding: const EdgeInsets.only(right: 48),
                      child: Text(
                        'Please enter a valid email address.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(height: 10),
                  buildProfileField("Phone", Icons.phone, phoneController),
                  //error message for mobile
                  if (!isPhoneNumberValid)
                    Padding(
                      padding: const EdgeInsets.only(right: 48),
                      child: Text(
                        'Mobile number should be 10 digits.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(height: 10),
                  buildProfileField("Address", Icons.location_on, addressController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      logout();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 12.0),
                      child: Text('Logout'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "© 2023, Copyright Reserved By Edevlop",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileField(String label, IconData icon, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey, //border of each row
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Row(
            children: [
              SizedBox(width: 16),
              Icon(icon),
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  enabled: editMode,
                  onChanged: (value) {
                    if (label == "Email") {
                      setState(() {
                        isEmailValid = _isEmailValid(value);
                      });
                    } else if (label == "Phone") {
                      setState(() {
                        isPhoneNumberValid = _isPhoneNumberValid(value);
                        if (value.length > 10) {
                          controller.text = value.substring(0, 10);
                          controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
                        }
                      });
                    }
                  },
                  keyboardType: label == "Phone" ? TextInputType.phone : TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
