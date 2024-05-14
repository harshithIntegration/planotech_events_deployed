import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:planotech/logout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> response = {};

  @override
  void initState() {
    super.initState();
    fetchStoredResponse();
  }

  Future<void> fetchStoredResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedResponse = prefs.getString('response');
    if (storedResponse != null) {
      try {
        setState(() {
          response = json.decode(storedResponse);
        });
      } catch (e) {
        print("Error decoding stored response: $e");
      }
    } else {
      print("No stored response found.");
    }
    print(response);
  }

  Future<void> deleteAccount() async {
    if (response['body'] != null && response['body']['userEmail'] != null) {
      String url =
          'http://13.201.213.5:4040/customer/customerdeleteaccount?email=${response['body']['userEmail']}';

      try {
        final response = await http.post(Uri.parse(url));

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);
          print(data);
          if (data['status'] == true) {
            // Handle account deletion success
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Account Deleted'),
                  content: Text(data['message']),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Logout()),
                        );
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            // Handle account deletion failure
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Account Deletion Failed'),
                  content: Text(data['message']),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          throw Exception('Failed to delete account');
        }
      } catch (e) {
        print("Error deleting account: $e");
        // Handle error
      }
    } else {
      print("User email not found in SharedPreferences or response body is null.");
    }
  }

  Future<void> confirmDeleteAccount() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete Account'),
          content: Text('Are you sure you want to delete your account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm != null && confirm) {
      deleteAccount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile ',
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight),
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
              ),
              const SizedBox(height: 20),
              if (response.isNotEmpty)
                itemProfile('Name', response['body']['userName'], Icons.person),
              const SizedBox(height: 10),
              if (response.isNotEmpty)
                itemProfile('Phone', response['body']['userPhone'].toString(),
                    Icons.phone),
              const SizedBox(height: 10),
              if (response.isNotEmpty)
                itemProfile(
                    'Email', response['body']['userEmail'], Icons.email),
              if (!response.isNotEmpty) itemProfile('Name', "", Icons.person),
              const SizedBox(height: 10),
              if (!response.isNotEmpty) itemProfile('Phone', "", Icons.phone),
              const SizedBox(height: 10),
              if (!response.isNotEmpty) itemProfile('Email', "", Icons.email),
              const SizedBox(height: 20),
              if (response.isNotEmpty &&
                  response['body'] != null &&
                  response['body']['customerStatus'] != null &&
                  response['body']['customerStatus'] is bool &&
                  response['body']['customerStatus'])
                ElevatedButton(
                  onPressed: confirmDeleteAccount,
                  child: Text('Delete Account'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 5),
            color: Color.fromARGB(255, 240, 221, 221),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: TextFormField(
          initialValue: subtitle,
          readOnly: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
        leading: Icon(icon),
        tileColor: Colors.white,
      ),
    );
  }
}