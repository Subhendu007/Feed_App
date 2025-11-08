import 'package:flutter/material.dart';
import 'package:mini_community_feed_app/models/post_model.dart';
import 'package:mini_community_feed_app/services/api_services.dart';
import 'package:mini_community_feed_app/utils/utils.dart';

class PostProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final List<PostModel> _posts = [];
  List<PostModel> _allPosts = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;

  final int _postsPerPage = 10;
  int _currentPage = 0;
  bool _hasMorePosts = true;

  // Tracking liked posts by post ID
  final Set<int> _likedPostIds = {};

  String? _error;
  String? get error => _error;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMorePosts => _hasMorePosts;

  // Checking if a post is liked
  bool isPostLiked(int postId) {
    return _likedPostIds.contains(postId);
  }

  // Toggling the like status
  void toggleLike(int postId) {
    if (_likedPostIds.contains(postId)) {
      _likedPostIds.remove(postId);
    } else {
      _likedPostIds.add(postId);
    }
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    _isLoading = true;
    _error = null;
    _currentPage = 0;
    _posts.clear();
    notifyListeners();

    try {
      // Fetching the api using ApiService
      _allPosts = await _apiService.fetchPosts();

      if (_allPosts.isNotEmpty) {
        //Replacing first 20 profile and thumbnail images with custom one for better ui/ux
        for (
          int i = 0;
          i < _allPosts.length && i < HttpConstants.dummyProfileUrls.length;
          i++
        ) {
          _allPosts[i].profileUrl = HttpConstants.dummyProfileUrls[i];
          _allPosts[i].thumbnailUrl = HttpConstants.dummyThumbnailUrls[i];
        }

        // Loading initial page
        _loadNextPage();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _loadNextPage() {
    // Calculating start and end indices for pagination

    final startIndex = _currentPage * _postsPerPage;
    final endIndex = startIndex + _postsPerPage;

    if (startIndex >= _allPosts.length) {
      _hasMorePosts = false;
      return;
    }
    // Getting the next set of posts
    final newPosts = _allPosts.sublist(
      startIndex,
      endIndex > _allPosts.length ? _allPosts.length : endIndex,
    );

    _posts.addAll(newPosts);
    _currentPage++;
    _hasMorePosts = endIndex < _allPosts.length;
  }

  Future<void> loadMorePosts() async {
    if (_isLoadingMore || !_hasMorePosts) return;

    _isLoadingMore = true;
    notifyListeners();

    // Simulating network delay for better UX
    await Future.delayed(const Duration(milliseconds: 800));

    _loadNextPage();

    _isLoadingMore = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    await fetchPosts();
  }
}
