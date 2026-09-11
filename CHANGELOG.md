# Changelog

## [2.0.1] - 2026-09-11

### Changed

- Upgrade development linting to official `flutter_lints: ^5.0.0`
- Upgrade Android toolchain to Gradle 9.3.1, AGP 9.1.0, Kotlin 2.4.0, and NDK 28
- Fix Android Gradle build failure by disabling obsolete Jetifier and bumping JVM heap

### Added

- Comprehensive unit test suite for MethodChannel calls and exception handling

### Fixed

- Example app SDK constraint (`sdk: ^3.12.0`) and version metadata
- Example app widget constructor keys and const correctness

## [2.0.0] - 2026-05-27

### Added

- Migrate to built-in Kotlin
- Migrate to Swift Package Manager

### Changed

- Updates minimum supported SDK version to Flutter 3.44 and Dart 3.12

## [1.1.0] - 2024-06-29

### Added

- Update Gradle project to adapt it to the latest version
- Improved plugin documentation
- Updated example project 

## [1.0.0] - 2022-10-31

### Changed

- Update internal dependencies.
- Set minimum Android SDK level to Android 6.0 (API level 23)

## [0.4.0] - 2021-11-30

### Added

- Method to determine if the device has an available torch.

## [0.3.0] - 2021-09-14

### Added

- Null safety support
- Lint rules

## [0.2.0] - 2021-02-23

### Added

- Enhance error management

## [0.1.0] - 2021-02-22

### Added

- Add the basic functionality in Android & iOS
