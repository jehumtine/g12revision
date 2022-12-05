import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:g12revision/widgets/app_colors.dart';

import 'package:g12revision/widgets/ui_parameters.dart';

class LoadingShimmers {
  static Widget loadingShimmer(String url) {
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: darkOrangeColor.withOpacity(0.5),
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: url,
              ))),
    );
  }
}
