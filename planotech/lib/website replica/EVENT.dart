import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class EVENT extends StatefulWidget {
  const EVENT({Key? key});

  @override
  State<EVENT> createState() => _EventState();
}

class _EventState extends State<EVENT> {
  Widget _buildParagraph(String text) {
    final double indentSize = 30.0; 

    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        width: double.infinity,
        child: Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                alignment: ui.PlaceholderAlignment.middle,
                child: SizedBox(
                  width: indentSize,
                ),
              ),
              TextSpan(
                text: text,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event Conference & Management',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
        Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/aa.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Using organizational skills to plan social or business events is Event Management. It comprises Indian weddings, concerts, seminars, corporate meetings, birthday parties, and much more. Event management is a substantial blend of creativity and technical skills.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
              'People face hidden challenges in the execution of the events, and it is not so easy to manage the show and get maximum results from it. So being one of the top event management companies in India, planotech provides you with the best.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
              'Events and occasions are an integral part of human life. We cannot bypass them as they touch almost all aspects of our social existence. Managing it is a science of planning, organizing, and executing.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
              'Well, if you are wondering what makes a great exhibition show, then we are the answer to it. Our primary goal is to ensure that you have a successful and bother-show experience. Whether you are scouting for a distinct stand design or hassle-free show management, our project managers are always there to help you. You can always choose to get an exhibition stand hired by partnering with us.',            
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
              'It’s great to imagine yourself using all the bells and whistles a powerful abstract management system can provide you. But in reality, there are different systems for different types and sizes of conferences, and we suggest the best of its kind that completely satisfies all your requirements keeping in mind the necessities.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
          ],
        ),
      ),
          ],
        ),
      )
    );
  }
}
