// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:planotech/screens/email_verify.dart';
// import 'customer_login.dart';
// import 'signup_service.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formSignupKey = GlobalKey<FormState>();
//   bool agreePersonalData = true;
//   bool _isPasswordVisible = false;
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   Signup_Service service = Signup_Service();
//   String _responseMessage = '';
//   bool _isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/final.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               top: 40.0,
//               left: 10.0,
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const Customer_login(email: '',),
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.arrow_back, color: Colors.white),
//               ),
//             ),
//             Column(
//               children: [
//                 const Expanded(
//                   flex: 2,
//                   child: SizedBox(
//                     height: 10,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 7,
//                   child: Container(
//                     padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(40.0),
//                         topRight: Radius.circular(40.0),
//                       ),
//                     ),
//                     child: SingleChildScrollView(
//                       child: Form(
//                         key: _formSignupKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Get Started',
//                               style: TextStyle(
//                                 fontSize: 30.0,
//                                 fontWeight: FontWeight.w900,
//                                 color: Color.fromARGB(255, 64, 144, 209),
//                               ),
//                             ),
//                             const SizedBox(height: 20.0),
//                             TextFormField(
//                               controller: _nameController,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your name';
//                                 }
//                                 return null;
//                               },
//                               maxLength: 30,
//                               decoration: InputDecoration(
//                                 label: const Text('Name'),
//                                 hintText: 'Enter your name',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 20.0),
//                             TextFormField(
//                               controller: _emailController,
//                               maxLength: 35,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your email';
//                                 } else if (!RegExp(
//                                     r"^[a-zA-Z0-9.a-zA-Z0-9,!#$%&'*+-/=?^_`{|~}]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                     .hasMatch(value)) {
//                                   return 'Please enter a valid email';
//                                 }
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                 label: const Text('Email'),
//                                 hintText: 'Enter your email',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 20.0),
//                             TextFormField(
//                               controller: _mobileController,
//                               validator: (value) {
//                                 if (value != null && value.isNotEmpty) {
//                                   if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                                     return 'Please enter a valid 10-digit mobile number';
//                                   }
//                                 }
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                 label: const Text('Mobile number(Optional)'),
//                                 hintText: 'Enter your mobile number (optional)',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 35.0),
//                             TextFormField(
//                               controller: _passwordController,
//                               obscureText: !_isPasswordVisible,
//                               obscuringCharacter: '*',
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter your password';
//                                 } else if (value.length < 6) {
//                                   return 'Password must be at least 6 characters';
//                                 } else if (value.length > 20) {
//                                   return 'Password must be less than 20 characters';
//                                 } else if (value.contains(' ')) {
//                                   return 'Password cannot contain spaces';
//                                 }
//                                 return null;
//                               },
//                               decoration: InputDecoration(
//                                 label: const Text('Password'),
//                                 hintText: 'Enter your password',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 prefixIcon: const Icon(
//                                   Icons.lock_outlined,
//                                   color: Color.fromARGB(255, 65, 63, 63),
//                                 ),
//                                 suffixIcon: IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       _isPasswordVisible = !_isPasswordVisible;
//                                     });
//                                   },
//                                   icon: Icon(
//                                     !_isPasswordVisible
//                                         ? Icons.visibility_off
//                                         : Icons.visibility,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 23.0),
//                             SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton(
//                                 onPressed: _isLoading ? null : () async {
//                                   if (_formSignupKey.currentState!.validate() &&
//                                       agreePersonalData) {
//                                     setState(() {
//                                       _isLoading = true;
//                                     });
//                                     try {
//                                       var response = await service.saveUser(
//                                         _nameController.text,
//                                         _emailController.text,
//                                         _mobileController.text,
//                                         _passwordController.text,
//                                       );
//                                       var responseBody =
//                                       json.decode(response.body);
//                                       var m = service.getMail();
//                                       if (response.statusCode == 200) {
//                                         if (responseBody['statusMessage'] == 'pass') {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   EmailVerifyOTP(email: m),
//                                             ),
//                                           );
//                                         } else {
//                                           setState(() {
//                                             _responseMessage = responseBody['message'] ?? '';
//                                           });
//                                         }
//                                       } else {
//                                         setState(() {
//                                           _responseMessage = 'An error occurred, please try again later';
//                                         });
//                                       }
//                                     } catch (e) {
//                                       setState(() {
//                                         _responseMessage = 'An error occurred: $e';
//                                       });
//                                     } finally {
//                                       setState(() {
//                                         _isLoading = false;
//                                       });
//                                     }
//                                   } else if (!agreePersonalData) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                           content: Text(
//                                               'Please agree to the processing of personal data')),
//                                     );
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: const Color.fromARGB(255, 64, 144, 209),
//                                   foregroundColor: Colors.white,
//                                 ),
//                                 child: _isLoading
//                                     ? CircularProgressIndicator()
//                                     : const Text('Sign Up'),
//                               ),
//                             ),
//                             const SizedBox(height: 18.0),
//                             Row(
//                               children: [
//                                 Checkbox(
//                                   value: agreePersonalData,
//                                   onChanged: (bool? value) {
//                                     setState(() {
//                                       agreePersonalData = value!;
//                                     });
//                                   },
//                                   activeColor: const Color.fromARGB(255, 64, 144, 209),
//                                 ),
//                                 const Text(
//                                   'I agree to the processing of personal data',
//                                   style: TextStyle(
//                                     color: Colors.black45,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20.0),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   'Already have an account? ',
//                                   style: TextStyle(
//                                     color: Colors.black45,
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (e) => const Customer_login(email: '',),
//                                       ),
//                                     );
//                                   },
//                                   child: const Text(
//                                     ' Login',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Color.fromARGB(255, 64, 144, 209),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20.0),
//                             if (_responseMessage.isNotEmpty)
//                               Text(
//                                 _responseMessage,
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 64, 144, 209),
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:planotech/screens/email_verify.dart';
import 'customer_login.dart';
import 'signup_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignupKey = GlobalKey<FormState>();
  bool agreePersonalData = true;
  bool _isPasswordVisible = false;

  // Add controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Service instance
  Signup_Service service = Signup_Service();

  String _responseMessage = '';
  String mm = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/final.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 40.0,
              left: 10.0,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Customer_login(
                        email: '',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            Column(
              children: [
                const Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formSignupKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 64, 144, 209),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              maxLength: 30,
                              decoration: InputDecoration(
                                label: const Text('Name'),
                                hintText: 'Enter your name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: _emailController,
                              maxLength: 35,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9,!#$%&'*+-/=?^_`{|~}]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: const Text('Email'),
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: _mobileController,
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                    return 'Please enter a valid 10-digit mobile number';
                                  }
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: const Text('Mobile number(optional)'),
                                hintText: 'Enter your mobile number (optional)',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(height: 35.0),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              obscuringCharacter: '*',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                } else if (value.length > 20) {
                                  return 'Password must be less than 20 characters';
                                } else if (value.contains(' ')) {
                                  return 'Password cannot contain spaces';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: const Text('Password'),
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outlined,
                                  color: Color.fromARGB(255, 65, 63, 63),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    !_isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 23.0),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formSignupKey.currentState!.validate() &&
                                      agreePersonalData) {
                                    var response = await service.saveUser(
                                      context,
                                      _nameController,
                                      _emailController,
                                      _mobileController,
                                      _passwordController,
                                    );

                                    var responseBody =
                                    json.decode(response.body);
                                    var m = service.getMail();
                                    print("88");
                                    print(m);
                                    // mm=m;
                                    print("");
                                    if (response.statusCode == 200) {
                                      if (responseBody['statusMessage'] ==
                                          'pass') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EmailVerifyOTP(email: m),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          _responseMessage =
                                              responseBody['message'] ?? '';
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        _responseMessage =
                                        'An error occurred, please try again later';
                                      });
                                    }
                                  } else if (!agreePersonalData) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please agree to the processing of personal data')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromARGB(255, 64, 144, 209),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Sign Up'),
                              ),
                            ),
                            const SizedBox(height: 18.0),
                            Row(
                              children: [
                                Checkbox(
                                  value: agreePersonalData,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      agreePersonalData = value!;
                                    });
                                  },
                                  activeColor:
                                  const Color.fromARGB(255, 64, 144, 209),
                                ),
                                const Text(
                                  'I agree to the processing of personal data',
                                  style: TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (e) => const Customer_login(
                                          email: '',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    ' Login',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 64, 144, 209),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            if (_responseMessage.isNotEmpty)
                              Text(
                                _responseMessage,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 64, 144, 209),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}