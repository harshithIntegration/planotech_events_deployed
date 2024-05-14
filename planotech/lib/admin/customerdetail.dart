import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var custId;

class ViewCustRegister extends StatefulWidget {
  ViewCustRegister(var Id) {
    custId = Id;
    print(custId);
  }

  @override
  _ViewCustRegisterState createState() => _ViewCustRegisterState();
}

class _ViewCustRegisterState extends State<ViewCustRegister> {
  late List<Map<String, dynamic>> _userList = [];
  bool _isLoading = false; // Add loading state variable

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true; // Set loading to true when fetching data
    });

    final url =
        'http://13.201.213.5:4040/admin/fetchcustomereventregisterbyid?customerId=$custId';

    try {
      final response = await http.post(Uri.parse(url));
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['status'] == true) {
        setState(() {
          _userList =
          List<Map<String, dynamic>>.from(responseData['userList']);
          _isLoading = false; // Set loading to false after data is fetched
        });
        print(_userList);
      } else {
        // Handle error when status is false
        print('Error: ${responseData['statusMessage']}');
        setState(() {
          _isLoading = false; // Set loading to false in case of error
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        _isLoading = false; // Set loading to false in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registered Events',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 64, 144, 209),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: _isLoading // Check loading state to display loading indicator
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _userList.isEmpty
          ? Center(
        child: _userList.isNotEmpty
            ? CircularProgressIndicator()
            : Text(
          '',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          final user = _userList[index];
          return Container(
            margin:
            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.blue[100],
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Name: ${user['name'] ?? ''}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBox('Phone', user['phone']),
                    _buildBox('Email', user['email']),
                    _buildBox('Venue', user['venue']),
                    _buildBox('Event Date', user['eventDate']),
                    _buildBox('Event Time', user['eventTime']),
                    _buildBox('Event Pack', user['eventPack']),
                    _buildBox('Event Setup Date',
                        user['eventSetupDate']),
                    _buildBox('Event Setup Time',
                        user['eventSetupTime']),
                    _buildBox('Agenda', user['agenda']),
                    _buildBox('Date', user['date']),
                    _buildBox('Time', user['time']),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBox(String label, dynamic value) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[300], // Box color
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value != null ? value.toString() : '',
              maxLines: 1000,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}