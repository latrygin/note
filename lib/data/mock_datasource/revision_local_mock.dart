import 'package:note/domain/repository/revision_remote_impl.dart';

class RevisionLocalMock implements RevisionLocalDatasourceImpl {
  bool _revision = true;

  @override
  bool get() {
    return _revision;
  }

  @override
  Future<void> set(bool localRevision) {
    _revision = localRevision;
    return Future.value();
  }
}
