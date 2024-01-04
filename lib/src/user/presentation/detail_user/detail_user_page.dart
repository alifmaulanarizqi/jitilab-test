import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common_ui/utils/colors/common_colors.dart';
import '../../../../common_ui/utils/text_style/common_text_style.dart';
import '../../../../core/utils/value_extension.dart';
import 'arg/detail_user_arg.dart';
import 'bloc/detail_user_bloc.dart';

class DetailUserPage extends StatefulWidget {
  static const route = '/user/detail';

  const DetailUserPage({Key? key}) : super(key: key);

  @override
  State<DetailUserPage> createState() => _DetailUserPageState();
}

class _DetailUserPageState extends State<DetailUserPage> {
  late DetailUserBloc _bloc;

  int _userId = 0;

  @override
  void initState() {
    super.initState();

    _bloc = DetailUserBloc(detailUserUseCase: GetIt.instance());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var args = cast<DetailUserArg>(
      ModalRoute.of(context)?.settings.arguments,
    );
    var userId = args?.id ?? 0;
    _userId = userId;

    _bloc.add(DetailUserInitEvent(id: _userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.blueB5,
        title: Text(
          'Detail Contact',
          style: CommonTypography.roboto20.copyWith(
              fontWeight: FontWeight.w600,
              color: CommonColors.white
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<DetailUserBloc, DetailUserState>(
          bloc: _bloc,
          listener: (context, state) {},
          builder: (context, state) {
            if(state is DetailUserFailedState) {
              return Column(
                children: [
                  _buildFailedDetailEmployee(state: state),
                  ElevatedButton(
                    onPressed: () {
                      _bloc.add(DetailUserInitEvent(
                        id: _userId,
                      ));
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              );
            } else if (state is DetailUserLoadingState) {
              return _buildShimmerLoading();
            }

            return _buildDetailEmployee(state: state);
          },
        ),
      ),
    );
  }

  Widget _buildDetailEmployee({
    required DetailUserState state,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildPhotoProfile(
              url: state.data.userDto.avatar ?? '',
              fullName: state.data.userDto.name ?? '',
          ),
          const SizedBox(
            height: 18,
          ),
          _buildCard(
              label: 'Email',
              cardValue: state.data.userDto.email ?? ''
          ),
          const SizedBox(
            height: 4,
          ),
          _buildCard(
              label: 'Phone',
              cardValue: state.data.userDto.phone ?? '',
              icon: Icons.phone
          ),
          const SizedBox(
            height: 4,
          ),
          _buildCard(
              label: 'Gender',
              cardValue: state.data.userDto.isMale! ? 'Laki-laki' : 'Perempuan',
              icon: Icons.male_rounded
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoProfile({
    required String url,
    required String fullName,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 260,
          color: CommonColors.blueB5,
        ),
        Positioned(
          bottom: 80,
          child: ClipOval(
            child: Image.network(
              url,
              fit: BoxFit.cover,
              width: 130,
              height: 130,
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
        ),
        Positioned(
          bottom: 30,
          child: Text(
            fullName,
            style: CommonTypography.roboto20.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: CommonColors.white
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String label,
    required String cardValue,
    IconData? icon = Icons.email_rounded,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Card(
        color: CommonColors.whiteFB,
        elevation: 1,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Icon(
                icon,
                size: 35,
                color: CommonColors.blue9F,
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardValue,
                    style: CommonTypography.roboto16.copyWith(
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    label,
                    style: CommonTypography.roboto14,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFailedDetailEmployee({
    required DetailUserState state,
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

  Widget _buildShimmerLoading() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 260,
                color: CommonColors.blueB5,
              ),
              Positioned(
                bottom: 80,
                child: Shimmer.fromColors(
                  baseColor: CommonColors.greyD1,
                  highlightColor: CommonColors.greyBD,
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: const BoxDecoration(
                      color: CommonColors.greyD1,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                child: Shimmer.fromColors(
                  baseColor: CommonColors.greyD1,
                  highlightColor: CommonColors.greyBD,
                  child: Container(
                    height: 30,
                    width: 250,
                    color: CommonColors.greyD1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Shimmer.fromColors(
              baseColor: CommonColors.greyD1,
              highlightColor: CommonColors.greyBD,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: CommonColors.greyD1,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Shimmer.fromColors(
              baseColor: CommonColors.greyD1,
              highlightColor: CommonColors.greyBD,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: CommonColors.greyD1,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Shimmer.fromColors(
              baseColor: CommonColors.greyD1,
              highlightColor: CommonColors.greyBD,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: CommonColors.greyD1,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}