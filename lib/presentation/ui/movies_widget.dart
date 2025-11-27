import 'package:flutter/material.dart';
import 'package:movie_app/extensions/extension.dart';

import '../../core/colors/app_color.dart';
import '../../core/images/app_image.dart';

class MoviesWidget extends StatelessWidget {
  final List<String> images = [
    AppImage.leftImage,
    AppImage.midImage,
    AppImage.rightImage,
    AppImage.leftImage,
    AppImage.midImage,
    AppImage.rightImage,
    AppImage.leftImage,
    AppImage.midImage,
    AppImage.rightImage,
    AppImage.leftImage,
    AppImage.midImage,
    AppImage.rightImage,
  ];

  MoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1 / 1.5,
                ),

                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Image.asset(images[index], fit: BoxFit.cover),

                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 13,
                          horizontal: 10.11,
                        ),
                        padding: EdgeInsetsDirectional.all(6),
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColor.black.withAlpha(171),
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        width: 62,
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('7.7', style: context.fonts.titleSmall),
                            Icon(Icons.star, color: AppColor.goldenYellow),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
