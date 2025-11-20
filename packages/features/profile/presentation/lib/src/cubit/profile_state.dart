import 'package:equatable/equatable.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;

  const ProfileState({this.status = ProfileStatus.initial});

  ProfileState copyWith({ProfileStatus? status, String? errorMessage}) {
    return ProfileState(status: status ?? this.status);
  }

  factory ProfileState.initial() => ProfileState(status: ProfileStatus.initial);

  @override
  List<Object?> get props => [status];
}
