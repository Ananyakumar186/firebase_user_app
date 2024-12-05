
import 'package:firebase_auth/firebase_auth.dart';

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

  static Future<void> logout(){
    return _auth.signOut();
  }
}