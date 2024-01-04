part of 'list_user_bloc.dart';

class ListUserStateData extends Equatable {
  final int page;
  final int limit;
  final List<UserResponse> userDto;
  final ErrorDto? error;

  const ListUserStateData({
    this.page = 1,
    this.limit = 10,
    this.userDto = const [],
    this.error
  });

  @override
  List<Object?> get props => [
    page,
    limit,
    userDto,
    error
  ];

  ListUserStateData copyWith({
    int? page,
    int? limit,
    List<UserResponse>? userDto,
    ErrorDto? error,
  }) {
    return ListUserStateData(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      userDto: userDto ?? this.userDto,
      error: error ?? this.error,
    );
  }
}

abstract class ListUserState extends Equatable {
  final ListUserStateData data;

  const ListUserState(this.data);

  @override
  List<Object> get props => [];
}

class ListUserInitialState extends ListUserState {
  const ListUserInitialState()
      : super(const ListUserStateData());
}

class ListUserLoadingState extends ListUserState {
  const ListUserLoadingState(super.data);
}

class ListUserPaginationLoadingState extends ListUserState {
  const ListUserPaginationLoadingState(super.data);
}

class ListUserFailedState extends ListUserState {
  const ListUserFailedState(super.data);
}

class ListUserSuccessState extends ListUserState {
  const ListUserSuccessState(super.data);
}

class ListUserEmptyState extends ListUserState {
  const ListUserEmptyState(super.data);
}