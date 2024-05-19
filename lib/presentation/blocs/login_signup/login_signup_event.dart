import 'package:equatable/equatable.dart';
import './login_signup_state.dart';

abstract class LoginSignUpEvent extends Equatable {
  const LoginSignUpEvent();

  @override
  List<Object> get props => [];
}

class LoginSignUpEventFindServerIpAddress extends LoginSignUpEvent {

  @override
  List<Object> get props => [];
}

class LoginSignUpEventRetry extends LoginSignUpEvent {

  @override
  List<Object> get props => [];
}