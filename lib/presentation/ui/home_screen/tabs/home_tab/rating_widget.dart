import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/extensions/extension.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/hom_screen_state.dart';

import '../../../../../core/colors/app_color.dart';
import '../../../../../core/di/di.dart';
import '../../cubit/home_screen_view_model.dart';

class RatingWidget extends StatelessWidget {
  final String movieId;

  const RatingWidget({super.key, required this.movieId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt.get<HomeScreenViewModel>()
        ..getMovieRating(movieId),
      child: BlocBuilder<HomeScreenViewModel, HomeScreenState>(
        builder: (context, state) {
          if (state is RatingSuccess) {
            return Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 13, horizontal: 13.11),
              padding: const EdgeInsetsDirectional.all(6),
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColor.black.withAlpha(171),
                borderRadius: BorderRadiusGeometry.circular(10),
              ),
              constraints: BoxConstraints(maxWidth: 70, maxHeight: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.rating ?? '0.0', style: context.fonts.titleSmall),
                  const Icon(Icons.star, color: AppColor.goldenYellow),
                ],
              ),
            );
          }

          else if (state is HomeErrorState) {
            return Text('');
          }
          return const SizedBox();
        },
      ),
    );
  }
}
