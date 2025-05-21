import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';
import '../../repositories/user_repository.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository userRepository;
  SignupBloc(this.userRepository) : super(SignupInitial()) {
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  Future<void> _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());
    try {
      final isUnique = await userRepository.isEmailUnique(event.email);
      if (!isUnique) {
        emit(SignupFailure('Email already exists.'));
        return;
      }
      final success = await userRepository.createUser(
        email: event.email,
        phone: event.phone,
        country: event.country,
        userType: event.userType,
        password: event.password,
      );
      if (success) {
        emit(SignupSuccess());
      } else {
        emit(SignupFailure('Sign-up failed. Try again.'));
      }
    } catch (e) {
      if (e.toString().contains('email-already-exists')) {
        emit(SignupFailure('Email already exists.'));
      } else {
        emit(SignupFailure('Sign-up failed. Try again.'));
      }
    }
  }
}
