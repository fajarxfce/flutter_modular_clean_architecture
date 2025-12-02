import 'package:blocfx/blocfx.dart';
import 'package:flutter/material.dart';
import 'package:profile_presentation/src/cubit/profile_cubit.dart';
import 'package:profile_presentation/src/cubit/profile_effect.dart';
import 'package:profile_presentation/src/cubit/profile_state.dart';
import 'package:shared/shared.dart';
import 'package:widgets/widgets.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<ProfileCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Profile Page')),
            body: CubitfxListener<ProfileCubit, ProfileState, ProfileEffect>(
              listener: (context, effect) {
                if (effect is ShowProfileDialog) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Profile Info'),
                      content: Text(effect.message),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Center(
                child: AppButton.primary(
                  onPressed: () {
                    context.read<ProfileCubit>().loadProfile();
                  },
                  text: 'Load Profile',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
