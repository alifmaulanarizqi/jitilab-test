import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/domain/models/error_dto.dart';
import '../../../data/remote/response/user_response.dart';
import '../../../domain/usecase/detail_user_usecase.dart';

part 'detail_user_event.dart';
part 'detail_user_state.dart';

class DetailUserBloc extends Bloc<DetailUserEvent, DetailUserState> {
  final DetailUserUseCase detailUserUseCase;
  var stateData = const DetailUserStateData();

  DetailUserBloc({required this.detailUserUseCase})
      : super(const DetailUserInitialState()) {
    on<DetailUserInitEvent>(_onInitDetailUser);
  }

  void _onInitDetailUser(
      DetailUserInitEvent event,
      Emitter<DetailUserState> emit,
  ) async {
    emit(DetailUserLoadingState(stateData));

    var result = await detailUserUseCase.execute(
        id: event.id
    );

    result.fold((ErrorDto error) {
      stateData = stateData.copyWith(
        userDto: const UserResponse('', '', '', '', '', false),
        error: error,
      );
      emit(DetailUserFailedState(stateData));
    }, (right) {
      stateData = stateData.copyWith(
        userDto: right,
        error: null,
      );

      emit(DetailUserSuccessState(stateData));
    });
  }
}