import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jitilab_test/src/user/data/remote/response/user_response.dart';
import '../../../../../../core/domain/models/error_dto.dart';
import '../../../../../core/domain/models/key_value_dto.dart';
import '../../../domain/usecase/list_user_usecase.dart';

part 'list_user_event.dart';
part 'list_user_state.dart';

class ListUserBloc extends Bloc<ListUserEvent, ListUserState> {
  final ListUserUseCase listUserUseCase;
  var stateData = const ListUserStateData();
  bool isLoadingPagination = false;
  bool hasNoMoreData = false;

  ListUserBloc({required this.listUserUseCase})
      : super(const ListUserInitialState()) {
    on<ListUserInitEvent>(_onInitSearch);
    on<ListUserApplyFilterEvent>(_onFilterApplied);
  }

  void _onInitSearch(
      ListUserInitEvent event,
      Emitter<ListUserState> emit,
  ) async {
    var genderTypeOption = [
      const KeyValueDto(key: "1", value: "Laki-laki"),
      const KeyValueDto(key: "0", value: "Perempuan"),
    ];

    stateData = stateData.copyWith(
      genderTypeOption: genderTypeOption,
    );

    if(hasNoMoreData) {
      return;
    }

    if(isLoadingPagination) {
      emit(ListUserPaginationLoadingState(stateData));
    } else {
      emit(ListUserLoadingState(stateData));
    }

    stateData = stateData.copyWith(
      page: event.page,
    );

    await _doSearch(page: event.page, limit: event.limit);

    if (stateData.error != null) {
      emit(ListUserFailedState(stateData));
    } else {
      if(stateData.userDto.isEmpty){
        emit(ListUserEmptyState(stateData));
      } else{
        emit(ListUserSuccessState(stateData));
      }
    }
  }

  void _onFilterApplied(
      ListUserApplyFilterEvent event,
      Emitter<ListUserState> emit,
  ) async {
    stateData = stateData.copyWith(
      selectedGenderType: event.selectedGenderType,
    );

    emit(ListUserLoadingState(stateData));

    await _doSearch(
      page: 1,
      isMaleInt: event.selectedGenderType!.isEmpty ? null : int.parse(event.selectedGenderType![0].key),
    );

    if (stateData.error != null) {
      emit(ListUserFailedState(stateData));
    } else {
      if(stateData.userDto.isEmpty){
        emit(ListUserEmptyState(stateData));
      } else {
        emit(ListUserSuccessState(stateData));
      }
    }
  }

  Future _doSearch({
    int? page,
    int? limit,
    int? isMaleInt,
  }) async {
    bool? isMale;
    if(isMaleInt == 0) {
      isMale = false;
    } else if(isMaleInt == 1) {
      isMale = true;
    }

    var result = await listUserUseCase.execute(
      page: page,
      limit: limit,
      isMale: isMale,
    );

    result.fold((ErrorDto error) {
      if (page == 1) {
        stateData = stateData.copyWith(
          userDto: [],
          error: error,
        );
      } else {
        stateData = stateData.copyWith(
          error: error,
        );
      }
    }, (right) {
      if(right.isEmpty) {
        hasNoMoreData = true;
        return;
      }

      if (page == 1) {
        stateData = stateData.copyWith(
          page: page,
          limit: limit,
          userDto: right,
          error: null,
        );
      } else {
        var previousEmployee = stateData.userDto;
        previousEmployee.addAll(right);

        stateData = stateData.copyWith(
          userDto: previousEmployee,
          error: null,
        );
      }
    });
  }
}