import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Product extends StatefulWidget {
  const Product({Key? key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  Widget _buildParagraph(String text) {
    const double indentSize = 30.0; 

    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        width: double.infinity,
        child: Text.rich(
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
          'Product Launch & Roadshows',
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
                  'assets/product.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'The product introduction is anytime a corporation wants to sell a new product. The product launch may be an established product that is still on the market, or it may be a brand new groundbreaking product that the company has produced.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
            const Text(
              'Launching a product is not a simple operation. It involves a real investment of time and energy, mainly because you want your audience to have the launch successful and well-received. You need to take a good look at your competitors before you send your product to the market. After all, a vast amount of money went into developing the product or service, so it needs a corresponding launch.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
            const Text(
              'A product launch is not an event but a process. So when you come up with the product (idea) and start growing, we get an understanding of the consumer market, ways to meet this market, the consumer purchasing process, the eco-system, and competitors as well.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
            const Text(
              'With knowledge, we fuse the power of ideas to generate compelling personal interactions that allow our clients to entertain and draw more customers. We initially expend some time and energy, filtering your suggestion thoughts to the bull’s eye. That gives you the maximum results and excellent sources to implement your ideas on the product. You will figure out in advance what the target audience is talking about, what they are doing, and what drives their decision to buy. You will figure out in advance what the target audience is talking about, what they are doing, and what drives their decision to buy. Conducting initial market validation will save you a fortune and significantly increase your likelihood of success.',            
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
            const Text(
              'For a variety of commercial outlets, the only roadshow produces face-to-face customer trading. If the new world of technology remains, there are areas where roadshow helps to build brand recognition for all the people in your intended location when organizing such an event for you, where you will have the chance to meet and connect side-by-side with your consumers and communicate with them in a straight line. A roadshow is essential for a corporation to market the investment plan to the target stakeholders. It involves meetings and conventions for current and prospective partners for a variety of existences',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 15),
            const Text(
              'It recommended conducting roadshows in different geographies to attract new investors. Sometimes it can be tough to conduct several roadshows due to the constricted schedule of top management executives. Planotech always starts at the given scheduled time, and the buffer time between two meetings is still sufficient to see the growth and work on their project.',
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
