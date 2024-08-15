// ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'package:ebroker/data/Repositories/auth_repository.dart';
// import 'package:ebroker/utils/hive_utils.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/hive_utils.dart';
import '../../Repositories/auth_repository.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  final bool isProfileCompleted;

  LoginSuccess({
    required this.isProfileCompleted,
  });
}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final AuthRepository _authRepository = AuthRepository();
  bool isProfileIsCompleted = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login({required String email, required String password}) async {
    try {
      emit(LoginInProgress());
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ///Storing data to local database {HIVE}
      // HiveUtils.setJWT(result['token']);
      //
      // if (result['data']['name'] == "" && result['data']['email'] == "") {
      //   HiveUtils.setProfileNotCompleted();
      //   isProfileIsCompleted = false;
      //   var data = result['data'];
      //   data['countryCode'] = countryCode;
      //   HiveUtils.setUserData(data);
      // } else {
      //   isProfileIsCompleted = true;
      //   var data = result['data'];
      //   data['countryCode'] = countryCode;
      //   HiveUtils.setUserData(data);
      // }

      emit(LoginSuccess(isProfileCompleted: isProfileIsCompleted));
      log('Login successful');
    } on FirebaseAuthException catch (e) {
      String errorMsg = '';

      if (e.code == 'user-not-found') {
        errorMsg = 'No user found for that email.';
        print("Error Msg while authentication: $errorMsg");
      } else if (e.code == 'wrong-password') {
        errorMsg = 'Wrong password provided for that user.';
        print("Error Msg while authentication: $errorMsg");
      } else if (e.code == 'invalid-email') {
        errorMsg = 'Email ID not found.';
        print("Error Msg while authentication: $errorMsg");
      } else if (e.code == 'channel-error') {
        errorMsg = 'Invalid Email ID or Password';
        print("Error Msg while authentication: $errorMsg");
      }
      log('Login failed: $e');
      emit(LoginFailure(e.toString()));
    }
  }

  void logout() async {
    await _auth.signOut();
    log('Logout successful');
    emit(LoginInitial());
  }
}
