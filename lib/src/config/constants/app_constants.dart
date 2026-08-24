class AppConstants {
  // App Info
  static const String appName = 'Smart Todo';
  static const String appVersion = '1.0.0';

  // Durations
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration toastDuration = Duration(seconds: 2);
  static const Duration debounceTime = Duration(milliseconds: 500);

  // Storage Keys
  static const String userPrefsKey = 'user_prefs';
  static const String tasksDbName = 'smart_todo_tasks';
  static const String usersDbName = 'smart_todo_users';

  // API Configuration
  static const int apiTimeoutSeconds = 30;
  static const int maxRetries = 3;

  // Limits
  static const int maxTaskTitleLength = 500;
  static const int maxTaskDescriptionLength = 5000;
  static const int maxTeamMembers = 100;
  static const int maxTasksPerPage = 20;

  // Pomodoro Settings
  static const int defaultPomodoroLength = 25; // minutes
  static const int defaultBreakLength = 5; // minutes
  static const int longBreakLength = 15; // minutes
  static const int sessionsBeforeLongBreak = 4;

  // Notification
  static const int reminderMinutesBefore = 5;
  static const int maxRemindersPerTask = 5;

  // Task Categories
  static const List<String> taskCategories = [
    'Work',
    'Personal',
    'Shopping',
    'Health',
    'Education',
    'Finance',
    'Home',
    'Other',
  ];

  // Priority Levels
  static const List<String> priorityLevels = [
    'Low',
    'Medium',
    'High',
    'Urgent',
  ];
}
