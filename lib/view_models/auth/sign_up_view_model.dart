import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final User? user;
  SignUpSuccess(this.user);
}

class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}

class SignUpNotifier extends StateNotifier<SignUpState> {
  final AuthRepository authRepository;

  SignUpNotifier(this.authRepository) : super(SignUpInitial());

  Future<void> signUp(String email, String password,
      String confirmPassword,) async {
    if (password != confirmPassword) {
      state = SignUpError("Passwords don't match");
      return;
    }
    state = SignUpLoading();
    try {
      final user = await authRepository.signUpUser(email, password);
      state = SignUpSuccess(user);
    } catch (e) {
      state = SignUpError(e.toString());
    }
  }
}