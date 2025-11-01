import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_with_effect.dart';

/// A widget that listens to both state changes and effects from a [BlocWithEffect].
///
/// This is similar to [BlocListener] but handles both:
/// - **State changes**: Rebuilds UI using [builder]
/// - **Effects (side effects)**: Handles one-time events using [effectListener]
///
/// Example:
/// ```dart
/// BlocEffectConsumer<LoginBloc, LoginState, LoginEffect>(
///   builder: (context, state) {
///     if (state is LoginLoading) {
///       return CircularProgressIndicator();
///     }
///     if (state is LoginSuccess) {
///       return Text('Welcome ${state.user.name}');
///     }
///     return LoginForm();
///   },
///   effectListener: (context, effect) {
///     if (effect is ShowErrorDialog) {
///       showDialog(
///         context: context,
///         builder: (_) => AlertDialog(
///           title: Text('Error'),
///           content: Text(effect.message),
///         ),
///       );
///     }
///     if (effect is NavigateToDashboard) {
///       Navigator.pushReplacementNamed(context, '/dashboard');
///     }
///   },
/// )
/// ```
class BlocEffectConsumer<B extends BlocWithEffect<dynamic, S, E>, S, E>
    extends StatefulWidget {
  const BlocEffectConsumer({
    super.key,
    required this.builder,
    required this.effectListener,
    this.bloc,
    this.buildWhen,
    this.listenWhen,
  });

  /// The [BlocWithEffect] instance. If not provided, will use [BlocProvider.of].
  final B? bloc;

  /// Builder function for UI based on state.
  final Widget Function(BuildContext context, S state) builder;

  /// Listener function for side effects (single-shot events).
  final void Function(BuildContext context, E effect) effectListener;

  /// Optional condition to determine when to rebuild.
  final bool Function(S previous, S current)? buildWhen;

  /// Optional condition to determine when to trigger effect listener.
  final bool Function(E effect)? listenWhen;

  @override
  State<BlocEffectConsumer<B, S, E>> createState() =>
      _BlocEffectConsumerState<B, S, E>();
}

class _BlocEffectConsumerState<B extends BlocWithEffect<dynamic, S, E>, S, E>
    extends State<BlocEffectConsumer<B, S, E>> {
  late B _bloc;
  StreamSubscription<E>? _effectSubscription;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc ?? context.read<B>();
    _subscribeToEffects();
  }

  @override
  void didUpdateWidget(BlocEffectConsumer<B, S, E> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldBloc = oldWidget.bloc ?? _bloc;
    final currentBloc = widget.bloc ?? _bloc;
    if (oldBloc != currentBloc) {
      _effectSubscription?.cancel();
      _bloc = currentBloc;
      _subscribeToEffects();
    }
  }

  @override
  void dispose() {
    _effectSubscription?.cancel();
    super.dispose();
  }

  void _subscribeToEffects() {
    _effectSubscription = _bloc.effects.listen((effect) {
      if (widget.listenWhen?.call(effect) ?? true) {
        widget.effectListener(context, effect);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      bloc: _bloc,
      buildWhen: widget.buildWhen,
      builder: widget.builder,
    );
  }
}
