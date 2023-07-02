import 'package:note/data/mock_datasource/revision_remote_mock.dart';
import 'package:note/domain/repository/revision_local_impl.dart';
import 'package:test/test.dart';

void main() {
  group('REMOTE REVISION:', () {
    late RevisionRemoteDatasourceImpl revisionRemoteDatasource;

    setUpAll(() {
      revisionRemoteDatasource = RevisionRemoteMock();
    });

    test('get revision', () {
      final revision = revisionRemoteDatasource.get();
      expect(revision, 1);
    });

    test('set revision', () async {
      const newRevision = 5;
      await revisionRemoteDatasource.set(newRevision);
      final revision = revisionRemoteDatasource.get();
      expect(revision, newRevision);
    });
  });
}
