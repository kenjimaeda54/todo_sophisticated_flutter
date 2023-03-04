import 'package:realm/realm.dart';
part 'DataTask.g.dart'; // nome do arquivo

@RealmModel()
class _DataTask {
  @PrimaryKey()
  late final ObjectId id;
  late String description;
  late String date;
  late String hour;
  late List<int> idListImg;
}

final config = Configuration.local([DataTask.schema]);
var realm = Realm(config);
