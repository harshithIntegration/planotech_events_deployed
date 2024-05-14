import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ware extends StatefulWidget {
  const ware({Key? key});

  @override
  State<ware> createState() => _WareState();
}

class _WareState extends State<ware> {
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
          'WARE HOUSE SERVICES',
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
                        'assets/wear.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'The warehouse is a commercial building for the storage of goods. Warehouses are used by manufacturers,importers,exporters,wholesalers,transport businesses, customs, and a lot more.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                   const SizedBox(height: 15),
                  const Text(
                    'The five types of warehouses:',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  _buildParagraph([
                    'The five types of warehouses:',
                    '1. Private Warehouses',
                    '2. Public Warehouses',
                    '3. Bonded Storage',
                    '4. Co-operative Warehouses',
                    '5. Distribution Centres',
                  ]),
                   const SizedBox(height: 15),
                  const Text(
                    'Warehousing and logistics are two different sides of the same coin, which is the safe & economical storage of goods, inventory, information within a specified area, or building. Logistics is generally the detailed organization and implementation of a complex operation in different management times.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                   const SizedBox(height: 15),
                  const Text(
                    'Co-operative Warehouses: These warehouses are owned, managed, and controlled by Cooperative societies. These societies provide storage facilities at the most economical rates for their members only. The primary purpose of running such warehouses is not to earn profits but to help their members.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                   const SizedBox(height: 15),
                  const Text(
                    'Bonded Storage: These warehouses are owned, managed, and controlled by the government as well as private agencies. Bonded warehouses are storage facilities used to store imported goods for which import duty is still paid. The bonded warehouses which are run by private agencies have to obtain a license from the government. Globally, it will be seen that these warehouses are found near the ports and usually owned by dock authorities. Bonded warehouses are subject to two types of taxes: (a) Excise duty and (b) Custom duty.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                   const SizedBox(height: 15),
                  const Text(
                    'Distribution Centres: These types of storage facilities usually have ample space, which enables the fast movement of large quantities of stores for a short period. While, on the other hand, conventional warehouses hold goods for a long time, say two months or one year. These warehouses, basically by nature, serve as points in the distribution system at which goods are procured from different suppliers and quickly transferred to various customers. To minimize delivery time, these storage facilities are found close to transportation centers.',
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
