import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/app_assets.dart';
import '../networking/api_constants.dart';

class CachedImage extends StatelessWidget {
  final bool? loading;
  final String image;
  final BoxFit? fit;
  const CachedImage({
    super.key,
    required this.image,
    this.fit,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '${ApiConstants.apiBaseUrl}/$image',
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => SvgPicture.asset(AppAssets.logoSvg),
      placeholder: loading == true
          ? (context, url) => const Center(child: CircularProgressIndicator())
          : (context, url) {
              return const SizedBox();
            },
      maxWidthDiskCache: 200,
      maxHeightDiskCache: 200,
      memCacheWidth: 100,
      memCacheHeight: 100,
      filterQuality: FilterQuality.low,
    );
  }
}
