// ignore_for_file: do_not_use_environment

abstract class URLs {
  static const String _path = String.fromEnvironment('PATH');
  static const String getAll = '$_path/list';
  static const String patch = '$_path/list';
  static const String post = '$_path/list';
  static String get(String id) {
    return '$_path/list/$id';
  }

  static String delete(String id) {
    return '$_path/list/$id';
  }

  static String put(String id) {
    return '$_path/list/$id';
  }
}
