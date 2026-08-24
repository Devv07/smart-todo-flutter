class NLPService {
  static final NLPService _instance = NLPService._internal();

  factory NLPService() {
    return _instance;
  }

  NLPService._internal();

  // Parse natural language task like "Call mom tomorrow at 3 PM"
  ParsedTask parseTaskInput(String input) {
    String title = input;
    DateTime? dueDate;
    String? time;

    // Extract date references
    final datePatterns = {
      'tomorrow': Duration(days: 1),
      'today': Duration(days: 0),
      'next week': Duration(days: 7),
      'next month': Duration(days: 30),
    };

    datePatterns.forEach((pattern, duration) {
      if (input.toLowerCase().contains(pattern)) {
        dueDate = DateTime.now().add(duration);
        title = input.replaceAll(RegExp(pattern, caseSensitive: false), '').trim();
      }
    });

    // Extract time patterns (e.g., "at 3 PM", "at 15:00")
    final timeRegex = RegExp(r'at\s+(\d{1,2})(?::(\d{2}))?\s*(am|pm|AM|PM)?');
    final timeMatch = timeRegex.firstMatch(input);
    if (timeMatch != null) {
      time = timeMatch.group(0);
      title = input.replaceAll(timeMatch.group(0)!, '').trim();
    }

    // Extract priority keywords
    String priority = 'medium';
    if (input.toLowerCase().contains('urgent') ||
        input.toLowerCase().contains('asap') ||
        input.toLowerCase().contains('critical')) {
      priority = 'urgent';
    } else if (input.toLowerCase().contains('important') ||
        input.toLowerCase().contains('high')) {
      priority = 'high';
    } else if (input.toLowerCase().contains('low') ||
        input.toLowerCase().contains('whenever')) {
      priority = 'low';
    }

    return ParsedTask(
      title: title.trim(),
      dueDate: dueDate ?? DateTime.now().add(const Duration(days: 1)),
      priority: priority,
      time: time,
    );
  }

  // Calculate priority score based on urgency
  double calculatePriorityScore({
    required DateTime dueDate,
    required String priority,
    required int estimatedMinutes,
  }) {
    double score = 0;

    // Base score from priority
    final priorityScores = {
      'urgent': 100,
      'high': 75,
      'medium': 50,
      'low': 25,
    };
    score = priorityScores[priority] ?? 50;

    // Urgency based on due date
    final daysUntilDue = dueDate.difference(DateTime.now()).inDays;
    if (daysUntilDue == 0) score += 50;
    if (daysUntilDue == 1) score += 30;
    if (daysUntilDue == 2) score += 15;
    if (daysUntilDue < 0) score += 100; // Overdue

    // Task complexity (estimated time)
    if (estimatedMinutes > 120) score += 20;
    if (estimatedMinutes < 15) score -= 10;

    return score.clamp(0, 100).toDouble();
  }

  // Suggest tasks based on natural language
  List<String> suggestCategories(String taskTitle) {
    final suggestions = <String>[];
    final lowerTitle = taskTitle.toLowerCase();

    if (lowerTitle.contains('work') ||
        lowerTitle.contains('meeting') ||
        lowerTitle.contains('project')) {
      suggestions.add('Work');
    }
    if (lowerTitle.contains('shop') || lowerTitle.contains('buy')) {
      suggestions.add('Shopping');
    }
    if (lowerTitle.contains('health') ||
        lowerTitle.contains('doctor') ||
        lowerTitle.contains('exercise')) {
      suggestions.add('Health');
    }
    if (lowerTitle.contains('home') || lowerTitle.contains('house')) {
      suggestions.add('Home');
    }
    if (lowerTitle.contains('personal')) {
      suggestions.add('Personal');
    }

    return suggestions.isEmpty ? ['Personal'] : suggestions;
  }
}

class ParsedTask {
  final String title;
  final DateTime dueDate;
  final String priority;
  final String? time;

  ParsedTask({
    required this.title,
    required this.dueDate,
    required this.priority,
    this.time,
  });
}
