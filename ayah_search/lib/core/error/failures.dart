import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<Object> properties;

  Failure([this.properties = const []]);

  @override
  List<Object> get props => properties;
}

// General failures
class ServerFailure extends Failure {
  final String message;

  ServerFailure(this.message) : super([message]);
}

class CacheFailure extends Failure {}

class NoInternetFailure extends Failure {}
