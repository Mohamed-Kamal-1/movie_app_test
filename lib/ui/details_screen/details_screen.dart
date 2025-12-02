import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/colors/app_color.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/styles/app_styles.dart';
import 'package:movie_app/ui/details_screen/details_screen_state.dart';
import 'package:movie_app/ui/details_screen/details_screen_view_model.dart';
import 'package:movie_app/ui/details_screen/widgets/details_shimmer_widget.dart';
import 'package:movie_app/ui/details_screen/widgets/movie_details_widget.dart';
import 'package:readmore/readmore.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = 'DetailsScreen';

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
          buildWhen: (previous, current) {
            // Only rebuild when state type changes or when we get new data
            return previous.runtimeType != current.runtimeType ||
                current is MovieDetailsSuccessState ||
                current is DetailsAndSuggestionsSuccessState ||
                current is SuggestionsLoadingState;
          },
          builder: (context, state) {
            // Initial loading - show full shimmer
            if (state is MovieDetailsLoadingState) {
              return const DetailsShimmerWidget();
            }

            // Movie details loaded but suggestions still loading
            if (state is MovieDetailsSuccessState) {
              final movieDetails = state.movieDetailsResponse.data?.movie;

              if (movieDetails == null) {
                return Center(
                  child: Text(
                    'Movie details not found',
                    style: AppStyles.regular16White,
                  ),
                );
              }

              return _DetailsContent(
                movieDetails: movieDetails,
                suggestions: const [],
                viewModel: viewModel,
                isLoadingSuggestions: true,
              );
            }

            // Both loaded successfully
            if (state is DetailsAndSuggestionsSuccessState) {
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

              return _DetailsContent(
                movieDetails: movieDetails,
                suggestions: suggestions,
                viewModel: viewModel,
                isLoadingSuggestions: false,
              );
            }

            // Suggestions loading (with movie details already shown)
            if (state is SuggestionsLoadingState) {
              final movieDetails = state.movieDetailsResponse?.data?.movie;
              final suggestions = const <dynamic>[];

              if (movieDetails == null) {
                return const DetailsShimmerWidget();
              }

              return _DetailsContent(
                movieDetails: movieDetails,
                suggestions: suggestions,
                viewModel: viewModel,
                isLoadingSuggestions: true,
              );
            }

            // Error states
            if (state is MovieDetailsErrorState || state is DetailsScreenErrorState) {
              final message = state is MovieDetailsErrorState
                  ? state.message
                  : (state as DetailsScreenErrorState).message;
              return Center(
                child: Text(
                  message,
                  style: AppStyles.regular16White,
                ),
              );
            }

            // Default/Unknown state
            return const DetailsShimmerWidget();
          },
        ),
      ),
    );
  }
}

class _DetailsContent extends StatelessWidget {
  final dynamic movieDetails;
  final List<dynamic> suggestions;
  final DetailsScreenViewModel viewModel;
  final bool isLoadingSuggestions;

  const _DetailsContent({
    required this.movieDetails,
    required this.suggestions,
    required this.viewModel,
    required this.isLoadingSuggestions,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          MovieDetailsWidget(
            movieDetails: movieDetails,
            viewModel: viewModel,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.02),
                if (movieDetails.largeScreenshotImage1 != null ||
                    movieDetails.largeScreenshotImage2 != null ||
                    movieDetails.largeScreenshotImage3 != null) ...[
                   Text('Screen Shots', style: AppStyles.bold24White),
                  SizedBox(height: height * 0.02),
                  if (movieDetails.largeScreenshotImage1 != null)
                    _ScreenshotImage(
                      imageUrl: movieDetails.largeScreenshotImage1!,
                    ),
                  if (movieDetails.largeScreenshotImage2 != null) ...[
                    SizedBox(height: height * 0.015),
                    _ScreenshotImage(
                      imageUrl: movieDetails.largeScreenshotImage2!,
                    ),
                  ],
                  if (movieDetails.largeScreenshotImage3 != null) ...[
                    SizedBox(height: height * 0.015),
                    _ScreenshotImage(
                      imageUrl: movieDetails.largeScreenshotImage3!,
                    ),
                  ],
                  SizedBox(height: height * 0.02),
                ],
                if (isLoadingSuggestions) ...[
                  const SuggestionsShimmerWidget(),
                  SizedBox(height: height * 0.02),
                ] else if (suggestions.isNotEmpty) ...[
                   Text('Similar', style: AppStyles.bold24White),
                  SizedBox(height: height * 0.02),
                  _SimilarMoviesGrid(
                    suggestions: suggestions,
                    width: width,
                    height: height,
                  ),
                  SizedBox(height: height * 0.02),
                ],
                Text('Description', style: AppStyles.bold24White),
                SizedBox(height: height * 0.02),
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
                if (movieDetails.cast != null && movieDetails.cast!.isNotEmpty) ...[
                  SizedBox(height: height * 0.02),
                  Text('Cast', style: AppStyles.bold24White),
                  _CastList(
                    cast: movieDetails.cast!,
                    width: width,
                    height: height,
                  ),
                ],
                if (movieDetails.genres != null && movieDetails.genres!.isNotEmpty) ...[
                  SizedBox(height: height * 0.02),
                  Text('Genres', style: AppStyles.bold24White),
                  SizedBox(height: height * 0.02),
                  _GenresWrap(
                    genres: movieDetails.genres!,
                    width: width,
                    height: height,
                  ),
                ],
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SimilarMoviesGrid extends StatelessWidget {
  final List<dynamic> suggestions;
  final double width;
  final double height;

  const _SimilarMoviesGrid({
    required this.suggestions,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: width * 0.03,
        mainAxisSpacing: height * 0.025,
        childAspectRatio: 1 / 1.6,
      ),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final movie = suggestions[index];
        return _SimilarMovieCard(movie: movie);
      },
    );
  }
}

class _SimilarMovieCard extends StatelessWidget {
  final dynamic movie;

  const _SimilarMovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(8),
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
                    const Icon(Icons.star, color: AppColor.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      movie.rating?.toStringAsFixed(1) ?? "0",
                      style: AppStyles.regular16White.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CastList extends StatelessWidget {
  final List<dynamic> cast;
  final double width;
  final double height;

  const _CastList({
    required this.cast,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cast.length,
      itemBuilder: (context, index) {
        final castMember = cast[index];
        return _CastMemberItem(
          castMember: castMember,
          width: width,
          height: height,
        );
      },
    );
  }
}

class _CastMemberItem extends StatelessWidget {
  final dynamic castMember;
  final double width;
  final double height;

  const _CastMemberItem({
    required this.castMember,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.006),
      padding: const EdgeInsets.all(11),
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
              width: width * 0.15,
              height: height * 0.07,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: AppColor.yellow,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.person,
                color: Colors.white,
                size: 38,
              ),
            ),
          ),
          SizedBox(width: width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
  }
}

class _GenresWrap extends StatelessWidget {
  final List<String> genres;
  final double width;
  final double height;

  const _GenresWrap({
    required this.genres,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: width * 0.03,
      runSpacing: height * 0.015,
      children: genres.map((genre) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.08,
            vertical: height * 0.01,
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
    );
  }
}

class _ScreenshotImage extends StatelessWidget {
  final String imageUrl;

  const _ScreenshotImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: height * 0.2,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: AppColor.yellow),
        ),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.red, size: 38),
      ),
    );
  }
}
