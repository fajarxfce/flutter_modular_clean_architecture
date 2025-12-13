import 'package:shared/shared.dart';

abstract class AddProductEvent extends BaseEvent {}

class SaveProductEvent extends AddProductEvent {
  SaveProductEvent();
}

class NameChangedEvent extends AddProductEvent {
  final String name;

  NameChangedEvent(this.name);
}

class PriceChangedEvent extends AddProductEvent {
  final String price;

  PriceChangedEvent(this.price);
}

class DescriptionChangedEvent extends AddProductEvent {
  final String description;

  DescriptionChangedEvent(this.description);
}

class ResetAddProductEvent extends AddProductEvent {}
