import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  String get message;

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String _message;

  const ServerFailure(this._message);

  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class NetworkFailure extends Failure {
  final String _message;

  const NetworkFailure(this._message);

  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class CacheFailure extends Failure {
  final String _message;

  const CacheFailure(this._message);

  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class ValidationFailure extends Failure {
  final String _message;

  const ValidationFailure(this._message);

  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class UnauthorizedFailure extends Failure {
  final String _message;

  const UnauthorizedFailure(this._message);

  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class NotFoundFailure extends Failure {
  final String _message;

  const NotFoundFailure(this._message);

  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class ConflictFailure extends Failure {
  final String _message;

  const ConflictFailure(this._message);

  @override
  String get message => _message;

  @override
  List<Object> get props => [_message];
}
