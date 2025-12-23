import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userId;
  String? _userEmail;
  String _userRole = 'client'; // 'client' or 'freelancer'
  bool _isLoading = false;
  String? _error;

  // Getters
  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _userId;
  String? get userEmail => _userEmail;
  String get userRole => _userRole;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isClient => _userRole == 'client';
  bool get isFreelancer => _userRole == 'freelancer';

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

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Login with email and password
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _setError(null);

    try {
      // TODO: Implement Supabase authentication when connected
      // For now, mock authentication
      await Future.delayed(const Duration(seconds: 1));
      
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password are required');
      }

      // Mock successful login
      _isAuthenticated = true;
      _userId = 'mock-user-id';
      _userEmail = email;
      
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Sign up with email and password
  Future<bool> signUp(String email, String password, String fullName) async {
    _setLoading(true);
    _setError(null);

    try {
      // TODO: Implement Supabase authentication when connected
      // For now, mock sign up
      await Future.delayed(const Duration(seconds: 1));
      
      if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
        throw Exception('All fields are required');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      // Mock successful sign up
      _isAuthenticated = true;
      _userId = 'mock-new-user-id';
      _userEmail = email;
      
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Set user role (client or freelancer)
  void setUserRole(String role) {
    if (role == 'client' || role == 'freelancer') {
      _userRole = role;
      notifyListeners();
      // TODO: Store role preference in Supabase when connected
    }
  }

  // Toggle between client and freelancer roles
  void toggleUserRole() {
    _userRole = _userRole == 'client' ? 'freelancer' : 'client';
    notifyListeners();
    // TODO: Update role in Supabase when connected
  }

  // Forgot password
  Future<bool> resetPassword(String email) async {
    _setLoading(true);
    _setError(null);

    try {
      // TODO: Implement Supabase password reset when connected
      await Future.delayed(const Duration(seconds: 1));
      
      if (email.isEmpty) {
        throw Exception('Email is required');
      }

      // Mock successful password reset
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    _setLoading(true);
    
    try {
      // TODO: Implement Supabase sign out when connected
      await Future.delayed(const Duration(milliseconds: 500));
      
      _isAuthenticated = false;
      _userId = null;
      _userEmail = null;
      _userRole = 'client';
      
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  // Check authentication status on app start
  Future<void> checkAuthStatus() async {
    _setLoading(true);
    
    try {
      // TODO: Check Supabase session when connected
      await Future.delayed(const Duration(milliseconds: 500));
      
      // For now, mock no active session
      _isAuthenticated = false;
      
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }
}
