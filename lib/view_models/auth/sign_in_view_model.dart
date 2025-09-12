import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final User? user;
  SignInSuccess(this.user);
}

class SignInError extends SignInState {
  final String message;
  SignInError(this.message);
}

class SignInNotifier extends StateNotifier<SignInState> {
  final AuthRepository authRepository;

  SignInNotifier(this.authRepository) : super(SignInInitial());

  Future<void> signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      state = SignInError('Fill all fields');
      return;
    }
    state = SignInLoading();
    try {
      final user = await authRepository.signInUser(email, password);
      state = SignInSuccess(user);
    } catch (e) {
      state = SignInError(e.toString());
    }
  }
}
