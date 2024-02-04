import 'package:hive/hive.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 1)
class CartModel {
  @HiveField(0)
  final String imageUrl;
  @HiveField(1)
  final int rate;
  @HiveField(2)
  int qnt;

  CartModel({required this.imageUrl, required this.rate, required this.qnt});
}
