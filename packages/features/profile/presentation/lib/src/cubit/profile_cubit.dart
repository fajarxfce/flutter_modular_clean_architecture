import 'package:blocfx/blocfx.dart';
import 'package:profile_presentation/src/cubit/profile_effect.dart';
import 'package:profile_presentation/src/cubit/profile_state.dart';
import 'package:shared/shared.dart';

@injectable
class ProfileCubit extends Cubitfx<ProfileState, ProfileEffect> {
  ProfileCubit() : super(ProfileState.initial());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      emit(state.copyWith(status: ProfileStatus.success));
      emitEffect(ShowProfileDialog('Profile loaded successfully!'));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }
}
