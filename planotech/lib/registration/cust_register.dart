                                                                                                                                                                         import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:planotech/Customer/customer.dart';


var Id;
class MyHomePage extends StatefulWidget {
  MyHomePage(custId){
    Id=custId;
    print(Id);
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _nameController;
  late TextEditingController _numberController;
  late TextEditingController _emailController;
  late TextEditingController _venueController;
  late TextEditingController _setupDateController;
  late TextEditingController _eventDateController;
  late TextEditingController _eventPackController;
  late TextEditingController _eventAgendaController;
  late String _selectedSetupHour = '0';
  late String _selectedSetupMinute = '00';
  late String _selectedSetupPeriod = 'AM';
  late String _selectedEventHour = '0';
  late String _selectedEventMinute = '00';
  late String _selectedEventPeriod = 'AM';

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _emailController = TextEditingController();
    _venueController = TextEditingController();
    _setupDateController = TextEditingController();
    _eventDateController = TextEditingController();
    _eventPackController = TextEditingController();
    _eventAgendaController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _emailController.dispose();
    _venueController.dispose();
    _setupDateController.dispose();
    _eventDateController.dispose();
    _eventPackController.dispose();
    _eventAgendaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Form"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomerPage(),
              ),
            );
          },
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 64, 144, 209),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(0, 100, 226, 128), Color.fromARGB(255, 64, 144, 209),],
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20.0),
                const Text(
                  'Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
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
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  ),
                ),
                const SizedBox(height: 2.0),
                const Text(
                  'Mobile Number',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),

                TextFormField(
                  controller: _numberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit mobile number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Mobile number',
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter your mobile number',
                    prefixIcon: const Icon(Icons.call_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),

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
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.mail),
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  ),
                ),
                const SizedBox(height: 2.0),
                const Text(
                  'Event venue',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),

                TextFormField(
                  controller: _venueController,
                  maxLength: 100,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter venue';
                    }
                    return null;
                  },

                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Enter Event Venue...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.location_on),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  ),
                ),
                const SizedBox(height: 2.0),
                const Text(
                  'Event date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),

                Container(
                  child: GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        setState(() {
                          _eventDateController.text = picked.toString().split(' ')[0];
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter Event Date...',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.date_range),
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                        ),
                        controller: _eventDateController,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Event Time',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: TextField(
                            controller: TextEditingController(
                                text: '$_selectedEventHour:$_selectedEventMinute $_selectedEventPeriod'),
                            readOnly: true,
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  _selectedEventHour = (picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod)
                                      .toString()
                                      .padLeft(2, '0');
                                  _selectedEventMinute = picked.minute.toString().padLeft(2, '0');
                                  _selectedEventPeriod = picked.period == DayPeriod.am ? 'AM' : 'PM';
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Event pack',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),

                TextFormField(
                  controller: _eventPackController,
                  maxLength: 7,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:"How many Members Attend for Event",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.control_point_outlined),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  ),
                ),
                const SizedBox(height: 2.0),
                const Text(
                  'Event Setup Date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),

                Container(
                  child: GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        setState(() {
                          _setupDateController.text = picked.toString().split(' ')[0];
                        });
                      }
                    },
                    child: AbsorbPointer(

                      child: TextFormField(

                        decoration: InputDecoration(

                          labelText: 'Enter setup Date...',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.date_range),
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                        ),
                        controller: _setupDateController,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2.0),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Setup Time',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: TextField(
                            controller: TextEditingController(
                                text: '$_selectedSetupHour:$_selectedSetupMinute $_selectedSetupPeriod'),
                            readOnly: true,
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                setState(() {
                                  _selectedSetupHour = (picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod)
                                      .toString()
                                      .padLeft(2, '0');
                                  _selectedSetupMinute = picked.minute.toString().padLeft(2, '0');
                                  _selectedSetupPeriod = picked.period == DayPeriod.am ? 'AM' : 'PM';
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Event Agenda',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),

                TextFormField(
                  controller: _eventAgendaController,
                  keyboardType: TextInputType.text,
                  maxLines: 6,
                  maxLength: 5000,
                  decoration: InputDecoration(
                    labelText: "Enter Event Agenda...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.event_note),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      formData['name'] = _nameController.text;
                      formData['phone'] = _numberController.text;
                      formData['email'] = _emailController.text;
                      formData['venue'] = _venueController.text;
                      formData['eventDate'] = _eventDateController.text;
                      formData['eventTime'] =
                      '$_selectedEventHour:$_selectedEventMinute $_selectedEventPeriod';
                      formData['eventPack'] = int.parse(_eventPackController.text);
                      formData['eventSetupDate'] = _setupDateController.text;
                      formData['eventSetupTime'] =
                      '$_selectedSetupHour:$_selectedSetupMinute $_selectedSetupPeriod';
                      formData['agenda'] = _eventAgendaController.text;
                      formData['customerId'] = Id;

                      DateTime now = DateTime.now();
                      String date = '${now.day}-${now.month}-${now.year}';
                      String time = DateFormat('hh:mm a').format(now);

                      formData['date'] = date;
                      formData['time'] = time;

                      String jsonData = jsonEncode(formData);
                      print(jsonData);

                      try {
                        Uri url = Uri.parse('http://13.201.213.5:4040/customer/customereventregister');
                        final response = await http.post(
                          url,
                          headers: {"Content-Type": "application/json"},
                          body: jsonData,
                        );
                        print(response.body);

                        if (response.statusCode == 200) {
                          showSnackBar(context, 'Successfully submitted', Colors.green);
                          _nameController.clear();
                          _numberController.clear();
                          _emailController.clear();
                          _venueController.clear();
                          _eventDateController.clear();
                          _eventPackController.clear();
                          _setupDateController.clear();
                          _eventAgendaController.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CustomerPage(),
                            ),
                          );
                        } else {
                          showSnackBar(context, 'Error submitting data', Colors.red);
                        }
                      } catch (e) {
                        showSnackBar(context, 'Error: $e', Colors.red);
                      }
                    }
                  },
                  child: const Text(
                    'Registration',
                    style: TextStyle(color: const Color.fromARGB(255, 64, 144, 209)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
      ),
    );
  }
}