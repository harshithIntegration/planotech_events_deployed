import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Digital  extends StatefulWidget {
  const Digital ({Key? key});

  @override
  State<Digital> createState() => _DigitalState();
}

class _DigitalState extends State<Digital> {
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
          'Digital Marketing',
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
                  'assets/digital.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Our domain expertise is considerable. We adopt a highly ﬂexible approach that enables our clients to either assign complete projects to us on an end-to-end basis or work with us for any part of their overall requirements.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
              'These are the key reasons for which global corporate giants choose to partner with us for all their digital needs. Traditional marketing is failing to reach audiences like it used to. In its place rises digital marketing or just marketing.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
              'As you look into redesigning your website, you may wonder about the importance of website design. How does it impact your audience and your business?',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
              'When your audience visits your website, it gives them their ﬁrst impression of your business, which will judge your business within seconds. In these ﬁrst few seconds, you want to make a positive impact on your audience.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
              'If your website looks unappealing or outdated, your audience will immediately have a negative impression of your business, which won’t ﬁnd your website appealing, which deters from your page.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
              'If your website looks unappealing or outdated, your audience will immediately have a negative impression of your business, which won’t ﬁnd your website appealing, which deters from your page.',
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
