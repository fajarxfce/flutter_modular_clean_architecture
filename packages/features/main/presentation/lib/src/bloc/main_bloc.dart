import 'package:main_presentation/src/bloc/main_effect.dart';
import 'package:main_presentation/src/bloc/main_event.dart';
import 'package:main_presentation/src/bloc/main_state.dart';
import 'package:navigation/app_navigator.dart';
import 'package:shared/shared.dart';

@injectable
class MainBloc extends BaseBloc<MainEvent, MainState, MainEffect> {
  final AppNavigator _appNavigator;
  MainBloc(this._appNavigator) : super(MainState()) {
    on<OnNavigateToTransaction>(_navigateToTransactionPage);
  }

  Future<void> _navigateToTransactionPage(
    OnNavigateToTransaction event,
    Emitter<MainState> emit,
  ) async {
    await _appNavigator.navigateToTransaction();
  }
}
