import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/styles/app_styles.dart';
import 'package:movie_app/ui/details_screen/details_screen_state.dart';
import 'package:movie_app/ui/details_screen/details_screen_view_model.dart';
import 'package:movie_app/ui/details_screen/widgets/movie_details_widget.dart';
import 'package:readmore/readmore.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = 'DetailsScreen';

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final movieId = args?.toString() ?? '';

    final viewModel = getIt.get<DetailsScreenViewModel>();

    if (movieId.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'Movie ID not provided',
            style: AppStyles.regular16White,
          ),
        ),
      );
    }

    return Scaffold(
      body: BlocProvider<DetailsScreenViewModel>.value(
        value: viewModel..getMovieDetailsAndSuggestions(movieId),
        child: BlocBuilder<DetailsScreenViewModel, DetailsScreenState>(
          builder: (context, state) {
            if (state is DetailsScreenLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: AppColor.yellow),
              );
            } else if (state is DetailsAndSuggestionsSuccessState) {
              final movieDetails = state.movieDetailsResponse.data?.movie;
              final suggestions = state.movieSuggestionResponse.data?.movies ?? [];

              if (movieDetails == null) {
                return Center(
                  child: Text(
                    'Movie details not found',
                    style: AppStyles.regular16White,
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    MovieDetailsWidget(
                      movieDetails: movieDetails,
                      viewModel: viewModel,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02),
                          if (movieDetails.largeScreenshotImage1 != null ||
                              movieDetails.largeScreenshotImage2 != null ||
                              movieDetails.largeScreenshotImage3 != null) ...[
                            Text('Screen Shots', style: AppStyles.bold24White),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02),
                            if (movieDetails.largeScreenshotImage1 != null)
                              _ScreenshotImage(
                                imageUrl: movieDetails.largeScreenshotImage1!,
                              ),
                            if (movieDetails.largeScreenshotImage2 != null) ...[
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.015),
                              _ScreenshotImage(
                                imageUrl: movieDetails.largeScreenshotImage2!,
                              ),
                            ],
                            if (movieDetails.largeScreenshotImage3 != null) ...[
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.015),
                              _ScreenshotImage(
                                imageUrl: movieDetails.largeScreenshotImage3!,
                              ),
                            ],
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02),
                          ],
                          if (suggestions.isNotEmpty) ...[
                            Text('Similar', style: AppStyles.bold24White),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02),
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing:
                                    MediaQuery.of(context).size.width * 0.03,
                                mainAxisSpacing:
                                    MediaQuery.of(context).size.height * 0.025,
                                childAspectRatio: 1 / 1.6,
                              ),
                              itemCount: suggestions.length,
                              itemBuilder: (context, index) {
                                final movie = suggestions[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      DetailsScreen.routeName,
                                      arguments: movie.id.toString(),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: movie.largeCoverImage ??
                                              movie.mediumCoverImage ??
                                              movie.smallCoverImage ??
                                              "",
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.8),
                                                ],
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color: AppColor.yellow,
                                                    size: 16),
                                                SizedBox(width: 4),
                                                Text(
                                                  movie.rating?.toStringAsFixed(1) ??
                                                      "0",
                                                  style: AppStyles.regular16White
                                                      .copyWith(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02),
                          ],
                          Text('Description', style: AppStyles.bold24White),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02),
                          ReadMoreText(
                            movieDetails.descriptionFull?.isNotEmpty == true
                                ? movieDetails.descriptionFull!
                                : 'No Description Available...',
                            trimMode: TrimMode.Line,
                            trimLines: 5,
                            colorClickableText: AppColor.yellow,
                            trimCollapsedText: 'See More',
                            trimExpandedText: ' See Less',
                            moreStyle: AppStyles.regular16Yellow,
                            style: AppStyles.regular16White,
                          ),
                          if (movieDetails.cast != null &&
                              movieDetails.cast!.isNotEmpty) ...[
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02),
                            Text('Cast', style: AppStyles.bold24White),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: movieDetails.cast!.length,
                              itemBuilder: (context, index) {
                                final castMember = movieDetails.cast![index];
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height * 0.006,
                                  ),
                                  padding: EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: AppColor.gray,
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          imageUrl: castMember.urlSmallImage ?? '',
                                          width:
                                              MediaQuery.of(context).size.width * 0.15,
                                          height:
                                              MediaQuery.of(context).size.height * 0.07,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(
                                            color: AppColor.yellow,
                                          ),
                                          errorWidget: (context, url, error) => Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 38,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width * 0.02),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Name: ${castMember.name ?? "N/A"}',
                                              style: AppStyles.regular20White,
                                            ),
                                            Text(
                                              'Character: ${castMember.characterName ?? "N/A"}',
                                              style: AppStyles.regular20White,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                          if (movieDetails.genres != null &&
                              movieDetails.genres!.isNotEmpty) ...[
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02),
                            Text('Genres', style: AppStyles.bold24White),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02),
                            Wrap(
                              spacing: MediaQuery.of(context).size.width * 0.03,
                              runSpacing:
                                  MediaQuery.of(context).size.height * 0.015,
                              children: movieDetails.genres!.map((genre) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width * 0.08,
                                    vertical:
                                        MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.gray,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    genre,
                                    style: AppStyles.regular16White,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is DetailsScreenErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: AppStyles.regular16White,
                ),
              );
            } else {
              return Center(
                child: Text(
                  "Unknown state",
                  style: AppStyles.regular16White,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _ScreenshotImage extends StatelessWidget {
  final String imageUrl;

  const _ScreenshotImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: height * 0.2,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(color: AppColor.yellow),
        ),
        errorWidget: (context, url, error) =>
            Icon(Icons.error, color: Colors.red, size: 38),
      ),
    );
  }
}
