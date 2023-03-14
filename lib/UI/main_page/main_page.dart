import 'package:flutter/material.dart';
import 'package:mahasainik_app/UI/cart/cart_screen.dart';
import 'package:mahasainik_app/UI/categories/categories_screen.dart';
import 'package:mahasainik_app/UI/home/home_page.dart';
import 'package:mahasainik_app/UI/wishlist/wishlist_screen.dart';
import 'package:mahasainik_app/utils/color_assets.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _bottomListItems = [
    HomePage(),
    CategoriesScreen(),
    WishlistScreen(),
    CartScreen(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomListItems.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemSelected,
        currentIndex: _selectedIndex,
        unselectedItemColor: AppColors.greyColor,
        selectedItemColor: AppColors.primaryColor,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category_outlined,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline_rounded,
            ),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
