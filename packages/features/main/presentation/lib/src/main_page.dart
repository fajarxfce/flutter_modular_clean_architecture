import 'package:flutter/material.dart';
import 'package:main_presentation/src/bloc/main_bloc.dart';
import 'package:main_presentation/src/bloc/main_effect.dart';
import 'package:main_presentation/src/bloc/main_event.dart';
import 'package:main_presentation/src/bloc/main_state.dart';
import 'package:shared/shared.dart';

@RoutePage()
class MainPage
    extends BaseStateless<MainEvent, MainState, MainEffect, MainBloc> {
  MainPage({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return AutoTabsScaffold(
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.primary, colorScheme.primaryContainer],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () => bloc.add(OnNavigateToTransaction()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Icon(Icons.add, size: 32, color: colorScheme.onPrimary),
      ),
    );
  }
}
