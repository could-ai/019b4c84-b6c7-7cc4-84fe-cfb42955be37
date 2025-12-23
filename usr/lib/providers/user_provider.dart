import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _currentUser;
  List<UserModel> _favorites = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  UserModel? get currentUser => _currentUser;
  List<UserModel> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Set loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Set error
  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  // Fetch current user profile
  Future<void> fetchCurrentUser(String userId) async {
    _setLoading(true);
    _setError(null);

    try {
      // TODO: Fetch from Supabase when connected
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock user data
      _currentUser = UserModel(
        id: userId,
        email: 'user@example.com',
        fullName: 'John Doe',
        role: 'freelancer',
        bio: 'Expert Flutter developer with 5+ years of experience',
        avatarUrl: null,
        skills: ['Flutter', 'Dart', 'UI/UX', 'Firebase'],
        rating: 4.8,
        reviewCount: 127,
        completedTasks: 89,
        badges: ['Verified Pro', 'Top Rated'],
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
      );
      
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  // Update user profile
  Future<bool> updateProfile({
    String? fullName,
    String? bio,
    List<String>? skills,
    String? avatarUrl,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      // TODO: Update in Supabase when connected
      await Future.delayed(const Duration(seconds: 1));
      
      if (_currentUser != null) {
        _currentUser = UserModel(
          id: _currentUser!.id,
          email: _currentUser!.email,
          fullName: fullName ?? _currentUser!.fullName,
          role: _currentUser!.role,
          bio: bio ?? _currentUser!.bio,
          avatarUrl: avatarUrl ?? _currentUser!.avatarUrl,
          skills: skills ?? _currentUser!.skills,
          rating: _currentUser!.rating,
          reviewCount: _currentUser!.reviewCount,
          completedTasks: _currentUser!.completedTasks,
          badges: _currentUser!.badges,
          createdAt: _currentUser!.createdAt,
        );
      }
      
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Fetch favorites (bookmarked freelancers)
  Future<void> fetchFavorites() async {
    _setLoading(true);
    _setError(null);

    try {
      // TODO: Fetch from Supabase when connected
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock favorites data
      _favorites = [
        UserModel(
          id: 'fav-1',
          email: 'sarah@example.com',
          fullName: 'Sarah Chen',
          role: 'freelancer',
          bio: 'UI/UX Designer specializing in mobile apps',
          avatarUrl: null,
          skills: ['UI/UX', 'Figma', 'Adobe XD'],
          rating: 4.9,
          reviewCount: 215,
          completedTasks: 156,
          badges: ['Top Rated'],
          createdAt: DateTime.now().subtract(const Duration(days: 730)),
        ),
      ];
      
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  // Add to favorites
  Future<bool> addToFavorites(String userId) async {
    try {
      // TODO: Add to Supabase when connected
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Mock adding to favorites
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // Remove from favorites
  Future<bool> removeFromFavorites(String userId) async {
    try {
      // TODO: Remove from Supabase when connected
      await Future.delayed(const Duration(milliseconds: 500));
      
      _favorites.removeWhere((user) => user.id == userId);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // Check if user is in favorites
  bool isFavorite(String userId) {
    return _favorites.any((user) => user.id == userId);
  }
}
