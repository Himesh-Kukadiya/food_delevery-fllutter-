import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/pages/home.dart';
import 'package:food_delivery_application/pages/order.dart';
import 'package:food_delivery_application/pages/profile.dart';
import 'package:food_delivery_application/pages/wallet.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  // variables
  int _currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;

  // all pages.
  late Home homepage;
  late Wallet walletpage;
  late Order orderpage;
  late Profile profilepage;

  @override
  void initState() {
    // getting all pages.
    homepage = const Home();
    walletpage = const Wallet();
    orderpage = const Order();
    profilepage = const Profile();

    // add all pages in to list.
    pages = [homepage, walletpage, orderpage, profilepage];

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.wallet_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outlined,
            color: Colors.white,
          ),
        ],
      ),
      body: pages[_currentTabIndex],
    );
  }
}