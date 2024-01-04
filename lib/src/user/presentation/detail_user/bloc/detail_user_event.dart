part of 'detail_user_bloc.dart';

abstract class DetailUserEvent extends Equatable {
  const DetailUserEvent();
}

class DetailUserInitEvent extends DetailUserEvent {
  final int id;

  const DetailUserInitEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}