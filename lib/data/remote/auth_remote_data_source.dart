import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  static final auth = FirebaseAuth.instance;

  Future<User?> signUpUser({required String email, required String password}) async {
    var authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final User? firebaseAuth = authResult.user;
    return firebaseAuth;
  }

   Future<User?> signInUser({required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    final User? firebaseAuth = auth.currentUser;
    return firebaseAuth;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}