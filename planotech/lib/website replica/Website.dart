import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Website extends StatefulWidget {
  const Website({Key? key});

  @override
  State<Website> createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {
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
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
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
            'Website Designing & Development',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                          'assets/website.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Website designing is the most basic tasks one must do to start.A website is how you present your company, your brand, and your self to the world. You would deﬁnitely want it to look the best it can. The website should give out enough information to the visitors, also limiting it at one point. You do not want to make it look clumsy and too packed up.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Good web design involves understanding the client’s marketing objectives and translating these into a design that combines intuitive navigation, useful and relevant content with compelling calls to action that will ultimately generate you more business. We work across many sectors, including property, ﬁnancial services, retail, media & communications, and trade associations.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'We offer you outstanding web developers that help you create your feelings on the internet. All the details from the client do give preference, and we work around and get creative within your boundaries. We realize the importance of the website and how it’s a fantastic portal to the rest of the world. We put in with equal effort and time to satisfy everyone as your clients are our clients too. Keeping your clients happy will give us immense satisfaction.Web design is essential because it impacts how your audience perceives your brand.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'The impression you make on them can either get them to remain on your page and learn about your business or leave your page and turn to a competitor. Here we give you the designer with a good web design that helps you keep your leads on your page.',
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
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
