import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class LoginSignUpState extends Equatable {
  const LoginSignUpState();

  @override
  List<Object> get props => [];
}

class LoginSignUpStateInitial extends LoginSignUpState {
  @override
  List<Object> get props => [];
}

class LoginSignUpStateCheckingIpAddresses extends LoginSignUpState {
  @override
  List<Object> get props => [];
}

class LoginSignUpStateServerIpAddressFound extends LoginSignUpState {
  @override
  List<Object> get props => [];
}

class LoginSignUpStateServerIpAddressNotFound extends LoginSignUpState {
  @override
  List<Object> get props => [];
}