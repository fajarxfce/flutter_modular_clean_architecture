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
import 'package:main_presentation/src/main_page.dart' as _i1;

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i2.PageRouteInfo<MainRouteArgs> {
  MainRoute({_i3.Key? key, List<_i2.PageRouteInfo>? children})
    : super(
        MainRoute.name,
        args: MainRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'MainRoute';

  static _i2.PageInfo page = _i2.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MainRouteArgs>(
        orElse: () => const MainRouteArgs(),
      );
      return _i1.MainPage(key: args.key);
    },
  );
}

class MainRouteArgs {
  const MainRouteArgs({this.key});

  final _i3.Key? key;

  @override
  String toString() {
    return 'MainRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MainRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}
