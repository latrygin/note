abstract class RevisionLocalDatasource {
  Future<void> set(bool localRevision);
  bool get();
}
