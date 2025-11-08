import 'package:flutter/material.dart';
import 'package:mini_community_feed_app/main.dart';

// A utility class containing constants and helper functions used across the app.

class HttpConstants {
  static const String postPlaceholderURL =
      'https://gratisography.com/wp-content/uploads/2025/01/gratisography-dog-vacation-800x525.jpg';
  static const String profilePlaceholderURL =
      'https://avatar.iran.liara.run/public/50';
  static const String postsURL = 'https://jsonplaceholder.typicode.com/photos';
  static const String fallbackURL =
      "https://watchdiana.fail/blog/wp-content/themes/koji/assets/images/default-fallback-image.png";

  static const Color primaryTextColor = Colors.black;
  static const Color secondaryTextColor = Colors.black87;

  static const List dummyProfileUrls = [
    "https://randomuser.me/api/portraits/men/1.jpg",
    "https://randomuser.me/api/portraits/women/2.jpg",
    "https://randomuser.me/api/portraits/men/3.jpg",
    "https://randomuser.me/api/portraits/women/4.jpg",
    "https://randomuser.me/api/portraits/men/5.jpg",
    "https://randomuser.me/api/portraits/women/6.jpg",
    "https://randomuser.me/api/portraits/men/7.jpg",
    "https://randomuser.me/api/portraits/women/8.jpg",
    "https://randomuser.me/api/portraits/men/9.jpg",
    "https://randomuser.me/api/portraits/women/10.jpg",
    "https://randomuser.me/api/portraits/men/11.jpg",
    "https://randomuser.me/api/portraits/women/12.jpg",
    "https://randomuser.me/api/portraits/men/13.jpg",
    "https://randomuser.me/api/portraits/women/14.jpg",
    "https://randomuser.me/api/portraits/men/15.jpg",
    "https://randomuser.me/api/portraits/women/16.jpg",
    "https://randomuser.me/api/portraits/men/17.jpg",
    "https://randomuser.me/api/portraits/women/18.jpg",
    "https://randomuser.me/api/portraits/men/19.jpg",
    "https://randomuser.me/api/portraits/women/20.jpg",
  ];
  static const List dummyThumbnailUrls = [
    "https://picsum.photos/id/1015/600/400",
    "https://picsum.photos/id/1025/600/400",
    "https://picsum.photos/id/1035/600/400",
    "https://picsum.photos/id/1043/600/400",
    "https://picsum.photos/id/1059/600/400",
    "https://picsum.photos/id/1062/600/400",
    "https://picsum.photos/id/1074/600/400",
    "https://picsum.photos/id/1084/600/400",
    "https://picsum.photos/id/1080/600/400",
    "https://picsum.photos/id/109/600/400",
    "https://picsum.photos/id/110/600/400",
    "https://picsum.photos/id/111/600/400",
    "https://picsum.photos/id/112/600/400",
    "https://picsum.photos/id/113/600/400",
    "https://picsum.photos/id/114/600/400",
    "https://picsum.photos/id/115/600/400",
    "https://picsum.photos/id/116/600/400",
    "https://picsum.photos/id/117/600/400",
    "https://picsum.photos/id/118/600/400",
    "https://picsum.photos/id/119/600/400",
  ];
}

// Function to show a "Coming Soon" snackbar using the global scaffold messenger key.

void showComingSoonSnackbar() {
  final messenger = rootScaffoldMessengerKey.currentState;
  if (messenger == null) return;

  messenger.showSnackBar(
    SnackBar(
      content: Row(
        children: const [
          Icon(Icons.hourglass_bottom, color: Colors.white),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "🚀 Coming Soon!\nThis feature will be available in future updates.",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: const Duration(seconds: 2),
    ),
  );
}
