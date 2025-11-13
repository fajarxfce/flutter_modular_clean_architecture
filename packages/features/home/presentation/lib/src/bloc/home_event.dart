import 'package:shared/shared.dart';

abstract class HomeEvent extends BaseEvent {
  const HomeEvent();
}

class OnButtonClickedEvent extends HomeEvent {
  const OnButtonClickedEvent();
}
