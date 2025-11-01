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
import 'package:login_presentation/src/login_page.dart' as _i1;

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i2.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i3.Key? key, String? hello, List<_i2.PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key, hello: hello),
        rawQueryParams: {'hello': hello},
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static _i2.PageInfo page = _i2.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => LoginRouteArgs(hello: queryParams.optString('hello')),
      );
      return _i1.LoginPage(key: args.key, hello: args.hello);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key, this.hello});

  final _i3.Key? key;

  final String? hello;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, hello: $hello}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginRouteArgs) return false;
    return key == other.key && hello == other.hello;
  }

  @override
  int get hashCode => key.hashCode ^ hello.hashCode;
}
