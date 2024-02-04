import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/bottom_nav_items.dart';
import '../../logic/bottom_nav_bloc/bottomnav_bloc.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomnavBloc, BottomnavState>(
      listener: (context, state) {
        if (state.currentIndex == 2) {}
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.black,
                items: bottomNavItems,
                currentIndex: state.currentIndex,
                selectedItemColor: Colors.teal[400],
                unselectedItemColor: Colors.grey,
                onTap: (index) {
                  context
                      .read<BottomnavBloc>()
                      .add(BottomNavChange(currentIndex: index));
                },
              ),
              body: Center(
                child: bottomNavScreen[state.currentIndex],
              ),
            ),
          ),
        );
      },
    );
  }
}
