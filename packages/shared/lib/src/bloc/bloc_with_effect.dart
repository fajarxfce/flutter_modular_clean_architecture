import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Base class for Bloc that supports side effects (single-shot events).
///
/// This pattern follows MVI architecture where:
/// - **State**: Represents UI state (loading, success, error data)
/// - **Effect**: Represents single-shot events (show dialog, navigate, show snackbar)
///
/// Example usage:
/// ```dart
/// // 1. Define your states
/// sealed class LoginState {}
/// class LoginIdle extends LoginState {}
/// class LoginLoading extends LoginState {}
/// class LoginSuccess extends LoginState {
///   final User user;
///   LoginSuccess(this.user);
/// }
///
/// // 2. Define your effects (single-shot events)
/// sealed class LoginEffect {}
/// class ShowErrorDialog extends LoginEffect {
///   final String message;
///   ShowErrorDialog(this.message);
/// }
/// class NavigateToDashboard extends LoginEffect {}
///
/// // 3. Create your bloc
/// class LoginBloc extends BlocWithEffect<LoginEvent, LoginState, LoginEffect> {
///   LoginBloc() : super(LoginIdle());
///
///   @override
///   Stream<LoginState> mapEventToState(LoginEvent event) async* {
///     if (event is LoginSubmitted) {
///       yield LoginLoading();
///       try {
///         final user = await _authRepo.login(event.email, event.password);
///         yield LoginSuccess(user);
///         emitEffect(NavigateToDashboard()); // Single-shot event!
///       } catch (e) {
///         yield LoginIdle();
///         emitEffect(ShowErrorDialog(e.toString())); // Won't replace state!
///       }
///     }
///   }
/// }
/// ```
abstract class BlocWithEffect<Event, State, Effect> extends Bloc<Event, State> {
  BlocWithEffect(super.initialState);

  final _effectController = StreamController<Effect>.broadcast();

  /// Stream of side effects (single-shot events).
  /// Subscribe to this in your UI to handle one-time events like navigation,
  /// showing dialogs, snackbars, etc.
  Stream<Effect> get effects => _effectController.stream;

  /// Emit a side effect (single-shot event).
  /// This won't replace the current state, it's a separate stream.
  ///
  /// Example:
  /// ```dart
  /// emitEffect(ShowErrorDialog('Invalid credentials'));
  /// emitEffect(NavigateToHome());
  /// ```
  void emitEffect(Effect effect) {
    if (!_effectController.isClosed) {
      _effectController.add(effect);
    }
  }

  @override
  Future<void> close() {
    _effectController.close();
    return super.close();
  }
}
