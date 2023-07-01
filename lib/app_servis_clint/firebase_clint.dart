import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FireBaseClint {
  final auth = FirebaseAuth.instance;
  late String verificationId;

  void loginWithPhoneNumber(String phoneNumber) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print("verificationCompleted");
    await auth.signInWithCredential(credential);
  }

  void verificationFailed(FirebaseAuthException exception) {
    print(exception.toString());
    if (exception.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
  }

  void codeAutoRetrievalTimeout(String verificationId) {}

  Future<void> sendOtp(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    await auth.signInWithCredential(credential);
  }

  Future<void>logOut()async{
    await auth.signOut();
  }
}
