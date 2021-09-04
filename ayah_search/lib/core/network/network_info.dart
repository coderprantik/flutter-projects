import 'package:connection_checker/connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get hasConnection;
}

class NetworkInfoImpl implements NetworkInfo {
  final ConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get hasConnection => connectionChecker.hasConnection;
}
