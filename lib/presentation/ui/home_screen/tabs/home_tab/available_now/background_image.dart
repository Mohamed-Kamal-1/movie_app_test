import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/colors/app_color.dart';
import '../../../../../../domain/model/movie_model.dart';

class BackgroundImage extends StatelessWidget {
  final ValueNotifier<int> currentPage;
  final List<MovieModel> moviesList;

  const BackgroundImage({
    super.key,
    required this.currentPage,
    required this.moviesList,
  });

  @override
  Widget build(BuildContext context) {
    if (moviesList.isEmpty) {
      return const SizedBox.shrink();
    }
    return ValueListenableBuilder<int>(
      valueListenable: currentPage,
      builder: (context, value, child) {
        return Positioned.fill(
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: moviesList[value].smallCoverImage ?? "",
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(color: AppColor.yellow),
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image, size: 40, color: Colors.grey),
          ),
        );
      },
    );
  }
}
