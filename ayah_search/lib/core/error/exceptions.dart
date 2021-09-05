class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class CacheException implements Exception {}

class NoInternetException implements Exception {}
