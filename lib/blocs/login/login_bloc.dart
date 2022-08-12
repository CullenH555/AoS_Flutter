import 'dart:async';

import 'package:aos/presentation/pages/first_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/generate_logged_in_user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Register>(_onRegister);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
  }

  void _onRegister(Register event, Emitter<LoginState> emit) async {
    var makeUser = GenerateRegisteredUser();
    var user =
        await makeUser.generateRegisteredUser(event.email, event.password);
    emit(
      UserLoggedIn(user: user),
    );
  }

  void _onLogin(Login event, Emitter<LoginState> emit) async {
    var getUser = GenerateRegisteredUser();
    var user = await getUser.generateLoggedInUser(event.email, event.password);
    emit(
      UserLoggedIn(user: user),
    );
  }

  void _onLogout(Logout event, Emitter<LoginState> emit) async {
    var genLogout = GenerateRegisteredUser();
    await genLogout.generateLoggedOutUser();
  }
}
