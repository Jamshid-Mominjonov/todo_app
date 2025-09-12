import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository.dart';

abstract class SignOutState {}

class SignOutInitial extends SignOutState {}

class SignOutLoading extends SignOutState {}

class SignOutSuccess extends SignOutState {}

class SignOutError extends SignOutState {
  final String message;

  SignOutError(this.message);
}

class SignOutNotifier extends StateNotifier<SignOutState> {
  final AuthRepository authRepository;

  SignOutNotifier(this.authRepository) : super(SignOutInitial());

  Future<void> signOut() async {
    state = SignOutLoading();
    try {
      await authRepository.signOut();
      state = SignOutSuccess();
    } catch (e) {
      state = SignOutError(e.toString());
    }
  }
}
