import 'package:hive_flutter/adapters.dart';
 part 'model.g.dart';


@HiveType(typeId: 1)
class MusicModel extends HiveObject {
  // int? id;
  //new folder create
  @HiveField(0)
  String name;

  @HiveField(1)
  List<int> songData;

  MusicModel({required this.name, required this.songData});
  //song add 
  add(int id) async {
    songData.add(id);
    save();
  }
 
  deleteData(int id) {
    songData.remove(id);
    save();
  }

  bool isValueIn(int id) {
    return songData.contains(id);
  }
}