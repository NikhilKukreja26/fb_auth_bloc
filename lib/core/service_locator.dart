import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../repositories/auth_repository.dart';
import '../repositories/profile_repository.dart';

final GetIt serviceLocator = GetIt.instance;

void setUpServices() {
  serviceLocator.registerSingleton<AuthRepository>(AuthRepository(
    firebaseFirestore: FirebaseFirestore.instance,
    firebaseAuth: FirebaseAuth.instance,
  ));
  serviceLocator.registerSingleton<ProfileRepository>(ProfileRepository(
    firebaseFirestore: FirebaseFirestore.instance,
  ));
}
