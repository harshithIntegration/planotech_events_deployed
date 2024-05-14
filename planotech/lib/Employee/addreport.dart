                                                                                                                                                          import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:planotech/Employee/empdashboard.dart';

var Id;

class ReportSubmissionScreen extends StatefulWidget {
  ReportSubmissionScreen(var empId){
    Id=empId;
    print(empId);
    print(Id);
  }

  @override
  _ReportSubmissionScreenState createState() => _ReportSubmissionScreenState();
}

class _ReportSubmissionScreenState extends State<ReportSubmissionScreen> {
  final TextEditingController _reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Report Submission',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor:  const Color.fromARGB(255, 64, 144, 209),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Please provide your report',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _reportController,
              onChanged: (_) {
                setState(() {});
              },
              maxLines: 7,
              maxLength: 2000,
              decoration: const InputDecoration(
                hintText: 'Enter your report here...',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your report';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isFormValid() ? _submit : null,
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Color.fromARGB(255, 64, 144, 209),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isFormValid() {
    return _reportController.text.trim().isNotEmpty;
  }

  Future<void> _submit() async {
    if (_isFormValid()) {
      String report = _reportController.text;
      DateTime now = DateTime.now();
      String date = '${now.day}-${now.month}-${now.year}';
      String time = DateFormat('hh:mm a').format(now);

      print(Id);
      print('Report content: $report');
      print('Time: $time');
      print('Date: $date');

      try {
        await _uploadReport(report, date, time);
        _reportController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Report submitted successfully'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EmployeeDashboard()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting report'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );

      }
    }
  }

  Future<void> _uploadReport(String report, String date, String time) async {
    try {
      const String url = 'http://13.201.213.5:4040/emp/dailyemployeereport';

      print(Id);
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          "employeeId": Id,
          'report': report,
          'date': date,
          'time': time,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      final jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (jsonResponse.containsKey('status')) {
        bool status = jsonResponse['status'];
        print(status);
        if (status) {
          print('Report submitted successfully');
        } else {
          throw Exception('Failed to submit report');
        }
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      throw Exception('Error uploading report: $e');
    }
  }
}