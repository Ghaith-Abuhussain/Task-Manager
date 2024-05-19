import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginStateInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginStateGetRemembered extends LoginState {
  final String username;
  final String password;

  const LoginStateGetRemembered({required this.username, required this.password});

  @override
  List<Object> get props => [];
}

class LoginStateRememberedDone extends LoginState {

  const LoginStateRememberedDone();

  @override
  List<Object> get props => [];
}

class LoginStateAttemptLogin extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginStateLoginFailure extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginStateLoginSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class SetStateFirst extends LoginState {
  @override
  List<Object> get props => [];
}

class SetStateSecond extends LoginState {
  @override
  List<Object> get props => [];
}
