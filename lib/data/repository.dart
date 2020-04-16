import 'package:hive/hive.dart';

abstract class Repository<T extends HiveObject> {
  
  void save(T newObject);

  void delete(T objectToDelete);
  
  Future<List<T>> getAll();
}