import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Reportpage extends StatefulWidget {
  final int empid; // Define empid as a parameter for the page

  Reportpage(this.empid); // Constructor to accept empid

  @override
  _ReportpageState createState() => _ReportpageState();
}

class _ReportpageState extends State<Reportpage> {
  List<dynamic> _userList = [];
  List<dynamic> _filteredUserList = [];
  bool _isLoading = false;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(Uri.parse(
        'http://13.201.213.5:4040/admin/fetchdailyemployeereportbyid?empId=${widget.empid}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _userList = data['userList'];
        _filteredUserList = _userList; // Initially set filtered list to the full list
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  void filterByDate(DateTime? selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
      if (_selectedDate == null) {
        _filteredUserList = List.from(_userList);
      } else {
        _filteredUserList = _userList.where((user) {
          try {
            final dateParts = user['date'].split('-');
            if (dateParts.length == 3) {
              final day = int.tryParse(dateParts[0]);
              final month = int.tryParse(dateParts[1]);
              final year = int.tryParse(dateParts[2]);
              if (day != null && month != null && year != null) {
                final userDate = DateTime(year, month, day);
                return userDate.toLocal().isAtSameMomentAs(_selectedDate!.toLocal());
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
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      filterByDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              readOnly: true,
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (selectedDate != null) {
                  _selectDate(context);
                }
              },
              controller: TextEditingController(
                text: _selectedDate != null
                    ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
                    : '',
              ),
              decoration: const InputDecoration(
                labelText: 'Filter by Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ),
          Expanded(
            child: _filteredUserList.isEmpty
                ? Center(
              child: Text(
                'No data found for selected date.',
                style: TextStyle(fontSize: 18.0),
              ),
            )
                : ListView.builder(
              itemCount: _filteredUserList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.all(8.0),
                  elevation: 3.0,
                  child: ListTile(
                    title: Text(_filteredUserList[index]['report']),
                    subtitle: Text('Date: ${_filteredUserList[index]['date']}'),
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