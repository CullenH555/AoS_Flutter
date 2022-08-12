part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class Register extends LoginEvent {
  final String email;
  final String password;
  const Register({this.email = '', this.password = ''});

  @override
  List<Object?> get props => [email, password];
}

class Login extends LoginEvent {
  final String email;
  final String password;
  const Login({this.email = '', this.password = ''});

  @override
  List<Object?> get props => [email, password];
}

class Logout extends LoginEvent {
  @override
  List<Object?> get props => [];
}
