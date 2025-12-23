import 'package:flutter/foundation.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _allTasks = [];
  List<TaskModel> _myTasks = [];
  List<TaskModel> _savedTasks = [];
  TaskModel? _selectedTask;
  bool _isLoading = false;
  String? _error;

  // Filter states
  String? _selectedCategory;
  double? _minBudget;
  double? _maxBudget;
  List<String> _selectedSkills = [];

  // Getters
  List<TaskModel> get allTasks => _allTasks;
  List<TaskModel> get myTasks => _myTasks;
  List<TaskModel> get savedTasks => _savedTasks;
  TaskModel? get selectedTask => _selectedTask;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get selectedCategory => _selectedCategory;
  double? get minBudget => _minBudget;
  double? get maxBudget => _maxBudget;
  List<String> get selectedSkills => _selectedSkills;

  // Filtered tasks based on current filters
  List<TaskModel> get filteredTasks {
    var tasks = List<TaskModel>.from(_allTasks);

    if (_selectedCategory != null) {
      tasks = tasks.where((task) => task.category == _selectedCategory).toList();
    }

    if (_minBudget != null) {
      tasks = tasks.where((task) => task.budget >= _minBudget!).toList();
    }

    if (_maxBudget != null) {
      tasks = tasks.where((task) => task.budget <= _maxBudget!).toList();
    }

    if (_selectedSkills.isNotEmpty) {
      tasks = tasks.where((task) {
        return task.requiredSkills.any((skill) => _selectedSkills.contains(skill));
      }).toList();
    }

    return tasks;
  }

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

  // Fetch all available tasks
  Future<void> fetchAllTasks() async {
    _setLoading(true);
    _setError(null);

    try {
      // TODO: Fetch from Supabase when connected
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock tasks data
      _allTasks = [
        TaskModel(
          id: 'task-1',
          title: 'Build a Mobile E-commerce App',
          description: 'Need a Flutter developer to build a full-featured e-commerce mobile app with payment integration.',
          type: TaskType.tender,
          category: 'Mobile Development',
          budget: 5000,
          status: TaskStatus.open,
          clientId: 'client-1',
          clientName: 'Tech Startup Inc.',
          requiredSkills: ['Flutter', 'Firebase', 'Payment Integration'],
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          deadline: DateTime.now().add(const Duration(days: 30)),
        ),
        TaskModel(
          id: 'task-2',
          title: 'UI/UX Design for Fitness App',
          description: 'Looking for a talented UI/UX designer to create modern, engaging designs for a fitness tracking app.',
          type: TaskType.tender,
          category: 'Design',
          budget: 1500,
          status: TaskStatus.open,
          clientId: 'client-2',
          clientName: 'Fitness Solutions',
          requiredSkills: ['UI/UX', 'Figma', 'Mobile Design'],
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          deadline: DateTime.now().add(const Duration(days: 14)),
        ),
        TaskModel(
          id: 'task-3',
          title: '1-Hour Consultation: App Architecture',
          description: 'Need expert advice on app architecture and scalability for a social media platform.',
          type: TaskType.booking,
          category: 'Consulting',
          budget: 150,
          status: TaskStatus.open,
          clientId: 'client-3',
          clientName: 'StartupHub',
          requiredSkills: ['Architecture', 'Scalability', 'Backend'],
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
          availableSlots: [
            DateTime.now().add(const Duration(days: 1, hours: 10)),
            DateTime.now().add(const Duration(days: 2, hours: 14)),
            DateTime.now().add(const Duration(days: 3, hours: 16)),
          ],
        ),
      ];
      
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  // Fetch user's own tasks
  Future<void> fetchMyTasks(String userId) async {
    _setLoading(true);
    _setError(null);

    try {
      // TODO: Fetch from Supabase when connected
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock my tasks data
      _myTasks = [
        TaskModel(
          id: 'my-task-1',
          title: 'Website Redesign',
          description: 'Redesign company website with modern aesthetics',
          type: TaskType.tender,
          category: 'Web Development',
          budget: 3000,
          status: TaskStatus.inProgress,
          clientId: userId,
          clientName: 'My Company',
          requiredSkills: ['Web Design', 'React', 'CSS'],
          createdAt: DateTime.now().subtract(const Duration(days: 15)),
          deadline: DateTime.now().add(const Duration(days: 15)),
        ),
      ];
      
      _setLoading(false);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  // Create a new task
  Future<bool> createTask(TaskModel task) async {
    _setLoading(true);
    _setError(null);

    try {
      // TODO: Create in Supabase when connected
      await Future.delayed(const Duration(seconds: 1));
      
      _myTasks.insert(0, task);
      _allTasks.insert(0, task);
      
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Save/bookmark a task
  Future<bool> toggleSaveTask(String taskId) async {
    try {
      // TODO: Save to Supabase when connected
      await Future.delayed(const Duration(milliseconds: 300));
      
      final taskIndex = _savedTasks.indexWhere((task) => task.id == taskId);
      
      if (taskIndex >= 0) {
        _savedTasks.removeAt(taskIndex);
      } else {
        final task = _allTasks.firstWhere((task) => task.id == taskId);
        _savedTasks.add(task);
      }
      
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // Check if task is saved
  bool isTaskSaved(String taskId) {
    return _savedTasks.any((task) => task.id == taskId);
  }

  // Set selected task for details view
  void setSelectedTask(TaskModel? task) {
    _selectedTask = task;
    notifyListeners();
  }

  // Apply filters
  void setFilters({
    String? category,
    double? minBudget,
    double? maxBudget,
    List<String>? skills,
  }) {
    _selectedCategory = category;
    _minBudget = minBudget;
    _maxBudget = maxBudget;
    _selectedSkills = skills ?? [];
    notifyListeners();
  }

  // Clear all filters
  void clearFilters() {
    _selectedCategory = null;
    _minBudget = null;
    _maxBudget = null;
    _selectedSkills = [];
    notifyListeners();
  }
}
