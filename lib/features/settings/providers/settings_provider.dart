import 'package:flutter/material.dart';

import '../models/app_settings.dart';
import '../repositories/settings_repository.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider({
    SettingsRepository? repository,
  }) : _repository =
            repository ?? SettingsRepository();

  final SettingsRepository _repository;

  AppSettings _settings =
      const AppSettings();

  bool _loading = false;

  Locale _locale =
      const Locale('tr');

  AppSettings get settings => _settings;

  bool get loading => _loading;

  Locale get locale => _locale;

  Future<void> load() async {
    _loading = true;
    notifyListeners();

    _settings =
        await _repository.load();

    _locale =
        Locale(_settings.languageCode);

    _loading = false;
    notifyListeners();
  }

  Future<void> setLocale(
    String languageCode,
  ) async {
    _locale =
        Locale(languageCode);

    _settings =
        _settings.copyWith(
      languageCode:
          languageCode,
    );

    notifyListeners();

    await _repository.save(
      _settings,
    );
  }

  Future<void> update(
    AppSettings settings,
  ) async {
    _settings = settings;

    _locale =
        Locale(settings.languageCode);

    notifyListeners();

    await _repository.save(
      settings,
    );
  }
}