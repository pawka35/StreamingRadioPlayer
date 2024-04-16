import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String verifyId = "";

  static Future sentOtp({required String phoneNumber}) async {
    await _firebaseAuth.verifyPhoneNumber(
      timeout: const Duration(seconds: 30),
      phoneNumber: '+${phoneNumber}',
      verificationCompleted: (PhoneAuthCredential credential) => {},
      verificationFailed: (FirebaseAuthException e) => {},
      codeSent: (String verificationId, int? resendToken) async {
        verifyId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) => {},
    );
  }

  static Future<({String message, User? user})> loginWithOtp(
      {required String otp}) async {
    final credential =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);

    try {
      final user = await _firebaseAuth.signInWithCredential(credential);
      if (user.user != null) {
        return (message: 'Success', user: user.user);
      } else {
        return (message: 'Error on Otp login', user: null);
      }
    } on FirebaseAuthException catch (e) {
      return (message: e.message.toString(), user: null);
    } catch (e) {
      return (message: e.toString(), user: null);
    }
  }

  static Future logout() async {
    await _firebaseAuth.signOut();
  }

  static Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }
}
