
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<User> register(String email, String password) async{
   final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
   return credential.user!;
  }

  static Future<User> login(String email, String password) async {
    final userLogged = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userLogged.user!;
  }

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );

    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> logout(){
    return _auth.signOut();
  }
}