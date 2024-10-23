import 'package:flutter/material.dart';
import 'package:sims_ppob_roni_rusmayadi/common/constants.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_home.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_profile.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_topup.dart';
import 'package:sims_ppob_roni_rusmayadi/persentation/pages/page_transaction.dart';

class HomeWidget extends StatefulWidget {
  final int? index;
  const HomeWidget({super.key, this.index});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomePage(),
    const TopUpPage(),
    const TransactionPage(),
    const ProfilePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.index != null) {
      setState(() {
        _currentIndex = widget.index!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        selectedItemColor: themeColor,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.money_rounded), label: 'Top Up'),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card), label: 'Transaction'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }
}
