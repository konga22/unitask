enum AppPage { login }

extension AppPageExtension on AppPage {
  String get path => '/$name';
}
