import 'package:flutter/material.dart';
import 'package:mini_community_feed_app/utils/utils.dart';

// A custom AppBar widget that can be reused across the app.

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isDetailedView;
  const CustomAppBar({
    super.key,
    required this.isDetailedView,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: HttpConstants.primaryTextColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),

      actions: isDetailedView
          ? null
          : [
              IconButton(
                icon: const Icon(Icons.add_box_outlined, color: Colors.black),
                onPressed: () {
                  showComingSoonSnackbar();
                },
                tooltip: 'Create Post',
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.black),
                onPressed: () {
                  showComingSoonSnackbar();
                },
                tooltip: 'Notifications',
              ),
              IconButton(
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.black,
                ),
                onPressed: () {
                  showComingSoonSnackbar();
                },
                tooltip: 'Messages',
              ),
            ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: Colors.grey[300], height: 1),
      ),
    );
  }
}
