import 'package:barber_admin/features/home/pages/account_page.dart';
import 'package:barber_admin/features/home/pages/appointments_page.dart';
import 'package:barber_admin/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedTab = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        onTap: (index) => _changeTab(index),
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }


  List _pages = [
    HomePage(),
    AppointmentsPage(),
    AccountPage(),
  ];
}
