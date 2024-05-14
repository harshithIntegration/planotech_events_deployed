import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Wedding extends StatefulWidget {
  const Wedding({Key? key});

  @override
  State<Wedding> createState() => _WeddingState();
}

class _WeddingState extends State<Wedding> {
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
                      const WidgetSpan(
                        alignment: ui.PlaceholderAlignment.middle,
                        child: SizedBox(
                          width: indentSize,
                        ),
                      ),
                      TextSpan(
                        text: text,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 8), // Space between paragraphs
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
          'Wedding planning and execution',
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
                        'assets/wedding.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'A wedding planner is a person who assists with the design, planning, and management of a client’s wedding. Weddings are significant events in people’s lives.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Professional wedding planners are based worldwide but the industry is the largest in the USA, India, western Europe, and China. Various wedding planning courses are available to those who wish to pursue a career. Planners generally charge either a percentage of the total wedding cost or a flat fee.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Planners are also popular with couples planning a destination wedding, where the documentation and paperwork can be complicated. Any country where a wedding is held requires different procedures depending on the nationality of each the bride and the groom. For instance, US citizens marrying in Italy require a Nulla Osta (affidavit sworn in front of the US consulate in Italy), plus an Atto Notorio (sworn in front of the Italian consulate in the US or at a court in Italy), and legalization of the above. Some countries instead have agreements and the couple can get their No Impediment forms from their local registrar and have them translated by the consulate in the country of the wedding. A local wedding planner can take care of the different procedures.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  _buildParagraph([
                    '- Preparation of the budget.',
                    '- Design and style of the event.',
                    '- Scouting locations.',
                    '- Photoshoots.',
                  ]),
                  const SizedBox(height: 15),
                  const Text(
                    'Event layout indicating the location of the dance floor, buffet points, tables, chairs, lounges, etc.',
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
      ),
    );
  }
}
