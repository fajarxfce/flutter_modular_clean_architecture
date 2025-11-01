# BlocWithEffect - MVI Pattern for Flutter

A scalable architecture pattern that separates **State** (UI representation) from **Effects** (single-shot events).

## 🎯 Problem

In standard flutter_bloc, developers often misuse state for one-time events:

```dart
// ❌ BAD: Using state for single-shot events
sealed class LoginState {}
class LoginIdle extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

// Problem: When you emit LoginError, it REPLACES the previous state!
// If user was on LoginLoading, it's gone. Can't show error dialog while maintaining loading state.
```

## ✅ Solution: BlocWithEffect

Separate concerns:

- **State** = Current UI representation (idle, loading, success)
- **Effect** = Single-shot events (navigation, dialogs, snackbars)

```dart
// ✅ GOOD: State for UI, Effect for events
sealed class LoginState {
  // State: What UI looks like
}
class LoginIdle extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess(this.user);
}

sealed class LoginEffect {
  // Effect: One-time events
}
class ShowErrorDialog extends LoginEffect {
  final String message;
  ShowErrorDialog(this.message);
}
class NavigateToDashboard extends LoginEffect {}
```

---

## 📦 Components

### 1. `BlocWithEffect<Event, State, Effect>`

Base class for your Bloc. Extends `Bloc<Event, State>` and adds `effects` stream.

**Usage:**

```dart
class LoginBloc extends BlocWithEffect<LoginEvent, LoginState, LoginEffect> {
  LoginBloc() : super(LoginIdle());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitted) {
      // Emit state changes
      yield LoginLoading();

      try {
        final user = await _authRepo.login(event.email, event.password);
        yield LoginSuccess(user);

        // ✅ Emit effect (single-shot event)
        emitEffect(NavigateToDashboard());
      } catch (e) {
        // State goes back to idle
        yield LoginIdle();

        // ✅ Effect shows error dialog (doesn't replace state!)
        emitEffect(ShowErrorDialog(e.toString()));
      }
    }
  }
}
```

### 2. `BlocEffectConsumer<Bloc, State, Effect>`

Widget that handles both state changes (UI rebuilds) and effects (one-time events).

**Usage:**

```dart
BlocEffectConsumer<LoginBloc, LoginState, LoginEffect>(
  // Builder: Rebuild UI based on state
  builder: (context, state) {
    if (state is LoginLoading) {
      return CircularProgressIndicator();
    }
    if (state is LoginSuccess) {
      return Text('Welcome ${state.user.name}');
    }
    return LoginForm();
  },

  // Effect Listener: Handle single-shot events
  effectListener: (context, effect) {
    if (effect is ShowErrorDialog) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text(effect.message),
        ),
      );
    }

    if (effect is NavigateToDashboard) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  },
)
```

### 3. `BlocEffectListener<Bloc, Effect>`

Widget that ONLY handles effects, without rebuilding on state changes.

**Usage:**

```dart
BlocEffectListener<LoginBloc, LoginEffect>(
  listener: (context, effect) {
    if (effect is ShowSuccessSnackbar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(effect.message)),
      );
    }
  },
  child: LoginForm(), // Won't rebuild when state changes
)
```

---

## 🏗️ Full Example: Login Feature

### 1. Define State (UI Representation)

```dart
// login_state.dart
enum LoginStatus { initial, loading, success }

class LoginUiState {
  final LoginStatus status;
  final String email;

  const LoginUiState({
    required this.status,
    this.email = '',
  });

  factory LoginUiState.initial() => const LoginUiState(
    status: LoginStatus.initial,
  );

  LoginUiState copyWith({
    LoginStatus? status,
    String? email,
  }) {
    return LoginUiState(
      status: status ?? this.status,
      email: email ?? this.email,
    );
  }
}
```

### 2. Define Effect (Single-Shot Events)

```dart
// login_effect.dart
sealed class LoginEffect {
  const LoginEffect();
}

class ShowErrorDialog extends LoginEffect {
  final String message;
  const ShowErrorDialog(this.message);
}

class ShowSuccessSnackbar extends LoginEffect {
  final String message;
  const ShowSuccessSnackbar(this.message);
}

class NavigateToRegister extends LoginEffect {
  const NavigateToRegister();
}

class NavigateToDashboard extends LoginEffect {
  const NavigateToDashboard();
}
```

### 3. Define Events

```dart
// login_event.dart
abstract class LoginEvent {
  const LoginEvent();
}

class OnLoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  const OnLoginSubmittedEvent({
    required this.email,
    required this.password,
  });
}

class OnNavigateToRegisterEvent extends LoginEvent {
  const OnNavigateToRegisterEvent();
}
```

### 4. Create Bloc

```dart
// login_bloc.dart
import 'package:shared/shared.dart';

@injectable
class LoginBloc extends BlocWithEffect<LoginEvent, LoginUiState, LoginEffect> {
  final AuthRepository _authRepo;

  LoginBloc(this._authRepo) : super(LoginUiState.initial()) {
    on<OnLoginSubmittedEvent>(_onLoginSubmitted);
    on<OnNavigateToRegisterEvent>(_onNavigateToRegister);
  }

  Future<void> _onLoginSubmitted(
    OnLoginSubmittedEvent event,
    Emitter<LoginUiState> emit,
  ) async {
    // 1. Show loading state
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      // 2. API call
      final user = await _authRepo.login(event.email, event.password);

      // 3. Update state to success
      emit(state.copyWith(
        status: LoginStatus.success,
        email: event.email,
      ));

      // 4. ✅ Emit effects (won't replace state!)
      emitEffect(const ShowSuccessSnackbar('Login successful!'));
      emitEffect(const NavigateToDashboard());

    } catch (e) {
      // 5. Revert to initial state
      emit(state.copyWith(status: LoginStatus.initial));

      // 6. ✅ Show error dialog (state is still initial!)
      emitEffect(ShowErrorDialog(e.toString()));
    }
  }

  Future<void> _onNavigateToRegister(
    OnNavigateToRegisterEvent event,
    Emitter<LoginUiState> emit,
  ) async {
    // ✅ Just emit effect, no state change needed
    emitEffect(const NavigateToRegister());
  }
}
```

### 5. Use in UI

```dart
// login_page.dart
@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginBloc>(),
      child: BlocEffectConsumer<LoginBloc, LoginUiState, LoginEffect>(
        // UI Builder: Rebuild based on state
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                // Email field
                TextField(/* ... */),

                // Password field
                TextField(/* ... */),

                // Sign In Button - disabled when loading
                AppButton.primary(
                  text: 'Sign In',
                  onPressed: state.status == LoginStatus.loading
                      ? null
                      : () {
                          context.read<LoginBloc>().add(
                            OnLoginSubmittedEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        },
                  isLoading: state.status == LoginStatus.loading,
                ),

                // Register Button
                AppButton.secondary(
                  text: 'Go to Register',
                  onPressed: () {
                    context.read<LoginBloc>().add(
                      const OnNavigateToRegisterEvent(),
                    );
                  },
                ),
              ],
            ),
          );
        },

        // Effect Listener: Handle one-time events
        effectListener: (context, effect) {
          // Navigation
          if (effect is NavigateToRegister) {
            context.router.pushNamed('/register');
          }
          if (effect is NavigateToDashboard) {
            context.router.pushNamed('/dashboard');
          }

          // Dialogs
          if (effect is ShowErrorDialog) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Error'),
                content: Text(effect.message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }

          // Snackbars
          if (effect is ShowSuccessSnackbar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(effect.message)),
            );
          }
        },
      ),
    );
  }
}
```

---

## 🎨 Benefits

### 1. Clear Separation of Concerns

```dart
// ✅ State: What the UI looks like
LoginIdle()         // Show form
LoginLoading()      // Show loading spinner
LoginSuccess(user)  // Show user data

// ✅ Effect: What happens once
ShowErrorDialog('Invalid credentials')
NavigateToDashboard()
ShowSuccessSnackbar('Login successful!')
```

### 2. No State Replacement Issues

```dart
// ❌ OLD WAY (flutter_bloc only):
emit(LoginError('Invalid credentials')); // Replaces previous state!
// Now you lost LoginLoading state, can't show both loading + error

// ✅ NEW WAY (BlocWithEffect):
emit(state.copyWith(status: LoginStatus.initial)); // State preserved
emitEffect(ShowErrorDialog('Invalid credentials')); // Separate stream!
// State and effect are independent!
```

### 3. Testability

```dart
test('login failure shows error dialog', () async {
  // Arrange
  final bloc = LoginBloc(mockAuthRepo);
  when(() => mockAuthRepo.login(any(), any()))
      .thenThrow(Exception('Invalid credentials'));

  // Act
  bloc.add(OnLoginSubmittedEvent(email: 'test@test.com', password: '123'));

  // Assert state
  await expectLater(
    bloc.stream,
    emitsInOrder([
      isA<LoginLoading>(),
      isA<LoginIdle>(),
    ]),
  );

  // Assert effect
  await expectLater(
    bloc.effects,
    emits(isA<ShowErrorDialog>()
        .having((e) => e.message, 'message', contains('Invalid'))),
  );
});
```

### 4. Scalability

Every feature can use this pattern:

- `packages/features/login/presentation/` - Login with effects
- `packages/features/product/presentation/` - Product with effects
- `packages/features/profile/presentation/` - Profile with effects

All using the same `BlocWithEffect` from `packages/shared/`!

---

## 📚 When to Use State vs Effect

### Use **State** for:

- ✅ UI representation (loading, success, error **data**)
- ✅ Form validation state
- ✅ List/grid data
- ✅ Filters, sorting
- ✅ Anything that needs to **persist** and **rebuild UI**

### Use **Effect** for:

- ✅ Navigation (push, pop, replace)
- ✅ Dialogs (show, dismiss)
- ✅ Snackbars, toasts
- ✅ Vibration, sound effects
- ✅ Sharing, opening URLs
- ✅ Anything that happens **once** and **doesn't rebuild UI**

---

## 🚀 Migration from flutter_bloc

### Before (flutter_bloc only):

```dart
// ❌ Mixing state and events
sealed class LoginState {}
class LoginIdle extends LoginState {}
class LoginLoading extends LoginState {}
class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginIdle());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    yield LoginLoading();
    try {
      await login();
      yield LoginSuccess();
      // ❌ Can't navigate here, already emitted state
    } catch (e) {
      yield LoginError(e.toString());
      // ❌ State is replaced, can't show error + maintain loading
    }
  }
}
```

### After (BlocWithEffect):

```dart
// ✅ Separate state and effects
sealed class LoginState {}
class LoginIdle extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}

sealed class LoginEffect {}
class ShowError extends LoginEffect {
  final String message;
  ShowError(this.message);
}
class NavigateToDashboard extends LoginEffect {}

class LoginBloc extends BlocWithEffect<LoginEvent, LoginState, LoginEffect> {
  LoginBloc() : super(LoginIdle());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    yield LoginLoading();
    try {
      await login();
      yield LoginSuccess();
      // ✅ Navigate without replacing state
      emitEffect(NavigateToDashboard());
    } catch (e) {
      yield LoginIdle();
      // ✅ Show error without replacing state
      emitEffect(ShowError(e.toString()));
    }
  }
}
```

---

## 💡 Tips

1. **Keep Effects Simple**: One effect = one action (show dialog, navigate, etc.)
2. **Use Sealed Classes**: `sealed class LoginEffect {}` for type safety
3. **Test Both Streams**: Test `bloc.stream` for state, `bloc.effects` for effects
4. **Don't Emit Effects in Constructor**: Only emit in event handlers
5. **Close Stream**: `BlocWithEffect` automatically closes effects stream

---

## 🔗 References

- Inspired by MVI (Model-View-Intent) pattern from Android/Jetpack Compose
- Similar to Redux side effects, Elm commands, Orbit MVI
- Follows clean architecture principles

---

## 📝 Example Projects

Check these features for real-world examples:

- `packages/features/login/presentation/` - Login with navigation effects
- `packages/features/product/presentation/` - CRUD with snackbar effects
- `packages/features/profile/presentation/` - Update with dialog effects
