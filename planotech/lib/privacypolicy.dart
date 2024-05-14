import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        children: [
          Text(
            'This Privacy Policy outlines how we collect, use, and share your information when you use our app available on the Android Play Store. By using our app, you agree to the terms outlined in this policy.\n',
          ),
          Text(
            '1. Information We Collect : \n' ,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'We collect personal data like email addresses and phone numbers with your consent to improve our service, personalize your experience, and ensure account security. We also collect device details, browsing history and location data with your consent to optimize our app features and services.\n',
          ),
          Text(
            '2. How We Use Your Information : \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'We use the collected information to provide and improve our services, manage your account, communicate with you, and for legal or security reasons.\n',
          ),
          Text(
            '3. Information Sharing : \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'We may share your information with service providers, affiliates, business partners, or legal authorities as required by law or to protect our rights and users\' safety.\n',
          ),
          Text(
            '4. Data Retention and Security : \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'We retain your data only as long as necessary for the purposes outlined in this policy. While we implement security measures, no method of data transmission over the internet is 100% secure.\n',
          ),
          Text(
            '5. Children’s Privacy : \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Our app is not intended for users under the age of 13, and we do not knowingly collect personal information from them without parental consent.\n',
          ),
          Text(
            '6. Updates and Contact : \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'We may update this Privacy Policy periodically, and we will notify you of any significant changes. For questions or concerns about this policy, please contact us at info@planotechevents.com.\n',
          ),
          
        ],
      ),
    );
    
  }

}