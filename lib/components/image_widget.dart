import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  const NetworkImageWidget({
    Key? key,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.imageUrl,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        fit: fit ?? BoxFit.cover,
        height: height,
        maxHeightDiskCache: 500,
        cacheKey: imageUrl,
        width: width,
        color: color,
        imageUrl: imageUrl!,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: Lottie.asset(
            'assets/images/auth_images/loader.json',
            height: 100,
            width: 100,
          ),
        ),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.black),
      ),
    );
  }
}
