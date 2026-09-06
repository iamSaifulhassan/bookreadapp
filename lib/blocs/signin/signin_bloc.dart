import 'package:flutter_bloc/flutter_bloc.dart';
import 'signin_event.dart';
import 'signin_state.dart';
import '../../repositories/user_repository.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final UserRepository userRepository;
  SigninBloc(this.userRepository) : super(SigninInitial()) {
    on<SigninSubmitted>(_onSigninSubmitted);
    on<SigninGoogleSubmitted>(_onSigninGoogleSubmitted);
  }

  Future<void> _onSigninSubmitted(
    SigninSubmitted event,
    Emitter<SigninState> emit,
  ) async {
    emit(SigninLoading());
    final result = await userRepository.signIn(
      email: event.email,
      password: event.password,
    );
    if (result.success) {
      emit(SigninSuccess());
    } else {
      emit(SigninFailure(result.message ?? 'Invalid email or password.'));
    }
  }

  Future<void> _onSigninGoogleSubmitted(
    SigninGoogleSubmitted event,
    Emitter<SigninState> emit,
  ) async {
    emit(SigninLoading());
    final result = await userRepository.signInWithGoogle();
    if (result.success) {
      emit(SigninSuccess(viaGoogle: true));
    } else {
      emit(SigninFailure(result.message ?? 'Google sign-in failed.', viaGoogle: true));
    }
  }
}
