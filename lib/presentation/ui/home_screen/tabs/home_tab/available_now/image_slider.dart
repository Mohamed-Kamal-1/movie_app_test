import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/ui/details_screen/details_screen.dart';

import '../../../../../../core/colors/app_color.dart';
import '../../../../../../domain/model/movie_model.dart';
import '../../../cubit/home_screen_view_model.dart';
import '../rating_widget.dart';

class ImageSlider extends StatelessWidget {
  final PageController pageController;
  final List<MovieModel> moviesList;

  const ImageSlider({
    super.key,
    required this.pageController,
    required this.moviesList,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: moviesList.length,
      itemBuilder: (context, index) {
        if (index >= moviesList.length) {
          return const SizedBox.shrink();
        }

        getIt.get<HomeScreenViewModel>().getMovieRating(
          moviesList[index].imdbCode.toString(),
        );

        return AnimatedBuilder(
          animation: pageController,

          builder: (context, child) {
            double value = 1;
            if (pageController.position.haveDimensions) {
              value = (pageController.page! - index).abs();
              value = (1 - value * 0.3).clamp(0.8, 1.0);
            }
            return Transform.scale(scale: value, child: child);
          },
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          movieId: moviesList[index].id.toString(),
                        ),
                      ),
                    );
                    getIt.get<HomeScreenViewModel>().getMovieRating(
                      moviesList[index].imdbCode.toString(),
                    );
                  },
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: moviesList[index].mediumCoverImage ?? "",
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(color: AppColor.yellow),
                    ),

                    errorWidget: (context, url, error) => const Icon(
                      Icons.broken_image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              RatingWidget(movieId: moviesList[index].imdbCode ?? '0'),
            ],
          ),
        );
      },
    );
  }
}
