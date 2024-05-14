import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Leads extends StatefulWidget {
  const Leads({Key? key});

  @override
  State<Leads> createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {
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
          'LEAD GENERATION ACTIVITIES',
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
                        'assets/lead.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Lead generation describes the marketing process of stimulating and capturing interest in a product or service to develop a sales pipeline.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'LEAD GENERATION ACTIVITIES',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Lead generation describes the marketing process of restorative and capturing interest in a product or service to develop sales pipelines.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Lead generation often uses digital channels which are undergoing substantial changes in recent years from the rise of new online trends and social technologies which led to the rise of “self-directed buyer” and the emergence of new technologies to develop and qualify potential leads before passing them to sales.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildParagraph([
                    '- The buying process has changed and marketers need to find new ways to reach the buyers and get heard through the noise. The importance of lead generation is as follows:',
                    '- Transformation of marketing: nowadays the new mission is to represent the customer being found, customer intelligence is targeting behavioral, mechanic, and tactics which shows continuous relationships exploding channels and measurement which is a big data owned fact-based decision making.',
                    '- New buying process.',
                    '- Leading down the funnel.',
                    '- Lead generation tactics:',
                    '- Trends survey.',
                    '- Company website.',
                    '- Conferences and tradeshows.',
                    '- Email-marketing.',
                    '- Public relations.',
                    '- Cost per inquiry.',
                    '- Cost per lead.',
                    '- SQL to opportunity.',
                    '- What our company provides:',
                    '- Inbound marketing.',
                    '- Content and SEO.',
                    '- Social media.',
                    '- Outbound marketing.',
                    '- Email-marketing.',
                    '- Displaying of ads.',
                    '- Pay per click.',
                    '- Content syndication.',
                    '- Direct mail.',
                    '- Sales development.',
                    '- Middle of the funnel.',
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
