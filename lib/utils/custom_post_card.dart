import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_community_feed_app/screens/post_detail_view.dart';
import 'package:mini_community_feed_app/utils/utils.dart';
import 'package:mini_community_feed_app/utils/custom_cached_image.dart';

// A reusable PostCard widget to display individual posts in the feed.

class PostCard extends StatelessWidget {
  final int postId;
  final String userName;
  final String profilePictureUrl;
  final String postImageUrl;
  final String caption;
  final bool isLiked;
  final VoidCallback onLikePressed;

  const PostCard({
    super.key,
    required this.postId,
    required this.userName,
    required this.profilePictureUrl,
    required this.postImageUrl,
    required this.caption,
    required this.isLiked,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with profile picture and username
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(
                    HttpConstants.profilePlaceholderURL,
                    errorListener: (p0) {
                      debugPrint(
                        '❌ Failed to load profile picture: ${HttpConstants.profilePlaceholderURL}',
                      );
                    },
                  ),
                  foregroundImage: CachedNetworkImageProvider(
                    profilePictureUrl,
                    errorListener: (p0) {
                      debugPrint(
                        '❌ Failed to load profile picture: $profilePictureUrl',
                      );
                    },
                  ),
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(width: 12),
                Text(
                  userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              caption,
              style: TextStyle(
                color: HttpConstants.secondaryTextColor,
                fontSize: 14,
              ),
            ),
          ),
          // Post Image
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailPage(
                    postId: postId,
                    userName: userName,
                    profilePictureUrl: profilePictureUrl,
                    postImageUrl: postImageUrl,
                    caption: caption,
                    isLiked: isLiked,
                    onLikePressed: onLikePressed,
                  ),
                ),
              );
            },
            child: Hero(
              tag: 'post_image_$postId',
              child: AppCachedImage(
                imageUrl: postImageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Hero(
                  tag: 'like-button-$postId',
                  child: IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        key: ValueKey(isLiked),
                        color: isLiked ? Colors.red : Colors.black,
                      ),
                    ),
                    onPressed: onLikePressed,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: () {
                    showComingSoonSnackbar();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {
                    showComingSoonSnackbar();
                  },
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {
                    showComingSoonSnackbar();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
