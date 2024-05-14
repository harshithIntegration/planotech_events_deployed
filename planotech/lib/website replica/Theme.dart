import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Themepage extends StatefulWidget {
  const Themepage({Key? key});

  @override
  State<Themepage> createState() => _ThemeState();
}

class _ThemeState extends State<Themepage> {
  Widget _buildParagraph(List<String> texts) {
    const double indentSize = 30.0;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: texts.map((text) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
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
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 8), // Space between paragraphs
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Theme event',
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
                        'assets/theme.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "It’s a time for enjoying…whether it might be corporate get-together or personal celebration. Every event demands component of exclusivity as per the customer’s profile, occasion, conditions, and venue orientation.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "There comes a moment in everybody’s life and to make those occasions memorable ever after is our work.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Importance of the theme in event planning:",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  _buildParagraph([
                    "- Ensures a cohesive unit.",
                    "- It creates buzz.",
                    "- Helps to gain the guest’s focus.",
                    "- Sea beach theme party.",
                    "- Adventure theme party.",
                    "- Casino theme party.",
                    "- Mask theme party.",
                    "- Halloween theme party.",
                    "- Bollywood theme party.",
                    "- Rock star theme party.",
                    "- Corporate parties.",
                    "- Birthday parties.",
                    "- Get-togethers.",
                    "- Engagement ceremony.",
                    "- Wedding parties.",
                    "- Launch parties.",
                    "- Commercial parties.",
                    "- Theme events.",
                  ]),
                  const SizedBox(height: 15),
                  const Text(
                    "Now that you know all the advantages of an event theme, will you give yourself time to find one that will suit your next event? If you need the helping hand of an event agency, we are here for you.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                    const SizedBox(height: 15),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
