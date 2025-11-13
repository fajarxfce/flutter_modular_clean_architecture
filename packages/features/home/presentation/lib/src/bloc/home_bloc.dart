import 'package:blocfx/blocfx.dart';
import 'package:home_presentation/src/bloc/home_effect.dart';
import 'package:home_presentation/src/bloc/home_event.dart';
import 'package:home_presentation/src/bloc/home_state.dart';
import 'package:navigation/app_navigator.dart';
import 'package:shared/shared.dart';

@injectable
class HomeBloc extends BaseBloc<HomeEvent, HomeState, HomeEffect> {
  final AppNavigator _appNavigator;
  HomeBloc(this._appNavigator) : super(HomeState.initial()) {
    on<OnButtonClickedEvent>(_onButtonClicked);
  }

  Future<void> _onButtonClicked(
    OnButtonClickedEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _appNavigator.navigateToProfile();
  }
}
