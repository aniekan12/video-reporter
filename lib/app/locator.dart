import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frsc_presentation/core/services/auth.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

//ignore: missing_return
Future<void> setupLocator() async {
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton<AuthService>(
      () => AuthService(FirebaseAuth.instance));
}
