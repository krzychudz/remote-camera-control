import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomBarSelectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _bottomBarSelectedIndex = index;
    });
  }

  String _getTitleForTab(int index) {
    if (index == 0) {
      return "Dashboard";
    } else {
      return "Settings";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getTitleForTab(_bottomBarSelectedIndex),
        ),
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
      body: const Center(
        child: Text("HOME"),
      ),
    );
  }
}
