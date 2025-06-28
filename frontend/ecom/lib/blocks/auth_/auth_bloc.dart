import 'package:bloc/bloc.dart';
import 'package:ecom/repository/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.login(event.email, event.password);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', true);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.register(event.name, event.email, event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('loggedIn');
      emit(AuthLoggedOut());
    });

    on<CheckLoginStatus>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('loggedIn') ?? false;
      if (isLoggedIn) {
        emit(AuthSuccess());
      } else {
        emit(AuthLoggedOut());
      }
    });
  }
}
