
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'logic/api_bloc/apifetch_bloc.dart';
import 'logic/bottom_nav_bloc/bottomnav_bloc.dart';
import 'logic/cart/cart_bloc.dart';
import 'logic/history_bloc/history_bloc.dart';
import 'models/cart_model.dart';
import 'models/dog_model.dart';
import 'screens/bottom_nav/bottom_nav_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DogModelAdapter());
  Hive.registerAdapter(CartModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomnavBloc(),
        ),
        BlocProvider(
          create: (context) => ApifetchBloc(),
        ),
        BlocProvider(
          create: (context) => HistoryBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BottomNavScreen(),
      ),
    );
  }
}
