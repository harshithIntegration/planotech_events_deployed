import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class INTERIOR extends StatefulWidget {
  const INTERIOR({Key? key});

  @override
  State<INTERIOR> createState() => _InteriorState();
}

class _InteriorState extends State<INTERIOR> {
  Widget _buildParagraph(List<String> texts) {
    final double indentSize = 30.0;

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
          'Interior designing',
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
                        'assets/interior.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "There are many services that interior designer provides, but before that, you must be clear on what are you expecting? What are your requirements?",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                   const SizedBox(height: 15),
                  const Text(
                    "We will first go through your space then take measurements and photos of your house so we can plan according to it. We also suggest you some ideas suitable according to your budget and also suggest what can be placed in which direction and what kind of interior furniture to buy.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                   const SizedBox(height: 15),
                  const Text(
                    "We offer design services for home, office, hotel, shop, store, and any other space and we offer you below services which include-",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildParagraph([
                    "- Design of the interior.",
                    "- Product and furniture planning.",
                    "- Lights and decor.",
                    "- Product sourcing.",
                    "- Architectural drawings.",
                    "- Space planning.",
                    "- Project management.",
                    "- Shipping and installation.",
                    "- Colour consulting.",
                    "- Window treatments.",
                    "- Lighting placement.",
                    "- Room makeovers.",
                    "- Re-modelling and renovation.",
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
