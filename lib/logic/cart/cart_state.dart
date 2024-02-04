part of 'cart_bloc.dart';

sealed class CartState {
  final List<List<String>> cartItems;
  final int total;

  CartState({required this.cartItems, required this.total});
}

final class CartInitial extends CartState {
  CartInitial({required super.cartItems, required super.total});
}
