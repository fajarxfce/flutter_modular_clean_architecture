import 'package:shared/shared.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends BaseState {
  final HomeStatus status;

  const HomeState({required this.status});

  factory HomeState.initial() => const HomeState(status: HomeStatus.initial);

  HomeState copyWith({HomeStatus? status}) {
    return HomeState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
