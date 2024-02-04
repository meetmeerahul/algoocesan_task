import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/snackbar.dart';
import '../../logic/api_bloc/apifetch_bloc.dart';
import '../../logic/cart/cart_bloc.dart';

late int rate;

class HOmeScreen extends StatelessWidget {
  const HOmeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "The Dog Shop",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        centerTitle: true,
        leading: const Image(
          height: 100,
          width: 200,
          image: AssetImage(
            "assets/dog.png",
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<ApifetchBloc, ApifetchState>(
                      builder: (context, state) {
                        if (state.isLoading == true) {
                          return const SizedBox(
                            width: 200,
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.teal,
                              ),
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              SizedBox(
                                width: 200,
                                height: 400,
                                child: state.imageUrl != null
                                    ? Column(
                                        children: [
                                          Text(
                                            "Price : Rs ${getPrice()} ",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                          Image(
                                            image:
                                                NetworkImage(state.imageUrl!),
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                      )
                                    : state.hasError == true
                                        ? const Image(
                                            image:
                                                AssetImage('assets/error.jpg'),
                                            fit: BoxFit.contain,
                                          )
                                        : const Image(
                                            image: AssetImage('assets/dog.png'),
                                            fit: BoxFit.contain,
                                          ),
                              ),
                              SizedBox(
                                height: 50,
                                width: 150,
                                child: state.imageUrl != null
                                    ? ElevatedButton(
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                                AddToCartEvent(
                                                    imageUrl: state.imageUrl!,
                                                    qty: 1,
                                                    rate: rate),
                                              );

                                          showSnackbar(
                                              context, "Dog added to cart ");
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          textStyle:
                                              const TextStyle(fontSize: 16),
                                        ),
                                        child: const Text(
                                          "Add to Cart",
                                          style: TextStyle(color: Colors.amber),
                                        ),
                                      )
                                    : const Text(""),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                right: 60,
                child: SizedBox(
                  height: 50, // Set the height as per your requirement
                  width: 150, // Set the width as per your requirement
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ApifetchBloc>().add(FetchGodDetails());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text(
                      "Fetch",
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int getPrice() {
    num rand = 1000 + Random().nextInt(10000 - 1000 + 1);
    rate = rand.toInt();
    return rate;
  }
}
