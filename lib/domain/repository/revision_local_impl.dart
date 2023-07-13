abstract class RevisionRemoteDatasource {
  Future<void> set(int revision);
  int get();
}
