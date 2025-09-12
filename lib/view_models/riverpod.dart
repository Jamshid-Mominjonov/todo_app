import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/remote/auth_remote_data_source.dart';
import 'package:todo_app/data/local/hive_local_data_source.dart';
import 'package:todo_app/data/repositories/auth_repository.dart';
import 'package:todo_app/view_models/task/task_view_model.dart';
import '../data/repositories/task_repository.dart';
import 'auth/sign_in_view_model.dart';
import 'auth/sign_out_view_model.dart';
import 'auth/sign_up_view_model.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref){
  return AuthRemoteDataSource();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepository(remoteDataSource);
});

final signUpNotifierProvider = StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignUpNotifier(authRepository);
});

final signInNotifierProvider = StateNotifierProvider<SignInNotifier, SignInState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInNotifier(authRepository);
});

final signOutNotifierProvider = StateNotifierProvider<SignOutNotifier, SignOutState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignOutNotifier(authRepository);
});


final hiveLocalDataSourceProvider = Provider<HiveLocalDataSource>((ref) {
  return HiveLocalDataSource();
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(hiveLocalDataSource: ref.watch(hiveLocalDataSourceProvider));
});

final taskNotifierProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  return TaskNotifier(taskRepository: ref.watch(taskRepositoryProvider));
});