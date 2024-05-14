import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class STALL  extends StatefulWidget {
  const STALL ({Key? key});

  @override
  State<STALL > createState() => _StallState();
}

class _StallState extends State<STALL > {
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
          'Stall Designing & Execution',
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
                  'assets/stall.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'The exhibition designer aims to advertise the products, brands, and identity of the consumer by designing striking shows or exhibition stalls using graphical and visual components.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
            const Text(
              'With its vast landscape and booming economy, India is setting up a vibrant forum for the growth and advancement of exhibition and stall architecture.The show stand represents the company at the function. It’s vital that your stand architecture represents your company identity and also lets you draw more crowds.Planotech Events and Marketing Company has a core team of highly trained personnel and a manufacturing workers group and is the leading force for the construction and operation of stalls.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
            const Text(
              'Planotech has the best graphics and stalls designers, and we understand that Graphics and photographs boost the stand and draw attention to the booth as well as stalls. Not only are we comfortable, but we also guarantee productivity and get the most advantages.To get the expected results, the first step you take in choosing your stall model needs to be right.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
            const Text(
              'if you want to create an eye-catching stall, then you should consider Planotech; we are very useful for professional stall designing and execution.We listen, we plan, and we execute. We combine concepts and experiences to create balanced architecture viewpoints that will make your stall unique. From idea to implementation, we give you a simple, reliable, and easy-to-use exhibition set-up experience.',            
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
            const Text(
              'Exhibitions are busy venues, so it’s vital to ensure that stall designs are recognizable and equally attractive.We create a dynamic and personalized interface for your company that will help you harness and benefit from the influence of social media. Across platforms and different touchpoints, we will allow your brand to explore its audience, communicate with consumers and bring a new dimension to its presence.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
            const Text(
              'The eye-catching style will also help attract consumers to your stand, which in effect will yield the desired outcomes.Planotech Events and Marketing Department holds the right amount of expertise and offers the latest product at a fair cost.',
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
