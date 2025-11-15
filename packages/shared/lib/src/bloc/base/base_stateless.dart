import 'package:blocfx/blocfx.dart';
import 'package:flutter/widgets.dart';
import 'package:shared/shared.dart';

abstract class BaseStateless<
  E extends BaseEvent,
  S extends BaseState,
  F extends BaseEffect,
  B extends BaseBloc<E, S, F>
>
    extends BaseStatelessDelegate<E, S, F, B> {
  BaseStateless({super.key});
}

abstract class BaseStatelessDelegate<
  E extends BaseEvent,
  S extends BaseState,
  F extends BaseEffect,
  B extends BaseBloc<E, S, F>
>
    extends StatelessWidget {
  late final B bloc = GetIt.instance<B>();

  BaseStatelessDelegate({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
      create: (context) => bloc,
      child: BlocFxListener<B, E, S, F>(
        bloc: bloc,
        listener: onEffect,
        child: buildPage(context),
      ),
    );
  }

  Widget buildPage(BuildContext context);

  void onEffect(BuildContext context, F effect) {}
}
