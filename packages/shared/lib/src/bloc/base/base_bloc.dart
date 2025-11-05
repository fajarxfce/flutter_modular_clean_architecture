import 'package:blocfx/blocfx.dart';
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
    extends BlocFx<E, S, F> {
  BaseBlocDelegate(super.initialState);
}
