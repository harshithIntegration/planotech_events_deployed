import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DESIGNING extends StatefulWidget {
  const DESIGNING({Key? key});

  @override
  State<DESIGNING> createState() => _DESIGNINGState();
}

class _DESIGNINGState extends State<DESIGNING> {
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
          'Designing & Printing',
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
                  'assets/design.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Planotech Events & Marketing (OPC) Pvt Ltd is dedicated to serving a diverse clientele with an unwavering commitment to quality and service speed. From catering to blue-chip clients to upholding our core values, we take pride in our innovative solutions.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                   const SizedBox(height: 20),
            const Text(
              'In addition to our broad range of services, we understand the significance of event promotion. Event flyers, being a traditional yet effective marketing tool, play a crucial role in raising awareness for your event. Our team excels in designing and printing, making it a seamless process for our clients.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                   const SizedBox(height: 20),
            const Text(
              'Whether you prefer selecting from our set of existing templates or opt for specially customized plans, we’ve got you covered. Our designers are adept at creating visually appealing materials that capture the essence of your event. Design and printing are integral aspects, and we ensure each detail contributes to the overall success of your promotional efforts.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                   const SizedBox(height: 20),
            const Text(
              'As part of our commitment to providing comprehensive solutions, we recognize the growing popularity of online casino events. If you’re hosting an event related to online casino craps, we can incorporate specific design elements and promotional strategies tailored to this theme. The excitement and thrill of casino games can be effectively conveyed through our design expertise.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ],
        ),
      ),
          ],
        ),
      )
    );
  }
}
