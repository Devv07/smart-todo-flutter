import 'package:flutter/material.dart';
import '../../core/models/task_model.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;
  final VoidCallback onComplete;

  const TaskCardWidget({
    Key? key,
    required this.task,
    required this.onTap,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Checkbox(
          value: task.status == TaskStatus.completed,
          onChanged: (_) => onComplete(),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.status == TaskStatus.completed
                ? TextDecoration.lineThrough
                : null,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  task.description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  _buildPriorityBadge(),
                  const SizedBox(width: 8),
                  _buildDueDateBadge(context),
                ],
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text('Edit'),
              onTap: onTap,
            ),
            PopupMenuItem(
              child: const Text('Delete'),
              onTap: () {
                // TODO: Implement delete
              },
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildPriorityBadge() {
    final colors = {
      TaskPriority.low: Colors.blue,
      TaskPriority.medium: Colors.orange,
      TaskPriority.high: Colors.red,
      TaskPriority.urgent: Colors.red[900],
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors[task.priority]?.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        task.priority.toString().split('.').last.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: colors[task.priority],
        ),
      ),
    );
  }

  Widget _buildDueDateBadge(BuildContext context) {
    final daysUntilDue = task.dueDate.difference(DateTime.now()).inDays;
    Color badgeColor = Colors.green;

    if (daysUntilDue < 0) {
      badgeColor = Colors.red;
    } else if (daysUntilDue == 0) {
      badgeColor = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        daysUntilDue < 0
            ? 'Overdue'
            : daysUntilDue == 0
                ? 'Today'
                : '$daysUntilDue days',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: badgeColor,
        ),
      ),
    );
  }
}
