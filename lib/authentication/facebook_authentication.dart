import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final UserCredential authResult =
            await _auth.signInWithCredential(facebookAuthCredential);
        final User? user = authResult.user;
        return user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOutFacebook() async {
    await FacebookAuth.instance.logOut();
    print("User Signed Out");
  }
}