import 'package:bloc/bloc.dart';

import 'package:hive/hive.dart';

import '../../models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial(cartItems: [], total: 0)) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AddToCartEvent>((event, emit) async {
      await addToCart(event.imageUrl, event.qty, event.rate);
    });

    on<DisplayCartItems>((event, emit) async {
      var cartItems = await getCartItems();
      int total = 0;
      for (var item in cartItems) {
        total = (int.parse(item[2]) * int.parse(item[1])) + total;
      }

      emit(CartInitial(cartItems: cartItems, total: total));
    });
    on<DeleteCartItemEvent>((event, state) async {
      await deleteItemFromCart(event.id);
      var cartItems = await getCartItems();
      int total = 0;
      for (var item in cartItems) {
        total = int.parse(item[2]) * int.parse(item[1]) + total;
      }
      emit(CartInitial(cartItems: cartItems, total: total));
    });

    on<IncreaseCartItemCountEvent>((event, emit) async {
      int count = await getCartItemDetails(event.imageUrl);

      increaeCartItemCount(event.imageUrl, count);

      fetchCartItemsAndUpdateCount();
    });
    on<DecreaseCatItemCountEvent>((event, emit) async {
      int count = await getCartItemDetails(event.imageUrl);

      decreaseCartItemCount(event.imageUrl, count);

      fetchCartItemsAndUpdateCount();
    });
  }

  addToCart(String imageUrl, int qty, int rate) async {
    var box = await Hive.openBox<CartModel>("cartbox");

    var itemList = box.values.toList();

    bool alreadyExists = false;

    for (var item in itemList) {
      if (item.imageUrl == imageUrl) {
        alreadyExists = true;
      }
    }

    if (!alreadyExists) {
      box.add(
        CartModel(imageUrl: imageUrl, rate: rate, qnt: qty),
      );
    }
  }

  getCartItems() async {
    var box = await Hive.openBox<CartModel>("cartbox");

    var cartList = box.values.toList();

    List<List<String>> result = [];

    for (var item in cartList) {
      result.add([item.imageUrl, item.qnt.toString(), item.rate.toString()]);
    }

    return result;
  }

  deleteItemFromCart(int id) async {
    var box = await Hive.openBox<CartModel>('cartbox');
    box.deleteAt(id);
  }

  getCartItemDetails(String imageUrl) async {
    var box = await Hive.openBox<CartModel>('cartbox');

    var items = box.values.toList();

    late int itemCount;

    for (var item in items) {
      if (item.imageUrl == imageUrl) {
        itemCount = item.qnt;
      }
    }

    return itemCount;
  }

  void increaeCartItemCount(String imageUrl, int count) async {
    var box = await Hive.openBox<CartModel>('cartbox');

    var items = box.values.toList();

    for (var item in items) {
      if (item.imageUrl == imageUrl) {
        item.qnt += 1;
      }
    }
  }

  void decreaseCartItemCount(String imageUrl, int count) async {
    var box = await Hive.openBox<CartModel>('cartbox');

    var items = box.values.toList();

    for (var item in items) {
      if (item.imageUrl == imageUrl) {
        if (item.qnt > 1) {
          item.qnt -= 1;
        }
      }
    }
  }

  void fetchCartItemsAndUpdateCount() async {
    var cartItems = await getCartItems();
    int total = 0;
    for (var item in cartItems) {
      total = int.parse(item[2]) * int.parse(item[1]) + total;
    }

    emit(CartInitial(cartItems: cartItems, total: total));
  }
}
