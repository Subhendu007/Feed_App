import 'package:flutter/material.dart';
import 'package:mini_community_feed_app/providers/post_provider.dart';
import 'package:mini_community_feed_app/utils/custom_appbar.dart';
import 'package:mini_community_feed_app/utils/custom_post_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(isDetailedView: false, title: 'Feed'),
      body: Consumer<PostProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.posts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Network issue occurred.'),
                  ElevatedButton(
                    onPressed: () => provider.refresh(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.refresh(),
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 200) {
                  // Loading more posts when user is 200px from bottom
                  provider.loadMorePosts();
                }
                return false;
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount:
                    provider.posts.length +
                    (provider.hasMorePosts
                        ? 1
                        : 0), // Adding 1 extra for loading indicator
                separatorBuilder: (_, index) {
                  // Preventing showing separator before loading indicator
                  if (index == provider.posts.length - 1 &&
                      provider.hasMorePosts) {
                    return const SizedBox.shrink();
                  }
                  return const SizedBox(height: 8);
                },
                itemBuilder: (context, index) {
                  // Displaying loading indicator when user reaches the end
                  if (index == provider.posts.length) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: provider.isLoadingMore
                            ? const CircularProgressIndicator()
                            : const SizedBox.shrink(),
                      ),
                    );
                  }

                  final post = provider.posts[index];
                  return PostCard(
                    postId: post.id,
                    userName: "User ${post.id}",
                    profilePictureUrl: post.profileUrl,
                    postImageUrl: post.thumbnailUrl,
                    caption: post.title,
                    isLiked: provider.isPostLiked(post.id),
                    onLikePressed: () => provider.toggleLike(post.id),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
