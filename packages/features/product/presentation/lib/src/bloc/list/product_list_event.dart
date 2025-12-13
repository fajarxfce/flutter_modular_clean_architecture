import 'package:shared/shared.dart';

abstract class ProductListEvent extends BaseEvent {}

class LoadProductsEvent extends ProductListEvent {}

class OnNavigateToAddProduct extends ProductListEvent {}
