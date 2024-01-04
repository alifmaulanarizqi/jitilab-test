import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jitilab_test/core/utils/value_extension.dart';
import '../../../../common_ui/dialogs/common_dialogs.dart';
import '../../../../common_ui/utils/colors/common_colors.dart';
import '../../../../common_ui/utils/text_style/common_text_style.dart';
import '../../../../common_ui/widgets/common_search_filter.dart';
import '../../../../core/domain/models/key_value_dto.dart';
import 'bloc/list_user_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ListUserPage extends StatefulWidget {
  static const route = '/user';

  const ListUserPage({Key? key}) : super(key: key);

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  late ListUserBloc _bloc;
  final ScrollController _scrollController = ScrollController();
  final keywordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc = ListUserBloc(listUserUseCase: GetIt.instance())
      ..add(const ListUserInitEvent(
          page: 1,
          limit: 20,
      ));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScroll);
  }

  void _onScroll() async {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      if (!_bloc.hasNoMoreData) {
          _bloc.isLoadingPagination = true;
          _bloc.add(ListUserInitEvent(
            page: _bloc.stateData.page + 1,
            limit: 20
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: CommonColors.blueB5,
        title: Text(
          'List Contact',
          style: CommonTypography.roboto20.copyWith(
              fontWeight: FontWeight.w600,
              color: CommonColors.white
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: BlocConsumer<ListUserBloc, ListUserState>(
                bloc: _bloc,
                listener: (context, state) {},
                builder: (context, state) {
                  if(state is ListUserFailedState) {
                    return Column(
                      children: [
                        _buildFailedListEmployee(state: state),
                        ElevatedButton(
                          onPressed: () {
                            _bloc.add(const ListUserInitEvent(
                              page: 1,
                              limit: 20,
                            ));
                          },
                          child: const Text('Refresh'),
                        ),
                      ],
                    );
                  } else if (state is ListUserLoadingState) {
                    return _buildShimmerLoading();
                  } else if (state is ListUserEmptyState) {
                    return _buildEmptyListEmployee(state: state);
                  }

                  return _buildListEmployee(state: state);
                }
            ),
          )
      ),
    );
  }

  Widget _buildSearchAndFilter(ListUserState state, TextEditingController controller) {
    return CommonSearchFilterAction(
      onDoSearch: (keyword) {
        _onDoSearch(state: state, keyword: keyword,);
      },
      onClearSearch: () {
        _onClearSearchKeyword(controller: controller);
      },
      onFilter: () {
        _onShowFilterDialog(
          state: state,
          genderTypeOption: state.data.genderTypeOption,
          lastSelectedGenderExtension: state.data.selectedGenderType,
        );
      },
      keywordController: controller,
      hintSearch: "Search",
    );
  }

  void _onDoSearch({
    dynamic state,
    required String keyword,
  }) {
    _bloc.add(ListUserInitEvent(
      page: 1,
      limit: 20,
      searchKeyword: keyword.nullIfEmpty(),
    ));
  }

  void _onClearSearchKeyword({
    required TextEditingController controller
  }) {
    if (controller.text.isNotEmpty) {
      controller.clear();
      _bloc.add(const ListUserInitEvent(
        page: 1,
        limit: 20,
        searchKeyword: null,
      ));
    }
  }

  void _onShowFilterDialog({
    required dynamic state,
    List<KeyValueDto> genderTypeOption = const [],
    List<KeyValueDto> lastSelectedGenderExtension = const [],
  }) async {
    var result = await CommonDialogs.showListUserFilter(
      context,
      isSingleSelected: true,
      genderTypeOptions: genderTypeOption,
      lastSelectedGender: lastSelectedGenderExtension,
      title: 'Filter',
    );

    if (result != null) {
      try {
        List<KeyValueDto> selectedGenderType = result[0];

        keywordController.clear();
        if(selectedGenderType.isEmpty) {
          _bloc.hasNoMoreData = false;
          _bloc.isLoadingPagination = false;
          _bloc.add(const ListUserInitEvent(
            page: 1,
            limit: 20,
          ));
        } else {
          _bloc.add(ListUserApplyFilterEvent(
            selectedGenderType: selectedGenderType,
          ));
        }

      } on Exception catch (e) {
        CommonDialogs.showToastMessage(e.toString());
      }
    } else {
      //_bloc.add(CourseListCancelFilterEvent());
    }
  }

  Widget _buildListEmployee({
    required ListUserState state,
  }) {
    return Column(
      children: [
        _buildSearchAndFilter(state, keywordController),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView.builder(
              controller: _scrollController,
              itemCount: state.data.userDto.length,
              itemBuilder: (context, index) {
                bool lastIndex = false;
                if(_bloc.hasNoMoreData) {
                  lastIndex = index == _bloc.stateData.userDto.length - 1;
                }
          
                if(index < _bloc.stateData.userDto.length - 1 || lastIndex) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   DetailEmployeePage.route,
                      //   arguments: DetailEmployeeArg(
                      //       id: state.data.employeeDto[index].id
                      //   ),
                      // );
                    },
                    child: Card(
                      color: CommonColors.whiteFB,
                      elevation: 1,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 130,
                            width: 100,
                            child: Image.network(
                              state.data.userDto[index].avatar ?? '',
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${state.data.userDto[index].name}',
                                  style: CommonTypography.roboto16,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '${state.data.userDto[index].phone}',
                                  style: CommonTypography.roboto16,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if(!_bloc.hasNoMoreData) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
          
                return const SizedBox.shrink();
              }
          ),
        ),
      ],
    );
  }

  Widget _buildFailedListEmployee({
    required ListUserState state,
  }) {
    return Expanded(
        child: Center(
          child: Text(
            'Request Failed: ${state.data.error?.message}',
            style: CommonTypography.roboto16.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        )
    );
  }

  Widget _buildEmptyListEmployee({
    required ListUserState state,
  }) {
    return Expanded(
        child: Center(
          child: Text(
            'There is no employee',
            style: CommonTypography.roboto16.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        )
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Column(
            children: [
              if(index == 0)
                const SizedBox(
                  height: 12,
                ),
              Shimmer.fromColors(
                baseColor: CommonColors.greyD1,
                highlightColor: CommonColors.greyBD,
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: CommonColors.greyD1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          );
        }
    );
  }

}