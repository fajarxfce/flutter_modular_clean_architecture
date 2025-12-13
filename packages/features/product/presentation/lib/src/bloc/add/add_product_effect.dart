import 'package:shared/shared.dart';

abstract class AddProductEffect extends BaseEffect {}

class ProductAddedEffect extends AddProductEffect {
  ProductAddedEffect();
}

class ProductAddFailedEffect extends AddProductEffect {
  final String message;

  ProductAddFailedEffect(this.message);
}
