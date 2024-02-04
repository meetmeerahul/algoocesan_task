import 'package:hive/hive.dart';
part 'dog_model.g.dart';

@HiveType(typeId: 0)
class DogModel {
  @HiveField(1)
  final String imageUrl;

  DogModel({required this.imageUrl});
}
