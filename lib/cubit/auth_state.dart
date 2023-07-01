part of 'auth_cubit.dart';


abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoadingState extends AuthState {}
class OtpLoadingState extends AuthState {}
class AuthSuccessState extends AuthState {}
class OTPSuccessState extends AuthState {}
class AuthErrorState extends AuthState {
  String message;
  AuthErrorState(this.message);
}
class OtpErrorState extends AuthState {
  String message;
  OtpErrorState(this.message);
}
