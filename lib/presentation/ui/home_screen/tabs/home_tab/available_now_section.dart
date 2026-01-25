import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/di.dart';
import 'package:movie_app/core/images/app_image.dart';
import 'package:movie_app/extensions/extension.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/hom_screen_state.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/home_screen_view_model.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/home_tab/rating_widget.dart';
import 'package:movie_app/ui/details_screen/details_screen.dart';

import '../../../../../core/colors/app_color.dart';
import '../../../../../core/extention/error_extention.dart';
import '../../widgets/home_shimmer_widget.dart';

class AvailableNowSection extends StatefulWidget {
  const AvailableNowSection({super.key});

  @override
  State<AvailableNowSection> createState() => _AvailableNowSectionState();
}

class _AvailableNowSectionState extends State<AvailableNowSection> {
  final PageController _pageController = PageController(viewportFraction: 0.65);
  final ValueNotifier<int> currentPage = ValueNotifier(0);
  late final HomeScreenViewModel viewModel;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
    currentPage.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<HomeScreenViewModel>();
    _pageController.addListener(() {
      if (_pageController.hasClients && _pageController.page != null) {
        currentPage.value = _pageController.page!.round();
      }
    });

    viewModel.getMoviesList('2025-11-25');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenViewModel, HomeScreenState>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const AvailableNowShimmer();
        }

        if (state is HomeErrorState) {
          return Center(
            child: Text(
              context.getErrorMessage(state.errorMessage),
              style: context.fonts.bodyMedium?.copyWith(color: Colors.red),
            ),
          );
        }

        if (state is HomeSuccessState) {
          return Stack(
            children: [
              ValueListenableBuilder<int>(
                valueListenable: currentPage,
                builder: (context, value, child) {
                  return Positioned.fill(
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: state.moviesList?[value].largeCoverImage ?? "",
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.yellow,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.47, 1],
                    colors: [
                      const Color(0xFF121312).withValues(alpha: 0.45),
                      const Color(0xFF121312).withValues(alpha: 0.6),
                      const Color(0xFF121312).withValues(alpha: 1),
                    ],
                  ),
                ),
              ),

              Column(
                children: [
                  Expanded(child: Image.asset(AppImage.availableNow)),
                  Expanded(
                    flex: 3,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: state.moviesList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double value = 1;
                            if (_pageController.position.haveDimensions) {
                              value = (_pageController.page! - index).abs();
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
                                        MaterialPageRoute(builder: (context) =>
                                            DetailsScreen(
                                                movieId: state.moviesList?[index]
                                                    .id?.toInt() ?? 0),)
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        state
                                            .moviesList?[index]
                                            .mediumCoverImage ??
                                        "",
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColor.yellow,
                                      ),
                                    ),

                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                          Icons.broken_image,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                  ),
                                ),
                              ),

                              // RatingWidget(
                              //   rate: state
                              //       .moviesList?[currentPage.value]
                              //       .rating
                              //       ?.toStringAsFixed(1),
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Flexible(child: Image.asset(AppImage.watchNow)),
                ],
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
