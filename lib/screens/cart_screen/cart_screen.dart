
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/snackbar.dart';
import '../../logic/cart/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

    context.read<CartBloc>().add(DisplayCartItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Cart 🧳",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
        ),
        centerTitle: true,
        leading: const Image(
          height: 100,
          width: 200,
          image: AssetImage("assets/dog.png"),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.cartItems.isEmpty) {
                return const Center(
                  child: Text(
                    "Your Cart Is Empty",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.cartItems.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Colors.grey,
                          height: 2,
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: ListTile(
                              tileColor: Colors.white,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    state.cartItems[index][2],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const Text(
                                    " x ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    state.cartItems[index][1],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '= ${int.parse(state.cartItems[index][1]) * int.parse(state.cartItems[index][2])}',
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<CartBloc>().add(
                                            DecreaseCatItemCountEvent(
                                                imageUrl: state.cartItems[index]
                                                    [0]),
                                          );
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                            DeleteCartItemEvent(id: index),
                                          );

                                      showSnackbar(
                                          context,
                                          "Removed  dog from cart ",
                                          const Color.fromARGB(
                                              255, 236, 103, 94));
                                    },
                                    child: const Text(
                                      "Remove",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<CartBloc>().add(
                                            IncreaseCartItemCountEvent(
                                                imageUrl: state.cartItems[index]
                                                    [0]),
                                          );
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              leading: Container(
                                height: 200,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(state.cartItems[index][0]),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      color: Colors.teal,
                      child: Text(
                        'Total: Rs ${state.total.toString()}',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
