import 'package:flutter/material.dart';

class Features extends StatefulWidget {
  const Features({Key? key}) : super(key: key);

  @override
  State<Features> createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
  List<Map<String, String>> features = [
    {
      'title': 'Dual Login Options:',
      'description': 'Employees and customers can access the app with separate login options tailored to their needs.'
    },
    {
      'title': 'Employee Section:',
      'description': 'Internal tools for employees including report generation, lead tracking, and attendance management.'
    },
    {
      'title': 'Customer Section:',
      'description': 'Customers can easily register for events and access event-related information through their dedicated section.'
    },
    {
      'title': 'Content Display:',
      'description': 'Showcase of content related to Planotech and its subsidiaries, providing users with relevant updates and information.'
    },
    {
      'title': 'Privacy Policy:',
      'description': 'Transparent privacy policy ensuring user data is handled responsibly. Refer to the Privacy Policy for detailed information.'
    },
    {
      'title': 'Continuous Updates:',
      'description': 'Regular app updates to enhance user experience and introduce new features. Users are notified of significant changes through app updates.'
    },
    {
      'title': 'Support and Queries:',
      'description': 'Accessible support for users with inquiries or assistance needs. Contact Quantum Paradigm for prompt assistance.'
    },
    {
      'title': 'Contact Information:',
      'description': 'Easily reach out for further details or inquiries. Contact us directly through the app for assistance.'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Features',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '   APP FEATURES',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: features.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  features[index]['title']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  features[index]['description']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(), // Adds a divider between features
                    ],
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