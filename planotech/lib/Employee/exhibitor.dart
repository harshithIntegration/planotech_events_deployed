import 'package:flutter/material.dart';
import 'package:planotech/Employee/attendance.dart';
import 'package:planotech/Employee/report.dart';
var empid;
class ExhibitorPage extends StatefulWidget {
  ExhibitorPage({Key? key, required int userId}) : super(key: key){
   empid=userId;
   print(empid);
  }


  @override
  _ExhibitorPageState createState() => _ExhibitorPageState();
}

class _ExhibitorPageState extends State<ExhibitorPage> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      _currentPageIndex = _tabController.index;
    });
    _pageController.animateToPage(_currentPageIndex, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Schedule'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Clear all data and navigate to a different class
            Navigator.of(context).pop();
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) {
            _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          },
          tabs: const [
            Tab(text: 'Attendance'),
            Tab(text: 'Report'),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          _tabController.animateTo(page);
        },
        children: [
          AttendancePage(empid), // navigate to AttendancePage
          Reportpage(empid),     // navigate to ReportPage
        ],
      ),
    );
  }
}