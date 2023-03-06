import 'package:realm/realm.dart';
part 'DataTask.g.dart'; // nome do arquivo

@RealmModel()
class _DataTask {
  @PrimaryKey()
  late final ObjectId id;
  late String description;
  late String dateTime;
  late int idListImg;
  late String colors;
}

final config = Configuration.local([DataTask.schema]);
var realm = Realm(config);
