import 'package:aos_playmat_builder_flutter/data/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Register>(_onRegister);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
  }

  void _onRegister(Register event, Emitter<LoginState> emit) async {
    UserRepoImp makeUser = UserRepoImp();
    var user =
        await makeUser.generateRegisteredUser(event.email, event.password);
    await makeUser.generateUserCollection(event.email);
    emit(
      UserLoggedIn(user: event.email),
    );
  }

  void _onLogin(Login event, Emitter<LoginState> emit) async {
    UserRepoImp getUser = UserRepoImp();
    var user = await getUser.generateLoggedInUser(event.email, event.password);
    await getUser.generateUserCollection(event.email);
    emit(
      UserLoggedIn(user: event.email),
    );
  }

  void _onLogout(Logout event, Emitter<LoginState> emit) async {
    UserRepoImp genLogout = UserRepoImp();
    await genLogout.generateLoggedOutUser();
  }
}
