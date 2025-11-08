import 'package:flutter/material.dart';
import 'package:mini_community_feed_app/providers/post_provider.dart';
import 'package:mini_community_feed_app/utils/utils.dart';
import 'package:mini_community_feed_app/utils/custom_appbar.dart';
import 'package:mini_community_feed_app/utils/custom_cached_image.dart';
import 'package:provider/provider.dart';

// Post Detail Page with Hero Animation
class PostDetailPage extends StatelessWidget {
  final int postId;
  final String userName;
  final String profilePictureUrl;
  final String postImageUrl;
  final String caption;
  final bool isLiked;
  final VoidCallback onLikePressed;

  const PostDetailPage({
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(isDetailedView: true, title: "Post Details"),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image Section
              Hero(
                tag: 'post-image-$postId',
                child: AppCachedImage(imageUrl: postImageUrl, height: 300),
              ),

              // Post Details Section
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Action Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Consumer<PostProvider>(
                            builder: (context, postProvider, child) {
                              // Like Button with Hero Animation
                              return Hero(
                                tag: 'like-button-$postId',
                                child: IconButton(
                                  icon: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    transitionBuilder: (child, animation) {
                                      return ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      );
                                    },
                                    child: Icon(
                                      postProvider.isPostLiked(postId)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: postProvider.isPostLiked(postId)
                                          ? Colors.red
                                          : Colors.black,
                                      size: 28,
                                    ),
                                  ),
                                  onPressed: onLikePressed,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.comment_outlined, size: 28),
                            onPressed: () {
                              showComingSoonSnackbar();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.share_outlined, size: 28),
                            onPressed: () {
                              showComingSoonSnackbar();
                            },
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.bookmark_border, size: 28),
                            onPressed: () {
                              showComingSoonSnackbar();
                            },
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1),

                    // User Info and Caption
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(profilePictureUrl),
                            backgroundColor: Colors.grey[300],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  caption,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1),

                    // Comments Section
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Comments',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Dummy Comments adding for ui improvements
                          _buildComment('jane_doe', 'Amazing photo! 😍', '2h'),
                          const SizedBox(height: 16),
                          _buildComment('john_smith', 'Love this!', '1h'),
                          const SizedBox(height: 16),
                          _buildComment(
                            'sarah_wilson',
                            'Where was this taken? 📸',
                            '30m',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Comment Input at Bottom
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(profilePictureUrl),
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    showComingSoonSnackbar();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Widget to build individual comments

  Widget _buildComment(String username, String comment, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppCachedImage(
          imageUrl:
              HttpConstants.dummyProfileUrls[username.hashCode %
                  HttpConstants.dummyProfileUrls.length],
          height: 32,
          width: 32,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: '$username ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: comment),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.favorite_border, size: 16, color: Colors.grey[600]),
          onPressed: () {
            showComingSoonSnackbar();
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
