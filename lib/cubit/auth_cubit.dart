import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_auth_tist/app_servis_clint/firebase_clint.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
void authWithPhone(String phoneNumber)async{
  try{
    emit(AuthLoadingState());
    FireBaseClint().loginWithPhoneNumber(phoneNumber);
    emit(AuthSuccessState());
  }on FirebaseAuthException catch(e){
    emit(AuthErrorState(e.message!));
  }
}
sendOTP(String otpCode)async{
 try{
   emit(OtpLoadingState());
  await FireBaseClint().sendOtp(otpCode);
   emit(OTPSuccessState());
 }on FirebaseAuthException catch(error){
   emit(OtpErrorState(error.message!));
   print(error.toString());
 }
}
}
