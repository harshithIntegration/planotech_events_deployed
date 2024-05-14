                                                                                                                                               import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:planotech/Employee/empdashboard.dart';
var Id;
class EmployeeRegistrationForm extends StatefulWidget {
  EmployeeRegistrationForm(empId){
    Id=empId;
    print(Id);
  }

  @override
  _EmployeeRegistrationFormState createState() =>
      _EmployeeRegistrationFormState();
}

class _EmployeeRegistrationFormState extends State<EmployeeRegistrationForm> {
  late Map<String, dynamic> _data;
  final _formKey = GlobalKey<FormState>();
  TextEditingController meetingDateController = TextEditingController();
  TextEditingController meetingTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _data = {
      "employeeId": Id,
      'leadName': '',
      'leadPhone': '',
      'leadEmail': '',
      'leadShortDescription': '',
      'leadBriefDescription': '',
      'leadMeetingDate': '',
      'leadMeetingTime': '',
      "possibleLead": true,
    };
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      DateTime now = DateTime.now();
      String date = '${now.day}-${now.month}-${now.year}';
      String time = DateFormat('hh:mm a').format(now);

      _data['date'] = date;
      _data['time'] = time;
      final jsonData = jsonEncode(_data);
      try {
        final response = await http.post(
          Uri.parse('http://13.201.213.5:4040/emp/leadregister'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonData,
        );

        print('Response body: ${response.body}');

        _formKey.currentState!.reset();
        meetingDateController.clear();
        meetingTimeController.clear();
        setState(() {
          _data = {
            "employeeId": Id,
            'leadName': '',
            'leadPhone': '',
            'leadEmail': '',
            'leadShortDescription': '',
            'leadBriefDescription': '',
            'leadMeetingDate': '',
            'leadMeetingTime': '',
            "possibleLead": true,
          };
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Submitted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmployeeDashboard()),
        );
      } catch (e) {
        print('Error occurred: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting form'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee Table',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
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
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextFieldContainer(
                labelText: 'Lead Name',
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter lead name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _data['leadName'] = value!;
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildTextFieldContainer(
                labelText: 'Lead Phone',
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onSaved: (value) {
                    _data['leadPhone'] = value!;
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildTextFieldContainer(
                labelText: 'Lead Email',
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onSaved: (value) {
                    _data['leadEmail'] = value!;
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildTextFieldContainer(
                labelText: 'Lead Short Description',
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter short description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _data['leadShortDescription'] = value!;
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildTextFieldContainer(
                labelText: 'Lead Long Description',
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onSaved: (value) {
                    _data['leadBriefDescription'] = value!;
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildTextFieldContainer(
                labelText: 'Lead Meeting Date',
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  controller: meetingDateController,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() {
                        _data['leadMeetingDate'] =
                        picked.toString().split(' ')[0];
                        meetingDateController.text =
                        picked.toString().split(' ')[0];
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildTextFieldContainer(
                labelText: 'Lead Meeting Time',
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  controller: meetingTimeController,
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        _data['leadMeetingTime'] = picked.format(context);
                        meetingTimeController.text = picked.format(context);
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Possible Lead',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: _data['possibleLead'],
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _data['possibleLead'] = value;
                        });
                      }
                    },
                  ),
                  const Text('Yes'),
                  Radio<bool>(
                    value: false,
                    groupValue: _data['possibleLead'],
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          _data['possibleLead'] = value;
                        });
                      }
                    },
                  ),
                  const Text('No'),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 64, 144, 209),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldContainer({required String labelText, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 241, 238, 238),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          child,
        ],
      ),
    );
  }
}