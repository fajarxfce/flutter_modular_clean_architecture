import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_with_effect.dart';

class BlocEffectListener<B extends BlocWithEffect<Event, S, E>, Event, S, E>
    extends StatefulWidget {
  const BlocEffectListener({
    super.key,
    required this.listener,
    required this.child,
    this.bloc,
    this.listenWhen,
  });

  final B? bloc;

  final void Function(BuildContext context, E effect) listener;

  final Widget child;

  final bool Function(E effect)? listenWhen;

  @override
  State<BlocEffectListener<B, Event, S, E>> createState() =>
      _BlocEffectListenerState<B, Event, S, E>();
}

class _BlocEffectListenerState<
  B extends BlocWithEffect<Event, S, E>,
  Event,
  S,
  E
>
    extends State<BlocEffectListener<B, Event, S, E>> {
  late B _bloc;
  StreamSubscription<E>? _effectSubscription;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc ?? context.read<B>();
    _subscribeToEffects();
  }

  @override
  void didUpdateWidget(BlocEffectListener<B, Event, S, E> oldWidget) {
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
