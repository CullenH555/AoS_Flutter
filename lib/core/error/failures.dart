import 'package:equatable/equatable.dart';

// TODO refactor to utilize Either type.
abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}
