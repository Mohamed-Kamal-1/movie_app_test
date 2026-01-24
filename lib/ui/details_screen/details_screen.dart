import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/styles/app_styles.dart';
import 'package:movie_app/ui/details_screen/details_screen_state.dart';
import 'package:movie_app/ui/details_screen/details_screen_view_model.dart';
import 'package:movie_app/ui/details_screen/widgets/details_shimmer_widget.dart';

import 'custom_widget/details_content.dart';

class DetailsScreen extends StatefulWidget {
  final String? movieId;

  const DetailsScreen({super.key, required this.movieId});
  static const String routeName = 'DetailsScreen';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

late DetailsScreenViewModel viewModel;

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = getIt.get<DetailsScreenViewModel>();
    viewModel.getMovieDetailsAndSuggestions(widget.movieId ?? '0');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movieId == '0') {
      return Scaffold(
        body: Center(
          child: Text('Movie ID not provided', style: AppStyles.regular16White),
        ),
      );
    }

    return Scaffold(
      body: BlocProvider<DetailsScreenViewModel>.value(
        value: viewModel,
        child: BlocBuilder<DetailsScreenViewModel, DetailsScreenState>(
          buildWhen: (previous, current) {
            return previous.runtimeType != current.runtimeType ||
                current is MovieDetailsSuccessState ||
                current is DetailsAndSuggestionsSuccessState ||
                current is SuggestionsLoadingState;
          },
          builder: (context, state) {
            if (state is MovieDetailsLoadingState) {
              return const DetailsShimmerWidget();
            }

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

              return DetailsContent(
                movieDetails: movieDetails,
                suggestions: const [],
                viewModel: viewModel,
                isLoadingSuggestions: true,
              );
            }

            if (state is DetailsAndSuggestionsSuccessState) {
              final movieDetails = state.movieDetailsResponse.data?.movie;
              final suggestions =
                  state.movieSuggestionResponse.data?.movies ?? [];

              if (movieDetails == null) {
                return Center(
                  child: Text(
                    'Movie details not found',
                    style: AppStyles.regular16White,
                  ),
                );
              }

              return DetailsContent(
                movieDetails: movieDetails,
                suggestions: suggestions,
                viewModel: viewModel,
                isLoadingSuggestions: false,
              );
            }

            if (state is SuggestionsLoadingState) {
              final movieDetails = state.movieDetailsResponse?.data?.movie;
              final suggestions = const <dynamic>[];

              if (movieDetails == null) {
                return const DetailsShimmerWidget();
              }

              return DetailsContent(
                movieDetails: movieDetails,
                suggestions: suggestions,
                viewModel: viewModel,
                isLoadingSuggestions: true,
              );
            }

            if (state is MovieDetailsErrorState ||
                state is DetailsScreenErrorState) {
              final message = state is MovieDetailsErrorState
                  ? state.message
                  : (state as DetailsScreenErrorState).message;
              return Center(
                child: Text(message, style: AppStyles.regular16White),
              );
            }

            return const DetailsShimmerWidget();
          },
        ),
      ),
    );
  }
}
