import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:planotech/Employee/exhibitor.dart';

class ViewAllEmployee {
  final int userId;
  final String userName;
  final String userEmail;
  final int userPhone;
  final String userDepartment;

  ViewAllEmployee({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userDepartment,
  });
}

class ViewAllEmployeePage extends StatefulWidget {
  const ViewAllEmployeePage({Key? key}) : super(key: key);

  @override
  State<ViewAllEmployeePage> createState() => _ViewAllEmployeePageState();
}

class _ViewAllEmployeePageState extends State<ViewAllEmployeePage> {
  List<ViewAllEmployee> employeeList = [];
  List<ViewAllEmployee> filteredEmployeeList = [];
  String? responseMessage;
  bool? responseStatus;
  String? selectedDepartment;
  bool _isLoading = false;

  final List<Color> avatarColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.blueGrey,
    Colors.brown,
  ];

  int colorIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final String apiUrl = 'http://13.201.213.5:4040/admin/fetchallemployee';

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({}),
      );

      var data = jsonDecode(response.body);

      if (data != null && data['userList'] != null) {
        setState(() {
          employeeList = List<ViewAllEmployee>.from(
              data['userList'].map((user) => ViewAllEmployee(
                userId: user['userId'],
                userName: user['userName'],
                userEmail: user['userEmail'],
                userPhone: user['userPhone'],
                userDepartment: user['userDepartment'],
              )));
          filteredEmployeeList = List<ViewAllEmployee>.from(employeeList);
          responseMessage = data['message'];
          responseStatus = data['status'];
          _isLoading = false;
        });
      } else {
        print('Failed to load data: Invalid response format');
        _isLoading = false;
      }
    } catch (e) {
      print('Failed to load data: $e');
      _isLoading = false;
    }
  }

  void filterEmployees(String searchText, String? selectedDepartment) {
    setState(() {
      filteredEmployeeList = employeeList.where((employee) {
        final nameLower = employee.userName.toLowerCase();
        final departmentMatches = selectedDepartment == null ||
            selectedDepartment.isEmpty ||
            employee.userDepartment == selectedDepartment;
        final nameMatches = nameLower.contains(searchText.toLowerCase());
        return departmentMatches && nameMatches;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('All Employees'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterEmployees(value, selectedDepartment);
              },
              decoration: InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: selectedDepartment,
              hint: Text('Filter by department'),
              onChanged: (value) {
                setState(() {
                  selectedDepartment = value;
                  filterEmployees('', selectedDepartment);
                });
              },
              items: <String>[
                'IT',
                'Administration',
                'HR',
                'Sales and Marketing',
                'Design',
                'Finance and Accounts',
                'Production',
                'Operations-Support',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEmployeeList.length,
              itemBuilder: (context, index) {
                Color color = avatarColors[colorIndex % avatarColors.length];
                colorIndex++;

                return GestureDetector(
                  onTap: () {
                    try {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExhibitorPage(
                            userId: filteredEmployeeList[index].userId,
                          ),
                        ),
                      );
                    } catch (e) {
                      print('Error navigating to ExhibitorPage: $e');
                    }
                  },
                  child: ListTile(
                    title: Text(filteredEmployeeList[index].userName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${filteredEmployeeList[index].userEmail}'),
                        Text('Phone: ${filteredEmployeeList[index].userPhone}'),
                        Text(
                          'Department: ${filteredEmployeeList[index].userDepartment}',
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: color,
                      child: Text(
                        filteredEmployeeList[index].userName[0].toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}