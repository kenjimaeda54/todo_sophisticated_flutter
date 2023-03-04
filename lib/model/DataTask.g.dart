// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DataTask.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class DataTask extends _DataTask
    with RealmEntity, RealmObjectBase, RealmObject {
  DataTask(
    ObjectId id,
    String description,
    String date,
    String hour, {
    Iterable<int> idListImg = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'hour', hour);
    RealmObjectBase.set<RealmList<int>>(
        this, 'idListImg', RealmList<int>(idListImg));
  }

  DataTask._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String get date => RealmObjectBase.get<String>(this, 'date') as String;
  @override
  set date(String value) => RealmObjectBase.set(this, 'date', value);

  @override
  String get hour => RealmObjectBase.get<String>(this, 'hour') as String;
  @override
  set hour(String value) => RealmObjectBase.set(this, 'hour', value);

  @override
  RealmList<int> get idListImg =>
      RealmObjectBase.get<int>(this, 'idListImg') as RealmList<int>;
  @override
  set idListImg(covariant RealmList<int> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<DataTask>> get changes =>
      RealmObjectBase.getChanges<DataTask>(this);

  @override
  DataTask freeze() => RealmObjectBase.freezeObject<DataTask>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(DataTask._);
    return const SchemaObject(ObjectType.realmObject, DataTask, 'DataTask', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('date', RealmPropertyType.string),
      SchemaProperty('hour', RealmPropertyType.string),
      SchemaProperty('idListImg', RealmPropertyType.int,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
