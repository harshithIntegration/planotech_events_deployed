import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AttendancePage extends StatefulWidget {
  final int empId;

  AttendancePage(this.empId);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  late TextEditingController _searchController;
  late DateTime _selectedDate;
  late List<Map<String, dynamic>> _filteredAttendanceData;
  late List<Map<String, dynamic>> _attendanceData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selectedDate = DateTime.now();
    _filteredAttendanceData = [];
    _attendanceData = [];
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.post(Uri.parse('http://13.201.213.5:4040/admin/fetchemployeeattendancebyemployeeid?empId=${widget.empId}'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == true) {
        setState(() {
          _attendanceData = List<Map<String, dynamic>>.from(data['userList']);
          _filteredAttendanceData = _attendanceData;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } else {
      throw Exception('Failed to load data from the server');
    }
    print(response.body);
  }

  void _filterAttendanceData(DateTime? selectedDate) {
    setState(() {
      _selectedDate = selectedDate ?? DateTime.now();
      if (selectedDate == null) {
        _filteredAttendanceData = List.from(_attendanceData);
      } else {
        _filteredAttendanceData = _attendanceData.where((attendance) {
          try {
            final dateParts = attendance['date'].split('-');
            if (dateParts.length == 3) {
              final day = int.tryParse(dateParts[0]);
              final month = int.tryParse(dateParts[1]);
              final year = int.tryParse(dateParts[2]);
              if (day != null && month != null && year != null) {
                final attendanceDate = DateTime(year, month, day);
                return attendanceDate.toLocal().isAtSameMomentAs(_selectedDate.toLocal());
              }
            }
            return false;
          } catch (e) {
            print('Error parsing date: $e');
            return false;
          }
        }).toList();
      }
    });
    // Update the text field with selected date
    _searchController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      _filterAttendanceData(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    readOnly: true, // Make text field read-only
                    decoration: InputDecoration(
                      labelText: 'Selected Date',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredAttendanceData.isEmpty
                ? Center(
              child: Text(
                'No attendance data found for selected date.',
                style: TextStyle(fontSize: 18.0),
              ),
            )
                : ListView.builder(
              itemCount: _filteredAttendanceData.length,
              itemBuilder: (context, index) {
                final attendance = _filteredAttendanceData[index];
                return Card(
                  color: Colors.grey.shade200,
                  elevation: 5.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(
                      'Date: ${attendance['date']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.0),
                        Text(
                          'Time: ${attendance['time']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4.0),
                        Text('Address: ${attendance['address']}', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}