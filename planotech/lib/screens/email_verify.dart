import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:planotech/screens/customer_login.dart';
import 'package:planotech/screens/signup_screen.dart';
import 'package:planotech/screens/signup_service.dart';

class OTPController {
  bool validateOTP(String otp) {
    return otp.length == 4;
  }
}

// ignore: must_be_immutable
class EmailVerifyOTP extends StatefulWidget {
  Signup_Service service = Signup_Service();
  String email="";

  EmailVerifyOTP({required this.email});

  @override
  _EmailVerifyOTPState createState() => _EmailVerifyOTPState(email: email);
}
class _EmailVerifyOTPState extends State<EmailVerifyOTP> {
  final TextEditingController _otpController = TextEditingController();
  final OTPController otpController = OTPController();
  bool isResendBlinking = false;
  bool isResendButtonEnabled = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _responseMessage = '';
  final String email;

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

  _EmailVerifyOTPState({required this.email});

  Future<void> _verifyOTP() async {
    final String otp = _otpController.text;

    final Uri url = Uri.parse('http://13.201.213.5:4040/pte/signupotpverification');
    var requestBody = json.encode({'userEmail': email, 'userOtp': otp});

    try {
      final http.Response response = await http.post(
        url,
        body: requestBody,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['statusMessage'] == 'pass') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Customer_login(email: email),
            ),
          );
        } else {
          showSnackbar('Invalid OTP or Please enter a valid OTP.', Colors.red);
        }
      } else {
        showSnackbar('An error occurred. Please try again later.', Colors.red);
      }
    } catch (error) {
      showSnackbar('An error occurred. Please try again later.', Colors.red);
    }
  }


  Future<void> resendOTP(String email) async {
    print("---------");
    print(email);
    print("---------");
    try {
      final Uri resendUrl =
      Uri.parse('http://13.201.213.5:4040/pte/signupresendotp?email=$email');
      final http.Response resendResponse = await http.post(
        resendUrl,
      );
      print(resendResponse.body);

      if (resendResponse.statusCode == 200) {
        final Map<String, dynamic> responseData =
        jsonDecode(resendResponse.body);

        if (responseData['status'] == true) {
          showSnackbar('OTP Resent successfully', Colors.green);
        } else {
          showSnackbar('Failed to resend OTP', Colors.red);
        }
      } else {
        showSnackbar('Failed to resend OTP', Colors.red);
      }
    } catch (e) {
      print('Error resending OTP: $e');
      showSnackbar('Failed to resend OTP', Colors.red);
    }
  }

  void showSnackbar(String message, Color color) {
    Color backgroundColor = color == Colors.red ? Colors.red : Colors.green;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Center(
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
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
                builder: (context) => const SignUpScreen(),
              ),
            );
          },
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
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
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter OTP';
                  //   }
                  //   return null;
                  // },
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate() &&
                        isResendButtonEnabled) {
                      setState(() {
                        isResendButtonEnabled = true;
                        isResendButtonEnabled = false;
                      });

                      await resendOTP(email);

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
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _verifyOTP,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text('Verify OTP'), // This line was missing in your code
                ),
                const SizedBox(height: 10.0),
                if (_responseMessage.isNotEmpty)
                  Text(
                    _responseMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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