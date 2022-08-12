import 'dart:async';

import 'package:aos/presentation/pages/first_page.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/generate_logged_in_user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Login>(_onLogin);
  }

  void _onLogin(Login event, Emitter<LoginState> emit) async {
    var makeUser = GenerateLoggedInUser();
    var user = await makeUser.generateLoggedInUser(event.email, event.password);
    emit(
      UserLoggedIn(user: user),
    );
  }
}
