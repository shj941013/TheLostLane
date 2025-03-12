import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final UserCredential authResult =
            await _auth.signInWithCredential(facebookAuthCredential);
        final User? user = authResult.user;
        return user;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> signOutFacebook() async {
    await FacebookAuth.instance.logOut();
    print("User Signed Out");
  }
}
