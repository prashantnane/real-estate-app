// ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'package:ebroker/data/Repositories/auth_repository.dart';
// import 'package:ebroker/utils/hive_utils.dart';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_constant.dart';
import '../../../utils/auditFields.dart';
import '../../../utils/hive_utils.dart';
import '../../Repositories/auth_repository.dart';
import '../../dataservices/firebase/createNewEntity.dart';
import '../../model/generic/api_response.dart';
import '../../model/user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  // final bool isProfileCompleted;

  LoginSuccess(// {
      // required this.isProfileCompleted,
      // }
      );
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
      HiveUtils.setUserIsAuthenticated();
      HiveUtils.setUserIsNotNew();

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

      emit(LoginSuccess());
      log('Login successful');
    } on FirebaseAuthException catch (e) {
      String errorMsg = '';

      if (e.code == 'user-not-found') {
        errorMsg = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        errorMsg = 'Invalid Email ID or Password.';
      } else if (e.code == 'invalid-email') {
        errorMsg = 'Email ID not found.';
      } else {
        errorMsg = 'Please check Email ID or password once.';
      }
      log('Login failed: ${e.code}');
      emit(LoginFailure(errorMsg));
    }
  }

  void signUp(
      {required String email, required String password, required String phone, required String name, required String rera, required String address}) async {
    try {
      emit(LoginInProgress());

      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // User? user = userCredential.user;
      // if (user != null && !user.emailVerified) {
      //   await user.sendEmailVerification();
      //   print('Verification email sent to ${user.email}');
      // }

      UserModel? signupUser =
      UserModel(
        id: userCredential.user?.uid,
        name: name,
        email: email,
        mobile: phone,
        address: address,
        rera: rera,
        isActive: 1,
      );

      ApiResponse<UserModel> response = await createNewUser(signupUser);
      (response.status == "success") ? {
        // Navigator.pop(context)
      log("Tis is create user response from success: ${response.status}")
      } : {
      };
      log("THis is create user response : ${response.status}");

      // if (user != null) {
      //   await _firebaseFirestore.collection('usersAdmin').doc(user.uid).set({
      //     'uid': user.uid,
      //     'email': user.email,
      //     'role': _selectedRole,
      //     'isLoggedIn': false,
      //     'timestamp': FieldValue.serverTimestamp()
      //   });
      // }

      print('User created successfully');

      HiveUtils.setUserIsAuthenticated();
      HiveUtils.setUserIsNotNew();

      emit(LoginSuccess());
      log('Login successful');
    } on FirebaseAuthException catch (e) {
      String errorMsg = '';

      if (e.code == 'weak-password') {
        errorMsg = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMsg = 'The email address is already in use.';
      } else if (e.code == 'invalid-email') {
        errorMsg = 'Invalid email address.';
      }
      log('Login failed: $errorMsg');
      emit(LoginFailure(errorMsg));

    }
  }

  Future<ApiResponse<UserModel>> createNewUser(UserModel inputLoginUser) async {
    try {
      if(inputLoginUser.id !='' || inputLoginUser.id !=null || inputLoginUser.id!.isNotEmpty ){
        ApiResponse<DocumentSnapshot<Map<String, dynamic>>> response  = await createEntityRecordWithID(FirebaseCollection.users,inputLoginUser.id??"",inputLoginUser.toJson() ) ;
        if(response.status=="success"){
          addAuditFields(FirebaseCollection.users, response.data!.id);
          UserModel returnedLoginUser = UserModel.fromSnapshot(response.data!);
          return ApiResponse(status: "success", message: "success",data:returnedLoginUser );
        }
        else{
          return ApiResponse(status: "unSuccessful", message: "LoginUser Creation Error",data:null );
        }
      }
      return ApiResponse(status: "unSuccessful", message: "LoginUser Creation Error",data:null );
    }catch (e) {
      return ApiResponse(status: "error", message: "Failed with error" ,data: null);
    }
  }

  void logout() async {
    await _auth.signOut();
    log('Logout successful');
    emit(LoginInitial());
  }
}
