import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_presentation/src/bloc/home_bloc.dart';
import 'package:shared/shared.dart';

@RoutePage()
class HomePage extends BaseStateless<HomeBloc> {
  HomePage({super.key});

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
