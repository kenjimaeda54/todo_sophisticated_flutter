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
    String dateTime,
    int idListImg,
    String colors,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'dateTime', dateTime);
    RealmObjectBase.set(this, 'idListImg', idListImg);
    RealmObjectBase.set(this, 'colors', colors);
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
  String get dateTime =>
      RealmObjectBase.get<String>(this, 'dateTime') as String;
  @override
  set dateTime(String value) => RealmObjectBase.set(this, 'dateTime', value);

  @override
  int get idListImg => RealmObjectBase.get<int>(this, 'idListImg') as int;
  @override
  set idListImg(int value) => RealmObjectBase.set(this, 'idListImg', value);

  @override
  String get colors => RealmObjectBase.get<String>(this, 'colors') as String;
  @override
  set colors(String value) => RealmObjectBase.set(this, 'colors', value);

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
      SchemaProperty('dateTime', RealmPropertyType.string),
      SchemaProperty('idListImg', RealmPropertyType.int),
      SchemaProperty('colors', RealmPropertyType.string),
    ]);
  }
}
