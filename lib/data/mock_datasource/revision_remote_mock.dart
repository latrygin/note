import 'package:note/domain/repository/revision_local_impl.dart';

class RevisionRemoteMock implements RevisionRemoteDatasourceImpl {
  int _revision = 1;

  @override
  int get() {
    return _revision;
  }

  @override
  Future<void> set(int revision) {
    _revision = revision;
    return Future.value();
  }
}
