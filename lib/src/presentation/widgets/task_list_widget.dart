import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/task_model.dart';
import '../../core/providers/app_providers.dart';
import 'task_card_widget.dart';

class TaskListWidget extends ConsumerWidget {
  const TaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    if (currentUser == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.login,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Please login to view tasks',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Implement refresh logic
        await Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader(context, 'Today\'s Tasks'),
          const SizedBox(height: 12),
          _buildTasksList(context, ref, TaskStatus.inProgress),
          const SizedBox(height: 32),
          _buildSectionHeader(context, 'Upcoming Tasks'),
          const SizedBox(height: 12),
          _buildTasksList(context, ref, TaskStatus.pending),
          const SizedBox(height: 32),
          _buildSectionHeader(context, 'Completed Tasks'),
          const SizedBox(height: 12),
          _buildTasksList(context, ref, TaskStatus.completed),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget _buildTasksList(BuildContext context, WidgetRef ref, TaskStatus status) {
    return Column(
      children: [
        // TODO: Implement actual task fetching from Firebase
        TaskCardWidget(
          task: TaskModel(
            id: '1',
            title: 'Sample Task',
            description: 'This is a sample task',
            priority: TaskPriority.high,
            status: status,
            createdAt: DateTime.now(),
            dueDate: DateTime.now().add(const Duration(days: 1)),
            userId: 'user123',
          ),
          onTap: () {
            // TODO: Navigate to task details
          },
          onComplete: () {
            // TODO: Mark task as complete
          },
        ),
      ],
    );
  }
}
