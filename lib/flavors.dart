enum Flavor {
  production,
  staging,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.production:
        return 'Jitilab Test';
      case Flavor.staging:
        return 'Staging Jitilab Test';
      default:
        return 'title';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.staging:
        return 'https://659562f304335332df829e12.mockapi.io/api/v1/';
      case Flavor.production:
        return 'https://659562f304335332df829e12.mockapi.io/api/v1/';
      default:
        return 'https://659562f304335332df829e12.mockapi.io/api/v1/';
    }
  }

}
