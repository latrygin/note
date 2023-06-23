import 'package:note/domain/provider/revision/revision_provider_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RevisionProvider implements RevisionProviderImpl {
  static const String _key = 'revision';
  late SharedPreferences _pref;

  RevisionProvider() {
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
