import 'package:firebase_auth/firebase_auth.dart';
import 'package:mcproject/model/customuser.dart';

class AuthService {

  //istanza di FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creiamo user con Firebase
  CustomUser? _userFirebase(User? user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  //rappresentiamo lo stream dello user
  Stream<CustomUser?> get user {
    return _auth.authStateChanges()
        .map(_userFirebase);
  }

  //accesso con e-mail e password

  //registrazione con e-mail e password

  //logout


}
