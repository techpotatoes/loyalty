import 'package:hive/hive.dart';

abstract class Repository<T extends HiveObject> {
  Future<void> save(T newObject);

  Future<void> delete(T objectToDelete);

  Future<void> deleteAll();

  Future<List<T>> getAll();

  Future<T> getById(String id);
}
