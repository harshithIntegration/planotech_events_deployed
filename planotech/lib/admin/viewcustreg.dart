import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:planotech/admin/adminpage.dart';
import 'package:planotech/admin/customerdetail.dart';

class ViewAllCustomerRegister extends StatefulWidget {
  @override
  _ViewAllCustomerRegisterState createState() => _ViewAllCustomerRegisterState();
}

class _ViewAllCustomerRegisterState extends State<ViewAllCustomerRegister> {
  List<dynamic> _customerList = [];
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = true; // Add loading state variable

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse('http://13.201.213.5:4040/admin/fetchallcustomer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{}),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _customerList = data['userList'];
        _isLoading = false; // Data is loaded, so set isLoading to false
      });
    } else {
      throw Exception('Failed to load data');
    }
    print(_customerList);
  }

  List<dynamic> getFilteredCustomers(String query) {
    return _customerList.where((customer) {
      final username = customer['userName'];
      final searchLower = query;
      return username.contains(searchLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer List"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminPage(),
              ),
            );
          },
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 64, 144, 209),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by username',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          _isLoading
              ? Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : Expanded(
            child: _customerList.isEmpty
                ? Center(
              child: Text('No customers found'),
            )
                : ListView.separated(
              itemCount: getFilteredCustomers(_searchController.text).length,
              separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                final customer = getFilteredCustomers(_searchController.text)[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.primaries[index % Colors.primaries.length],
                    radius: 23, // Increase radius size
                    child: Text(
                      customer['userName'][0].toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(customer['userName']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewCustRegister(customer['userId']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}