import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

export 's_name.dart';

class S {
  static const supportedLocales = [
    Locale('en'),
    Locale('ru'),
  ];
  static const _delegate = CustomLocalizationsDelegate();
  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    _delegate,
  ];

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  final Locale locale;
  final Map<String, String> translations;

  S._(this.locale, this.translations);

  String get(String key) {
    final string = translations[key];
    if (string == null) {}
    return string ?? 'unknown';
  }

  String withValue(String key, int value) {
    final string = translations[key];
    if (string == null) {}
    return '$string $value';
  }
}

class CustomLocalizationsDelegate extends LocalizationsDelegate<S> {
  const CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => S.supportedLocales
      .map((e) => e.languageCode)
      .contains(locale.languageCode);

  @override
  Future<S> load(Locale locale) async {
    final content =
        await rootBundle.loadString('l10n/${locale.languageCode}.json');
    final map = jsonDecode(content) as Map<String, dynamic>;
    return S._(locale, map.map((key, value) => MapEntry(key, value as String)));
  }

  @override
  bool shouldReload(CustomLocalizationsDelegate old) => false;
}
