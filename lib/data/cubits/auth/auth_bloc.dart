// import 'package:bloc/bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final FirebaseAuth _firebaseAuth;
//
//   AuthBloc({required FirebaseAuth firebaseAuth})
//       : _firebaseAuth = firebaseAuth,
//         super(AuthInitial()) {
//     on<LoginRequested>(_onLoginRequested);
//     on<LogoutRequested>(_onLogoutRequested);
//   }
//
//   Future<void> _onLoginRequested(
//       LoginRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//         email: event.email,
//         password: event.password,
//       );
//       emit(AuthAuthenticated());
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }
//
//   Future<void> _onLogoutRequested(
//       LogoutRequested event, Emitter<AuthState> emit) async {
//     await _firebaseAuth.signOut();
//     emit(AuthInitial());
//   }
// }
