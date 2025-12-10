import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_presentation/src/bloc/home_bloc.dart';
import 'package:home_presentation/src/bloc/home_effect.dart';
import 'package:home_presentation/src/bloc/home_event.dart';
import 'package:home_presentation/src/bloc/home_state.dart';
import 'package:shared/shared.dart';
import 'package:widgets/widgets.dart';

@RoutePage()
class HomePage
    extends BaseStateless<HomeEvent, HomeState, HomeEffect, HomeBloc> {
  HomePage({super.key});

  @override
  void onEffect(BuildContext context, HomeEffect effect) {}

  @override
  Widget buildPage(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.primary,
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Refresh data
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome!',
                            style: textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage your business efficiently',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.business,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Menu Grid
              Text(
                'Menu Utama',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  AppMenuCard(
                    icon: Icons.inventory_rounded,
                    title: 'Kelola Produk',
                    subtitle: 'Atur produk Anda',
                    onTap: () {
                      bloc.add(const OnNavigateToProduct());
                    },
                    backgroundColor: colorScheme.onPrimary,
                    iconColor: colorScheme.primary,
                  ),
                  AppMenuCard(
                    icon: Icons.receipt_long_rounded,
                    title: 'Transaksi',
                    subtitle: 'Catat transaksi',
                    onTap: () {
                      throw Exception('Test Crashlytics Exception');
                    },
                    backgroundColor: colorScheme.onPrimary,
                    iconColor: Colors.blue.shade700,
                  ),
                  AppMenuCard(
                    icon: Icons.payments_rounded,
                    title: 'Pengeluaran',
                    subtitle: 'Catat pengeluaran',
                    onTap: () {
                      // TODO: Navigate to expense page
                    },
                    backgroundColor: colorScheme.onPrimary,
                    iconColor: Colors.red.shade700,
                  ),
                  AppMenuCard(
                    icon: Icons.assessment_rounded,
                    title: 'Laporan',
                    subtitle: 'Lihat laporan',
                    onTap: () {
                      // TODO: Navigate to report page
                    },
                    backgroundColor: colorScheme.onPrimary,
                    iconColor: Colors.purple.shade700,
                  ),
                  AppMenuCard(
                    icon: Icons.people_rounded,
                    title: 'Pelanggan',
                    subtitle: 'Kelola pelanggan',
                    onTap: () {
                      // TODO: Navigate to customer page
                    },
                    backgroundColor: colorScheme.onPrimary,
                    iconColor: Colors.orange.shade700,
                  ),
                  AppMenuCard(
                    icon: Icons.settings_rounded,
                    title: 'Pengaturan',
                    subtitle: 'Atur aplikasi',
                    onTap: () {
                      context.tabsRouter.setActiveIndex(1);
                    },
                    backgroundColor: colorScheme.onPrimary,
                    iconColor: Colors.grey.shade700,
                  ),
                ],
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
