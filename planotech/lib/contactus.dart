                                                                                                                                                     import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:planotech/dashboard.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool isSubmitEnabled = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(checkSubmitButton);
    emailController.addListener(checkSubmitButton);
    messageController.addListener(checkSubmitButton);
  }

  void checkSubmitButton() {
    setState(() {
      isSubmitEnabled = nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          messageController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 64, 144, 209),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/coc.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            buildTextField(nameController, 'Your Name'),
            const SizedBox(height: 10.0),
            buildTextField(emailController, 'Your Email'),
            const SizedBox(height: 10.0),
            buildTextField(messageController, 'Your Message', maxLines: 5),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: isSubmitEnabled ? submitForm : null,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      {int maxLines = 1}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
        ),
        maxLines: maxLines,
      ),
    );
  }

  void submitForm() async {
    String name = nameController.text;
    String email = emailController.text;
    String message = messageController.text;

    DateTime now = DateTime.now();
    String date = DateFormat('dd-MM-yyyy', 'en_US').format(now);
    String time = DateFormat('hh:mm a', 'en_US').format(now);

    print(name);
    print(email);
    print(message);
    print(date);
    print(time);

    final result = await sendDataToServer(name, email, message, date, time);

    if (result) {
      showSnackBar(context, 'Successfully submitted', Colors.green);
      nameController.clear();
      emailController.clear();
      messageController.clear();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    } else {
      showSnackBar(context, 'Error submitting data', Colors.red);
    }
  }

  Future<bool> sendDataToServer(
      String name, String email, String message, String date, String time) async {
    final url = Uri.parse('http://13.201.213.5:4040/pte/contactus');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'name': name,
          'email': email,
          'message': message,
          'date': date,
          'time': time,
        }),
      );
      print(response.body);
      print('');
      final jsonResponse = json.decode(response.body);
      if (jsonResponse is Map &&
          jsonResponse.containsKey('status') &&
          jsonResponse.containsKey('message')) {
        if (jsonResponse['status'] == true &&
            jsonResponse['message'] == 'Message Sent') {
          print(jsonResponse);
          print('Data sent successfully');
          return true;
        } else {
          print('Failed to send data: ${jsonResponse['message']}');
          return false;
        }
      } else {
        print('Invalid response format: $jsonResponse');
        return false;
      }
    } catch (e) {
      print('Error sending data: $e');
      return false;
    }
  }

  void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
      ),
    );
  }
}