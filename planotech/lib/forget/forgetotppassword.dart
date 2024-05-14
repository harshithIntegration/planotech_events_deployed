import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:planotech/forget/forgetpassword_email.dart';
import 'package:planotech/forget/newpassword.dart';

class OTPController {
  bool validateOTP(String otp) {
    return otp.length == 4;
  }
}

class ForgotPasswordOTP extends StatefulWidget {
  final String email;

  const ForgotPasswordOTP({Key? key, required this.email}) : super(key: key);

  @override
  _ForgotPasswordOTPState createState() => _ForgotPasswordOTPState();
}

class _ForgotPasswordOTPState extends State<ForgotPasswordOTP> {
  final TextEditingController _otpController = TextEditingController();
  bool isResendButtonEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    startResendTimer();
    print('Email: ${widget.email}');
  }

  void startResendTimer() {
    Timer(Duration(seconds: 10), () {
      setState(() {
        isResendButtonEnabled = true;
      });
    });
  }

  Future<void> verifyOTP(String otp) async {
    print('OTP: $otp'); // Print the OTP
    try {
      var response = await http.post(
        Uri.parse('http://13.201.213.5:4040/pte/otpverification'),
        body: {
          'email': widget.email,
          'otp': otp,
        },
      );
      print(response.body);
      var responseData = jsonDecode(response.body);
      String message = responseData['message'];
      bool status = responseData['status'];

      if (status) {
         showSnackBar('Verify OTP successful', Colors.green);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewPasswordPage(email: widget.email),
          ),
        );
      } else {
        displaySnackBar(message); // Display Snackbar for invalid OTP
      }
    } catch (e) {
      // Display snackbar for error
      displaySnackBar('Enter valid OTP ');
    }
  }

  void displaySnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 64, 144, 209),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white, // Foreground color
          ),
        ),
      ),
    );
  }

  void showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

 Future<void> resendOTP(String email) async {
  try {
    final Uri resendUrl =
        Uri.parse('http://13.201.213.5:4040/pte/resendotp');
    final http.Response resendResponse = await http.post(
      resendUrl,
      body: {
        'email': email,
      },
    ); print(resendResponse.body);

    if (resendResponse.statusCode == 200) {
      final Map<String, dynamic> responseData =
          jsonDecode(resendResponse.body);

      if (responseData['status'] == true) {
        // OTP successfully resent
        showErrorMessage('OTP Resent successfully');
      } else {
        showErrorMessage('Failed to resend OTP');
      }
    } else {
      showErrorMessage('Failed to resend OTP');
    }
  } catch (e) {
    print('Error resending OTP: $e');
    showErrorMessage('Failed to resend OTP');
  }
}


  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm OTP'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Forgotpassword_Email(),
              ),
            );
          },
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 64, 144, 209),
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter OTP',
                    hintText: 'Enter your valid OTP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  maxLength: 4,

                ),


                  SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate() &&
                        isResendButtonEnabled) {
                      setState(() {
                        isResendButtonEnabled = true;
                        isResendButtonEnabled = false;
                      });

                      await resendOTP(widget.email);

                      // Reset the timer and UI after a delay
                      startResendTimer();
                      Timer(Duration(milliseconds: 30), () {
                        setState(() {
                          isResendButtonEnabled = false;
                        });
                      });
                    }
                  },
                  child: AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 30),
                    style: TextStyle(
                      color: isResendButtonEnabled
                          ? const Color.fromARGB(255, 64, 144, 209)
                          : Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text('  Resend OTP'),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      verifyOTP(_otpController.text);
                    }
                  },
                  child: Text('Verify OTP'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 64, 144, 209),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
