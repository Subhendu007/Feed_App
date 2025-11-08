import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_community_feed_app/utils/utils.dart';

// A reusable widget class for displaying Images

class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double? width;
  final BoxFit fit;
  final String? fallbackUrl;
  final BorderRadius? borderRadius;

  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.height = 300,
    this.width,
    this.fit = BoxFit.cover,
    this.fallbackUrl,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final fallback = fallbackUrl ?? HttpConstants.fallbackURL;

    Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width ?? double.infinity,
      height: height,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),

      placeholder: (context, url) => Container(
        width: width ?? double.infinity,
        height: height,
        color: Colors.grey[200],
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      // If the main image fails to load, try loading the fallback image
      errorWidget: (context, url, error) {
        debugPrint('❌ Failed to load image: $url');
        return CachedNetworkImage(
          imageUrl: fallback,
          width: width ?? double.infinity,
          height: height,
          fit: fit,
          placeholder: (context, url) => Container(
            width: width ?? double.infinity,
            height: height,
            color: Colors.grey[200],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: width ?? double.infinity,
            height: height,
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
            ),
          ),
        );
      },
    );

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(6),
      child: image,
    );
  }
}
