part of 'list_user_bloc.dart';

abstract class ListUserEvent extends Equatable {
  const ListUserEvent();
}

class ListUserInitEvent extends ListUserEvent {
  final int page;
  final int limit;

  const ListUserInitEvent({
    required this.page,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [page, limit];
}