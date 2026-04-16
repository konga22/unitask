enum AppPage { login, signup }

extension AppPageExtension on AppPage {
  String get path => '/$name';
}
