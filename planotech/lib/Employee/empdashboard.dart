import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planotech/Employee/addleads.dart';
import 'package:planotech/Employee/addreport.dart';
import 'package:planotech/admin/viewattendance.dart';
import 'package:planotech/admin/viewleads.dart';
import 'package:planotech/dashboard.dart';
import 'package:planotech/logout.dart';
import 'package:planotech/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EmployeeDashboard extends StatefulWidget {
  @override
  _EmployeeDashboardState createState() => _EmployeeDashboardState();
}


class _EmployeeDashboardState extends State<EmployeeDashboard> {
  int _selectedIndex = 0;
  SharedPreferences? _prefs;
  late String _punchinTime;
  late String _punchoutTime;
  bool _punchInEnabled = true;
  bool _punchOutEnabled = true; // Flag to track punch-out status
  Map<String, dynamic> response = {};

  get empId => response['body']['userId'];

  @override
  void initState() {
    super.initState();
    fetchStoredResponse();
    _initPrefs();
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


  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _punchinTime = _prefs!.getString('punchinTime') ?? '';
    _punchoutTime = _prefs!.getString('punchoutTime') ?? '';

    // Check if punch-in is already done today
    if (_punchinTime.isNotEmpty) {
      DateTime punchin = DateFormat('hh:mm a').parse(_punchinTime);
      DateTime now = DateTime.now();
       
      
      if (now.difference(punchin).inSeconds < 20) {
        setState(() {
          _punchInEnabled = false;
        });
      }
    }

    // Check if punch-out is already done today
    if (_punchoutTime.isNotEmpty) {
    DateTime punchout = DateFormat('hh:mm a').parse(_punchoutTime);
    DateTime now = DateTime.now();
     
    if (now.difference(punchout).inHours < 20) {
      setState(() {
        _punchOutEnabled = false;
      });
    }
  }
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _punchin() async {
    if (_prefs == null) {
      _initPrefs();
    }

    if (!_punchInEnabled) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Punch-in Restricted"),
            content: const Text(
                "You have already punched in within the last 20 hours."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    // Get current time
    DateTime now = DateTime.now();
    String loginTime = DateFormat('hh:mm a').format(now);


    // Save login time to SharedPreferences
    _prefs!.setString('punchinTime', loginTime);

    setState(() {
      _punchinTime = loginTime;
      _punchInEnabled = false; // Disable punch-in button
    });

    // Get current location
    Position position = await _getGeoLocationPosition();
    String location = 'Lat: ${position.latitude}, Long: ${position.longitude}';

    // Get address from coordinates
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    String address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    // Send data to backend
    _sendDataToBackend(loginTime, location, address);

    
    print('Punched in at: $_punchinTime');

    
    DateTime punchinEndTime = DateTime(now.year, now.month, now.day, 9, 45);
    if (now.isAfter(punchinEndTime)) {
     
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Late Attendance"),
            content: const Text("You have punched in late."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  void _punchout() async {
    if (_prefs == null) {
      _initPrefs();
    }
    if (!_punchOutEnabled) {
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Already Punched Out"),
            content: const Text("You have already punched out."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

   
    setState(() {
      _punchOutEnabled = false;
    });

   
    DateTime now = DateTime.now();
    String punchoutTime = DateFormat('hh:mm a').format(now);
  
    _prefs!.setString('punchoutTime', punchoutTime);

    setState(() {
      _punchoutTime = punchoutTime;
    });

   
    Position position = await _getGeoLocationPosition();
    String location = 'Lat: ${position.latitude}, Long: ${position.longitude}';

    
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    String address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    
    _sendDataToBackend(punchoutTime, location, address);

    
    print('Punched out at: $_punchoutTime');
   
    DateTime punchoutEndTime = DateTime(now.year, now.month, now.day, 18, 45);
    if (now.isBefore(punchoutEndTime)) {
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Early Leaving"),
            content: const Text("You are leaving early."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _sendDataToBackend(
      String time, String location, String address) async {
    var url = Uri.parse('http://13.201.213.5:4040/emp/addemployeeattendence');

    // Encode data in JSON format
    var body = jsonEncode({
      "employeeId": empId,
      "date": DateFormat('dd-MM-yyyy').format(DateTime.now()),
      "time": time,
      "latitude": location.split(',')[0].trim(),
      "longitude": location.split(',')[1].trim(),
      "address": address,
    });
    print(body);
    var headers = {"Content-Type": "application/json"};

    // Send POST request
    var response = await http.post(url, body: body, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      print('Data sent successfully!');
    } else {
      print('Failed to send data. Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/plano_logo.png',
              height: 80,
              width: 320,
              fit: BoxFit.contain,
            ),
          ],
        ),
        toolbarHeight: 85,
        backgroundColor: const Color.fromARGB(255, 243, 198, 215),
      ),
     body:
       Stack(
         fit: StackFit.expand,
         children: [
         Image.asset(
         'assets/mobilebackground.jpg',
         fit: BoxFit.cover,
       ),

       SingleChildScrollView(
         child: Container(
           
           // padding: const EdgeInsets.all(62),
           decoration: const BoxDecoration(
             image: DecorationImage(
               image: AssetImage('assets/mobilebackground.jpg'),
               fit: BoxFit.cover,
             ),
           ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   const Text(
                     'Welcome to the Employee Dashboard!',
                     style: TextStyle(
                       fontSize: 24.0,
                       color: Colors.black,
                     ),
                     textAlign: TextAlign.center,
                   ),
                   const SizedBox(height: 20.0),
                   const CircleAvatar(
                     radius: 60,
                     backgroundImage: AssetImage('assets/avatar.png'),
                   ),
                   const SizedBox(height: 20.0),
                   SizedBox(
                     width: 240,
                     child: ElevatedButton(
                       onPressed: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => EmployeeRegistrationForm(empId),
                           ),
                         );
                       },
                       style: ElevatedButton.styleFrom(
                         foregroundColor: Colors.black,
                         backgroundColor: Colors.white,
                         padding: const EdgeInsets.symmetric(vertical: 16),
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(12)),
                       ),
                       child: const Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.add),
                           SizedBox(width: 8),
                           Text('Add Leads'),
                         ],
                       ),
                     ),
                   ),
                   const SizedBox(height: 10.0),
                   SizedBox(
                     width: 240,
                     child: ElevatedButton(
                       onPressed: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => const ViewLeadsPage(),
                           ),
                         );
                       },
                       style: ElevatedButton.styleFrom(
                         foregroundColor: Colors.black,
                         backgroundColor: Colors.white,
                         padding: const EdgeInsets.symmetric(vertical: 16),
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(12)),
                       ),
                       child: const Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.leaderboard_sharp),
                           SizedBox(width: 8),
                           Text('View Leads'),
                         ],
                       ),
                     ),
                   ),
                   const SizedBox(height: 10.0),
                   SizedBox(
                     width: 240,
                     child: ElevatedButton(
                       onPressed: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => ReportSubmissionScreen(
                                 response['body']['userId']),
                           ),
                         );
                       },
                       style: ElevatedButton.styleFrom(
                         foregroundColor: Colors.black,
                         backgroundColor: Colors.white,
                         padding: const EdgeInsets.symmetric(vertical: 16),
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(12)),
                       ),
                       child: const Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.feedback_outlined),
                           SizedBox(width: 8),
                           Text('Add Report'),
                         ],
                       ),
                     ),
                   ),
                   const SizedBox(height: 10.0),
                   SizedBox(
                     width: 240,
                     child: ElevatedButton(
                       onPressed: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => ViewAttendanceById(empId)
                           ),
                         );
                       },
                       style: ElevatedButton.styleFrom(
                         foregroundColor: Colors.black,
                         backgroundColor: Colors.white,
                         padding: const EdgeInsets.symmetric(vertical: 16),
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(12)),
                       ),
                       child: const Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.table_view_rounded),
                           SizedBox(width: 8),
                           Text('View Attendance'),
                         ],
                       ),
                     ),
                   ),
                   const SizedBox(height: 10.0),
                   Align(
                     alignment: Alignment.topRight,
                     child: Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Row(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           SizedBox(
                             width: 100,
                             child: ElevatedButton(
                               onPressed: _punchin,
                               style: ElevatedButton.styleFrom(
                                 foregroundColor: Colors.black,
                                 backgroundColor: Colors.white,
                                 padding:
                                     const EdgeInsets.symmetric(vertical: 5),
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(12)),
                               ),
                               child: const Text('Punch In',
                                   style: TextStyle(fontSize: 12.0)),
                             ),
                           ),
                           const SizedBox(width: 10),
                           SizedBox(
                             width: 100,
                             child: ElevatedButton(
                               onPressed: _punchout,
                               style: ElevatedButton.styleFrom(
                                 foregroundColor: Colors.black,
                                 backgroundColor: Colors.white,
                                 padding:
                                     const EdgeInsets.symmetric(vertical: 5),
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(12)),
                               ),
                               child: const Text('Punch Out',
                                   style: TextStyle(fontSize: 12.0)),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             ),
       ),
      ]
    ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlue[300],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );
      } else if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfilePage(),
          ),
        );
      } else if (_selectedIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Logout(),
          ),
        );
      }
    });
  }
}
