sealed class PrefsKeys {
  final String value;
  const PrefsKeys(this.value);
}

class AppInitialized extends PrefsKeys {
  AppInitialized() : super("app_initialized");
}
