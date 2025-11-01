import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_with_effect.dart';

/// A widget that only listens to effects without rebuilding on state changes.
///
/// This is useful when you only need to handle side effects (navigation, dialogs, etc.)
/// without rebuilding the widget tree.
///
/// Example:
/// ```dart
/// BlocEffectListener<LoginBloc, LoginEffect>(
///   listener: (context, effect) {
///     if (effect is ShowSuccessSnackbar) {
///       ScaffoldMessenger.of(context).showSnackBar(
///         SnackBar(content: Text(effect.message)),
///       );
///     }
///     if (effect is NavigateToHome) {
///       Navigator.pushReplacementNamed(context, '/home');
///     }
///   },
///   child: LoginForm(),
/// )
/// ```
class BlocEffectListener<B extends BlocWithEffect<dynamic, dynamic, E>, E>
    extends StatefulWidget {
  const BlocEffectListener({
    super.key,
    required this.listener,
    required this.child,
    this.bloc,
    this.listenWhen,
  });

  /// The [BlocWithEffect] instance. If not provided, will use [BlocProvider.of].
  final B? bloc;

  /// Listener function for side effects (single-shot events).
  final void Function(BuildContext context, E effect) listener;

  /// The child widget (won't rebuild on state changes).
  final Widget child;

  /// Optional condition to determine when to trigger effect listener.
  final bool Function(E effect)? listenWhen;

  @override
  State<BlocEffectListener<B, E>> createState() =>
      _BlocEffectListenerState<B, E>();
}

class _BlocEffectListenerState<B extends BlocWithEffect<dynamic, dynamic, E>, E>
    extends State<BlocEffectListener<B, E>> {
  late B _bloc;
  StreamSubscription<E>? _effectSubscription;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc ?? context.read<B>();
    _subscribeToEffects();
  }

  @override
  void didUpdateWidget(BlocEffectListener<B, E> oldWidget) {
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
        widget.listener(context, effect);
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
