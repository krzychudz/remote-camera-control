import 'package:app/dashboard/dashboard_screen.dart';
import 'package:app/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomBarSelectedIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomBarSelectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  String _getTitleForTab(int index) {
    if (index == 0) {
      return "Dashboard";
    } else {
      return "Settings";
    }
  }

  final List<Widget> _pagesList = const [
    DashboardScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getTitleForTab(_bottomBarSelectedIndex),
        ),
      ),
      floatingActionButton: _bottomBarSelectedIndex != 0
          ? null
          : FloatingActionButton(
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {},
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomBarSelectedIndex,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _pagesList,
      ),
    );
  }
}
