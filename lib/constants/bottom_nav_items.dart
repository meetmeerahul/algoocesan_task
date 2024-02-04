
import 'package:flutter/material.dart';

import '../screens/cart_screen/cart_screen.dart';
import '../screens/histroy_screen/history_screen.dart';
import '../screens/home_screen/home_screen.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.history),
    label: 'History',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.shopping_bag),
    label: 'Cart',
  ),
];

final bottomNavScreen = [
  const HOmeScreen(),
  const HistroyScreen(),
  const CartScreen(),
];
