part of 'detail_user_bloc.dart';

class DetailUserStateData extends Equatable {
  final UserResponse userDto;
  final ErrorDto? error;

  const DetailUserStateData({
    this.userDto = const UserResponse('', '', '', '', '', false),
    this.error
  });

  @override
  List<Object?> get props => [
    userDto,
    error
  ];

  DetailUserStateData copyWith({
    UserResponse? userDto,
    ErrorDto? error,
  }) {
    return DetailUserStateData(
      userDto: userDto ?? this.userDto,
      error: error ?? this.error,
    );
  }
}

abstract class DetailUserState extends Equatable {
  final DetailUserStateData data;

  const DetailUserState(this.data);

  @override
  List<Object> get props => [];
}

class DetailUserInitialState extends DetailUserState {
  const DetailUserInitialState()
      : super(const DetailUserStateData());
}

class DetailUserLoadingState extends DetailUserState {
  const DetailUserLoadingState(super.data);
}

class DetailUserFailedState extends DetailUserState {
  const DetailUserFailedState(super.data);
}

class DetailUserSuccessState extends DetailUserState {
  const DetailUserSuccessState(super.data);
}