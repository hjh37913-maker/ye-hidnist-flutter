# Є-Гідність — Flutter

Нативний Flutter-прототип за ТЗ «Є-Гідність 3.0» та наданим HTML-прототипом.

## Вимоги
- Flutter 3.24+
- Dart 3.5+
- Android SDK з API для актуального Flutter
- Java 17

## Запуск
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Release APK
```bash
flutter build apk --release --target-platform android-arm64
```

APK буде у:
`build/app/outputs/flutter-apk/app-release.apk`

## Demo
Реального бекенду/Дії немає. Усі сценарії локальні:
- Access Gate
- демонстраційний Diia flow
- Login
- чати та повідомлення
- спільноти
- новини
- профіль
- QR учня
- демонстраційне сканування вчителя
- адмінка
- темна тема

Перший запуск автоматично створює демонстраційні дані. Сесія та налаштування зберігаються локально.
