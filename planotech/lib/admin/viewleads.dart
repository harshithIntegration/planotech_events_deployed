import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewLeadsPage extends StatefulWidget {
  const ViewLeadsPage({Key? key});

  @override
  _ViewLeadsPageState createState() => _ViewLeadsPageState();
}

class _ViewLeadsPageState extends State<ViewLeadsPage> {
  List<Map<String, dynamic>> _userList = [];
  List<Map<String, dynamic>> _filteredUserList = [];
  List<Color> _avatarColors = [
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
  int _colorIndex = 0;
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.post(
        Uri.parse('http://13.201.213.5:4040/admin/fetchallemployeeleadregister'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          _userList = List<Map<String, dynamic>>.from(jsonData['userList']);
          _filteredUserList = List<Map<String, dynamic>>.from(jsonData['userList']);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
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

  void _showUserDetails(Map<String, dynamic> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailsPage(user: user, isLoading: _isLoading),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lead List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 64, 144, 209),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              readOnly: true,
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (selectedDate != null) {
                  filterByDate(selectedDate);
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
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _filteredUserList.isEmpty
                ? const Center(
              child: Text('No data found'),
            )
                : ListView.builder(
              itemCount: _filteredUserList.length,
              itemBuilder: (context, index) {
                final user = _filteredUserList[index];
                Color color = _avatarColors[_colorIndex % _avatarColors.length];
                _colorIndex++;
                return ListTile(
                  onTap: () => _showUserDetails(user),
                  title: Text(user['leadName']),
                  subtitle: Text('Date: ${user['date']}'),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    child: Center(
                      child: Text(
                        user['leadName'][0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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

class UserDetailsPage extends StatelessWidget {
  final Map<String, dynamic> user;
  final bool isLoading;

  const UserDetailsPage({Key? key, required this.user, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lead Details'),
        backgroundColor: const Color.fromARGB(255, 64, 144, 209),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          _buildDetailItem('Name', user['leadName'].toString()),
          _buildDetailItem('Email', user['leadEmail'].toString()),
          _buildDetailItem('Phone', user['leadPhone'].toString()),
          _buildDetailItem('Short Description', user['leadShortDescription'].toString()),
          _buildDetailItem('Brief Description', user['leadBriefDescription'] != null ? user['leadBriefDescription'].toString() : 'N/A'),
          _buildDetailItem('Meeting Time', user['leadMeetingTime'] != null ? user['leadMeetingTime'].toString() : 'N/A'),
          _buildDetailItem('Meeting Date', user['leadMeetingDate'] != null ? user['leadMeetingDate'].toString() : 'N/A'),
          _buildDetailItem('Possible Lead', user['possibleLead'].toString()),
          _buildDetailItem('Date', user['date'].toString()),
          _buildDetailItem('Time', user['time'].toString()),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}