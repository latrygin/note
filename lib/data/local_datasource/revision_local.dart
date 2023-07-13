import 'package:note/domain/repository/revision_remote_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RevisionLocal implements RevisionLocalDatasource {
  static const String _key = 'local_revision';
  late SharedPreferences _pref;

  RevisionLocal() {
    _prefs();
  }

  @override
  bool get() {
    final localRevision = _pref.getBool(_key) ?? false;
    return localRevision;
  }

  @override
  Future<void> set(bool localRevision) async {
    await _pref.setBool(_key, localRevision);
  }

  Future<void> _prefs() async {
    _pref = await SharedPreferences.getInstance();
  }
}
