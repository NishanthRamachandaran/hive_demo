import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/task.dart';
import 'providers/task_provider.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => ref.read(tasksProvider.notifier).clearCompleted(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            leading: Checkbox(
              value: task.completed,
              onChanged: (_) => ref.read(tasksProvider.notifier).toggleTask(task.id),
            ),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.completed ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => ref.read(tasksProvider.notifier).deleteTask(task.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Task'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter task...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                ref.read(tasksProvider.notifier).addTask(controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}