import 'package:note/domain/repository/revision_local_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RevisionRemote implements RevisionRemoteDatasource {
  static const String _key = 'revision';
  late SharedPreferences _pref;

  RevisionRemote() {
    _prefs();
  }

  @override
  int get() {
    final revision = _pref.getInt(_key) ?? 0;
    return revision;
  }

  @override
  Future<void> set(int revision) async {
    await _pref.setInt(_key, revision);
  }

  Future<void> _prefs() async {
    _pref = await SharedPreferences.getInstance();
  }
}
