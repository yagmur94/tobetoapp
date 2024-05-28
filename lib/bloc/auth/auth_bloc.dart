import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobetoapp/bloc/auth/auth_event.dart';
import 'package:tobetoapp/bloc/auth/auth_state.dart';
import 'package:tobetoapp/repository/auth_repo.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthAppStarted()) {
    on<AuthLogin>(_loginUser);
    on<AuthSignUp>(_signUp);
    on<AuthGoogleSignIn>(_onGoogleSignIn);
    on<AuthStateChanged>(_authStateChanged);
    on<AuthLogOut>(_logoutUser);


    _checkAuthState();
  }

  void _checkAuthState() async {
    final user = _authRepository.getCurrentUser();
    if (user != null) {
      final role = await _authRepository.getUserRole(user.uid);
      add(AuthStateChanged(user: user, role: role));
    } else {
      add(AuthStateChanged(user: null, role: null));
    }
  }

  void _authStateChanged(AuthStateChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(AuthSuccess(id: event.user!.uid, role: event.role));
    } else {
      emit(Unauthenticated());
    }
  }

  void _loginUser(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final loginUser =
        await _authRepository.loggedInUser(event.email, event.password);

    if (loginUser is User) {
      User user = loginUser;
      final role = await _authRepository.getUserRole(user.uid);
      emit(AuthSuccess(id: user.uid, role: role));
    } else {
      emit(AuthFailure(message: 'Login failed'));
    }
  }

  void _signUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final signUpUser = await _authRepository.signUp(
        event.name, event.lastName, event.email, event.password);

    if (signUpUser is User) {
      User user = signUpUser;
      final role = await _authRepository.getUserRole(user.uid);
      emit(AuthSuccess(id: user.uid, role: role));
    } else {
      emit(AuthFailure(message: 'Sign up failed'));
    }
  }

  void _onGoogleSignIn(AuthGoogleSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      User? user = await _authRepository.signInWithGoogle();
      if (user != null) {
        final role = await _authRepository.getUserRole(user.uid);
        emit(AuthSuccess(id: user.uid, role: role));
      } else {
        emit(AuthFailure(message: 'Google Sign in failed'));
      }
    } catch (e) {
      emit(AuthFailure(message:e.toString()));
    }
  }

  void _logoutUser(AuthLogOut event, Emitter<AuthState> emit) async {
    await _authRepository.logout();
    emit(Unauthenticated());
  }
}

