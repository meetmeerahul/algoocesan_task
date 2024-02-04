// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

sealed class CartEvent {}

class AddToCartEvent extends CartEvent {
  final int rate;
  final String imageUrl;
  final int qty;

  AddToCartEvent(
      {required this.rate, required this.imageUrl, required this.qty});
}

class DisplayCartItems extends CartEvent {}

class DeleteCartItemEvent extends CartEvent {
  int id;
  DeleteCartItemEvent({
    required this.id,
  });
}

class IncreaseCartItemCountEvent extends CartEvent {
  String imageUrl;
  IncreaseCartItemCountEvent({
    required this.imageUrl,
  });
}

class DecreaseCatItemCountEvent extends CartEvent {
  String imageUrl;
  DecreaseCatItemCountEvent({
    required this.imageUrl,
  });
}
