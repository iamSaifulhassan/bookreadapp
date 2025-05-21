import 'package:flutter_bloc/flutter_bloc.dart';
import 'signin_event.dart';
import 'signin_state.dart';
import '../../repositories/user_repository.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final UserRepository userRepository;
  SigninBloc(this.userRepository) : super(SigninInitial()) {
    on<SigninSubmitted>(_onSigninSubmitted);
  }

  Future<void> _onSigninSubmitted(
    SigninSubmitted event,
    Emitter<SigninState> emit,
  ) async {
    emit(SigninLoading());
    final success = await userRepository.signIn(
      email: event.email,
      password: event.password,
    );
    if (success) {
      emit(SigninSuccess());
    } else {
      emit(SigninFailure('Invalid email or password.'));
    }
  }
}
