import 'package:note/data/mock_datasource/revision_local_mock.dart';
import 'package:note/domain/repository/revision_remote_impl.dart';
import 'package:test/test.dart';

void main() {
  group('LOCAL REVISION:', () {
    late RevisionLocalDatasource revisionLocalDatasource;

    setUpAll(() {
      revisionLocalDatasource = RevisionLocalMock();
    });

    test('get revision', () {
      final revision = revisionLocalDatasource.get();
      expect(revision, true);
    });

    test('set revision', () async {
      await revisionLocalDatasource.set(false);
      final revision = revisionLocalDatasource.get();
      expect(revision, false);
    });
  });
}
