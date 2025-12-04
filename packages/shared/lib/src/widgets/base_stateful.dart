import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

abstract class BaseStatefulBaseStateless<
  T extends StatefulWidget,
  E extends BaseEvent,
  S extends BaseState,
  F extends BaseEffect,
  B extends BaseBloc<E, S, F>
> {}
