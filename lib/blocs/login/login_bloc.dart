import 'dart:async';
import 'package:aos/presentation/pages/selections_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/generate_user_actions.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Register>(_onRegister);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
  }

  void _onRegister(Register event, Emitter<LoginState> emit) async {
    var makeUser = GenerateUserActions();
    var user =
        await makeUser.generateRegisteredUser(event.email, event.password);
    await makeUser.generateUserCollection(event.email);
    emit(
      UserLoggedIn(user: user),
    );
  }

  void _onLogin(Login event, Emitter<LoginState> emit) async {
    var getUser = GenerateUserActions();
    var user = await getUser.generateLoggedInUser(event.email, event.password);
    await getUser.generateUserCollection(event.email);
    emit(
      UserLoggedIn(user: user),
    );
  }

  void _onLogout(Logout event, Emitter<LoginState> emit) async {
    var genLogout = GenerateUserActions();
    await genLogout.generateLoggedOutUser();
  }
}
