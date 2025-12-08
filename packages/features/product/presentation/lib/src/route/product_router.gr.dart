// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;
import 'package:product_presentation/src/product_page.dart' as _i1;

/// generated route for
/// [_i1.ProductPage]
class ProductRoute extends _i2.PageRouteInfo<ProductRouteArgs> {
  ProductRoute({_i3.Key? key, List<_i2.PageRouteInfo>? children})
    : super(
        ProductRoute.name,
        args: ProductRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'ProductRoute';

  static _i2.PageInfo page = _i2.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductRouteArgs>(
        orElse: () => const ProductRouteArgs(),
      );
      return _i1.ProductPage(key: args.key);
    },
  );
}

class ProductRouteArgs {
  const ProductRouteArgs({this.key});

  final _i3.Key? key;

  @override
  String toString() {
    return 'ProductRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProductRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}
