import 'package:firebase_auth/firebase_auth.dart';
import '../remote/auth_remote_data_source.dart';

class AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepository(this.authRemoteDataSource);

  Future<User?> signUpUser(String email, String password) {
    return authRemoteDataSource.signUpUser(email: email, password: password);
  }

  Future<User?> signInUser(String email, String password) {
    return authRemoteDataSource.signInUser(email: email, password: password);
  }

  Future<void> signOut() {
    return authRemoteDataSource.signOut();
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}