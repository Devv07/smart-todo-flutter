import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

enum TaskPriority { low, medium, high, urgent }
enum TaskStatus { pending, inProgress, completed, cancelled, archived }
enum TaskRecurrence { never, daily, weekly, biweekly, monthly, yearly, custom }

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String title,
    String? description,
    required TaskPriority priority,
    required TaskStatus status,
    required DateTime createdAt,
    required DateTime dueDate,
    DateTime? completedAt,
    DateTime? startedAt,
    DateTime? reminderTime,
    @Default([]) List<String> tags,
    @Default([]) List<String> assignedTo,
    String? parentTaskId,
    @Default([]) List<String> subTaskIds,
    @Default(0) int estimatedMinutes,
    @Default(0) int actualMinutes,
    @Default(false) bool isRecurring,
    TaskRecurrence? recurrencePattern,
    @Default(false) bool isNotified,
    String? attachmentUrl,
    String? category,
    @Default(0) double priorityScore,
    required String userId,
    @Default(false) bool isSynced,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
