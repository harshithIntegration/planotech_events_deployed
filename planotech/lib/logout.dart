import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart'; // Import your Dashboard class here

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  State<Logout> createState() => LogoutState();
}

class LogoutState extends State<Logout> {
  @override
  void initState() {
    super.initState();
    clearSharedPreferencesAndNavigateToDashboard();
  }

  Future<void> clearSharedPreferencesAndNavigateToDashboard() async {
    print("+++++++++");
    // Response();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print("==========");
    // After clearing SharedPreferences, navigate to the Dashboard
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
