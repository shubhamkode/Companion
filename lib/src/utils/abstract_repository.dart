abstract class Repository<T> {
  Future<List<T>> readAll();

  Future<T?> read(String id);

  Future<void> update(String id, T updatedObj);

  Future<void> delete(T obj);

  Future<String> create(T obj);

  Future<void> deleteMultiple(List<String> ids);

  Future<void> insertMultipleIfNotExists(List<Map<String, dynamic>> objs);
}
