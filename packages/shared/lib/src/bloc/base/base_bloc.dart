import 'package:shared/shared.dart';

abstract class BaseBloc<
  E extends BaseEvent,
  S extends BaseState,
  F extends BaseEffect
>
    extends BaseBlocDelegate<E, S, F> {
  BaseBloc(super.initialState);
}

abstract class BaseBlocDelegate<
  E extends BaseEvent,
  S extends BaseState,
  F extends BaseEffect
>
    extends BlocWithEffect<E, S, F> {
  BaseBlocDelegate(super.initialState);
}
