import 'package:equatable/equatable.dart';

enum OnboardingStatus { initial, loading, success, failure }

class OnboardingUiState extends Equatable {
  final OnboardingStatus status;

  const OnboardingUiState({this.status = OnboardingStatus.initial});

  OnboardingUiState copyWith({OnboardingStatus? status}) {
    return OnboardingUiState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
