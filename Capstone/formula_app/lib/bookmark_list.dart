import 'package:hive/hive.dart';

part 'bookmark_list.g.dart';

@HiveType(typeId: 1)
class Bookmark {
  Bookmark({required this.name, required this.description});
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;
}
