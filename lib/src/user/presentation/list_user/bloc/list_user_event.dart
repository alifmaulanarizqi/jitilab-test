part of 'list_user_bloc.dart';

abstract class ListUserEvent extends Equatable {
  const ListUserEvent();
}

class ListUserInitEvent extends ListUserEvent {
  final int page;
  final int limit;
  final String? searchKeyword;

  const ListUserInitEvent({
    required this.page,
    this.limit = 20,
    this.searchKeyword,
  });

  @override
  List<Object?> get props => [page, limit, searchKeyword];
}

class ListUserApplyFilterEvent extends ListUserEvent {
  final List<KeyValueDto>? selectedGenderType;

  const ListUserApplyFilterEvent({
    required this.selectedGenderType,
  });

  @override
  List<Object?> get props => [selectedGenderType];
}