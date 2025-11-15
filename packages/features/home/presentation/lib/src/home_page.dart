import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_presentation/src/bloc/home_bloc.dart';
import 'package:home_presentation/src/bloc/home_effect.dart';
import 'package:home_presentation/src/bloc/home_event.dart';
import 'package:home_presentation/src/bloc/home_state.dart';
import 'package:shared/shared.dart';

@RoutePage()
class HomePage
    extends BaseStateless<HomeEvent, HomeState, HomeEffect, HomeBloc> {
  HomePage({super.key});

  @override
  void onEffect(BuildContext context, HomeEffect effect) {}

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Welcome to the Home Page!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.tabsRouter.setActiveIndex(1);
              },
              child: const Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
