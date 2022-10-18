part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class UserLoggedIn extends LoginState {
  const UserLoggedIn({this.user = ''});
  final String user;

  @override
  List<Object?> get props => [user];
}

class UserLoggedOut extends LoginState {
  @override
  List<Object?> get props => [];
}
