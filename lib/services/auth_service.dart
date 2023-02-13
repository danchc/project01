import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  //Google Sign-In
  googleSignIn() async {

    //inizia processo di accesso
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //salva i dati necessari
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    //creiamo le nuove credenziali
    final credentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //accediamo
    return await FirebaseAuth.instance.signInWithCredential(credentials);
  }

}
