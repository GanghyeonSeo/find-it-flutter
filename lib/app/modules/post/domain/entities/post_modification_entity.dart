import 'package:find_it/app/modules/post/domain/enums/item_category.dart';
import 'package:find_it/app/modules/post/domain/enums/post_type.dart';

class PostModificationEntity {
  final String title;
  final PostType type;
  final String location;
  final ItemCategory itemType;
  final String description;

  PostModificationEntity({
    required this.title,
    required this.type,
    required this.location,
    required this.itemType,
    required this.description,
  });
}
