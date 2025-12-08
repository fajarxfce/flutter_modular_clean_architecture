import 'package:flutter/material.dart';
import 'package:product_presentation/src/bloc/list/product_list_bloc.dart';
import 'package:product_presentation/src/bloc/list/product_list_effect.dart';
import 'package:product_presentation/src/bloc/list/product_list_event.dart';
import 'package:product_presentation/src/bloc/list/product_list_state.dart';
import 'package:shared/shared.dart';

@RoutePage()
class ProductPage
    extends
        BaseStateless<
          ProductListEvent,
          ProductListState,
          ProductListEffect,
          ProductListBloc
        > {
  ProductPage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Page')),
      body: const Center(child: Text('This is the Product sss')),
    );
  }

  @override
  void onEffect(BuildContext context, ProductListEffect effect) {
    super.onEffect(context, effect);
  }
}
