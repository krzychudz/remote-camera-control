import 'package:app/common/appbar/appbar.dart';
import 'package:app/dashboard/dashboard_page.dart';
import 'package:app/settings/settings_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
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
      return tr('dashboard');
    } else {
      return tr('account');
    }
  }

  final List<Widget> _pagesList = [
    const DashboardPage(),
    const SettingsScreen(),
  ];

  void _onAddButtonClicked(BuildContext context) {
    Navigator.of(context).pushNamed("/camera_installation");
  }

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      FirebaseMessaging.instance.getInitialMessage().then((value) {
        if (value != null) {
          Navigator.of(context).pushNamed("/livestream", arguments: value.data);
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        Navigator.of(context).pushNamed("/livestream", arguments: event.data);
      });
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
      floatingActionButton: _bottomBarSelectedIndex != 0
          ? null
          : FloatingActionButton(
              child: const Icon(
                Icons.add,
              ),
              onPressed: () => _onAddButtonClicked(context),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomBarSelectedIndex,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: tr('dashboard'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: tr('account'),
          ),
        ],
      ),
      body: IndexedStack(
        index: _bottomBarSelectedIndex,
        children: _pagesList,
      ),
    );
  }
}
