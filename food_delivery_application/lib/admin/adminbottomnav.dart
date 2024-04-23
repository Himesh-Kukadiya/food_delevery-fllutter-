import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_application/admin/home_admin.dart';
import 'package:food_delivery_application/admin/admin_profile.dart';

class AdminBottomNav extends StatefulWidget {
  const AdminBottomNav({super.key});

  @override
  State<AdminBottomNav> createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  // variables
  int _currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;

  // all pages.
  late HomeAdmin homepage;
  late AdminProfile adminProfile;
  // late Wallet walletpage;
  // late Order orderpage;
  // late Profile profilepage;

  @override
  void initState() {
    // getting all pages.
    homepage = const HomeAdmin();
    // walletpage = const Wallet();
    // orderpage = const Order();
    adminProfile = const AdminProfile();

    // add all pages in to list.
    pages = [homepage, adminProfile];
    // pages = [homepage, walletpage, orderpage, profilepage];

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
          // Icon(
          //   Icons.wallet_outlined,
          //   color: Colors.white,
          // ),
          // Icon(
          //   Icons.shopping_cart_outlined,
          //   color: Colors.white,
          // ),
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