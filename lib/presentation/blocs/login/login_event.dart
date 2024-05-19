import 'package:equatable/equatable.dart';
import './login_state.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventLogin extends LoginEvent {
  final bool remembermeValue;
  final String username;
  final String password;

  const LoginEventLogin({
    required this.remembermeValue,
    required this.username,
    required this.password,
  });
}

class LoginGetRememberedUser extends LoginEvent {

}

class LoginEmitInitial extends LoginEvent {

}

class LoginSetState extends LoginEvent {
  final LoginState state;
  const LoginSetState(this.state);
}
